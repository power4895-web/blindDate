package com.example.self_board_project.file.service;

import com.example.self_board_project.file.mapper.FileMapper;
import com.example.self_board_project.file.vo.FileInfo;
import net.coobird.thumbnailator.ThumbnailParameter;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;
import net.coobird.thumbnailator.name.Rename;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class FileService {

    Logger logger = LoggerFactory.getLogger(getClass());

    private @Value("${file.root.path}") String fileRootPath;
    private @Value("${upload.resource.path}") String uploadResourcePath;
    @Autowired
    FileMapper fileMapper;

    /**
     * 파일 조회
     * @param id
     * @return
     */
    public FileInfo selectFile(String id) {
        return fileMapper.selectFile(id);
    }


    public List<FileInfo> selectFileList(FileInfo fileInfo) {
        FileInfo allFileInfo = new FileInfo();
        allFileInfo.setRefId(fileInfo.getRefId());
        allFileInfo.setDivision(fileInfo.getDivision());
        logger.info("fileService_selectFileList : {}" , allFileInfo.getFlag());
        //모든 파일 가져온 후 대표이미지가 설정되지 않았을 시 가장 먼저 등록된 O , S , M의 bossType을 Y로 update
        List<FileInfo> fileAllList = fileMapper.selectFileList(allFileInfo);
        if(fileAllList.size() > 0) {
            logger.info("모든 파일 개수_fileList.size() : {}", fileAllList.size());
            long bossTypeCountIsY = 0;
//            list.stream().filter(m -> m.getLev() == 0).collect(Collectors.toList());

            bossTypeCountIsY = fileAllList.stream().filter(obj -> obj.getBossType().equals("Y")).count();
            logger.info("bossTypeCountIsY : {}", bossTypeCountIsY);


            if(bossTypeCountIsY  == 0) {
                logger.info("bossTypeCountIsY 0 -> 대표이미지 설정안된 상태 > 현재 회원의 가장 첫번 째 등록한 파일에 대표이미지 설정 UPDATE");
                FileInfo updateFlagInfo = new FileInfo();
                for(int i=0; i<3; i++) {
                    logger.info("fileList.get(1).getId() : {}", fileAllList.get(i).getId());
                    updateFlagInfo.setId(fileAllList.get(i).getId());
                    updateFlagInfo.setBossType("Y");
                    updateFile(updateFlagInfo);
                }
            }
        }

        //회원수정에서 S사이즈 리스트
        fileInfo.setFlag("M");
        List<FileInfo> fileSmallList = fileMapper.selectFileList(fileInfo);
        return fileSmallList;
    }
    public void insertFile(FileInfo fileInfo, List<MultipartFile> files)throws Exception {
        logger.info("service insertFile Start");
        List< FileInfo> list = new ArrayList< FileInfo>();
        String currentDate = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
        String projectPath = fileRootPath + "/"+  currentDate + "/"; //파일업로드 할 위치
        String resourcePathName = uploadResourcePath + "/"+  currentDate + "/"; //DB에 저장할 파일업로드 위치
        String fileFullPath = fileRootPath + uploadResourcePath + "/" + currentDate + "/";

        File folder = new File(fileFullPath);
        if(!folder.isDirectory()) {
            folder.mkdirs();
        }
        logger.info("폴더 생성");
        logger.info("projectPath : {}",projectPath);
        logger.info("resourcePathName : {}",resourcePathName);
        logger.info("resourcePathName : {}",fileFullPath);
        logger.info("files.size() : {}", files.size());

        if (null != files && files.size() > 0) {
            logger.info("files : {}", files);
            int index = 0;
            for(MultipartFile multipartFile : files) {
                logger.info("multipartFile : {}", multipartFile.getOriginalFilename());
                UUID uuid = UUID.randomUUID();
                String filename = uuid + "_" + multipartFile.getOriginalFilename();
                File saveFile = new File(fileFullPath, filename);
                multipartFile.transferTo(saveFile);
                logger.info("transferTo 끝");
                List<Map<String,Object>> imageList = new ArrayList<>();

                
                //현재 대표이미지가 있는지 없는지, 대표 이미지가 있으면 bosstpye을 N으로 insert, 현재 대표이미지가 없으면 Y로
                FileInfo fileInfoY = new FileInfo();
                fileInfoY.setBossType("Y");
                fileInfoY.setRefId(fileInfo.getRefId());
                List<FileInfo> fileInfoList = selectFileList(fileInfoY);

                String bossType = null;
                //등록하려는 파일의 첫번 째 이면서 파일등록이 아직 되어있지 않았을 시 = 최초 등록으로 보고 bossType을 Y로, 그 이외는 다 N
                if(index == 0 && fileInfoList.size() == 0) {
                    bossType = "Y";
                } else {
                    bossType = "N";
                }
                String finalBossType = bossType;
                imageList.add(new HashMap<String, Object>() {

                    {
                        put("name", filename);
                        put("flag", "O");
                        put("bossType", finalBossType);
                    }
                });
                imageList.add(new HashMap<String, Object>() {
                    {
                        put("name", createTumbnail(fileFullPath, filename, 50, 50));
                        put("flag", "XS");
                        put("bossType", finalBossType);
                    }
                });
                imageList.add(new HashMap<String, Object>() {
                    {
                        put("name", createTumbnail(fileFullPath, filename, 200, 200));
                        put("flag", "S");
                        put("bossType", finalBossType);
                    }
                });
                imageList.add(new HashMap<String, Object>() {
                    {
                        put("name", createTumbnail(fileFullPath, filename, 400, 400));
                        put("flag", "M");
                        put("bossType", finalBossType);
                    }
                });
                fileInfo.setSystemFilename(filename);
                fileInfo.setOriginalFilename(multipartFile.getOriginalFilename());
                fileInfo.setFilepath(resourcePathName);

                logger.info("imageList.size() : {}", imageList.size());
                imageList.forEach(obj -> {
                    FileInfo img = new FileInfo();
                    img.setRefId(fileInfo.getRefId());
                    img.setDivision(fileInfo.getDivision());
                    img.setImageName(obj.get("name").toString());
                    img.setFilepath(resourcePathName);
                    img.setFlag(obj.get("flag").toString());
                    img.setBossType(obj.get("bossType").toString());
                    img.setOriginalFilename(multipartFile.getOriginalFilename());
                    img.setSystemFilename(filename);
                    logger.info("fileMapper.insertFile 직전 ");
                    fileMapper.insertFile(img);
                });
                index++;
            }
        }
    }
    //기존 파일업로드 다중
//    public void insertFile(FileInfo fileInfo, List<MultipartFile> files)throws Exception {
//        List< FileInfo> list = new ArrayList< FileInfo>();
//
//        String currentDate = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
//        String projectPath = fileRootPath +  currentDate + "/";
//        String resourcePathName = uploadResourcePath +  currentDate + "/";
//        File folder = new File(projectPath);
//        if(!folder.isDirectory()) {
//            System.out.println("폴더없음");
//            folder.mkdirs();
//        }
//        if (null != files && files.size() > 0) {
//
//            for(MultipartFile multipartFile : files) {
//                UUID uuid = UUID.randomUUID();
//                String filename = uuid + "_" + multipartFile.getOriginalFilename();
//                File saveFile = new File(projectPath, filename);
//                multipartFile.transferTo(saveFile);
//                fileInfo.setSystemFilename(filename);
//                fileInfo.setOriginalFilename(multipartFile.getOriginalFilename());
//                fileInfo.setFilepath(resourcePathName);
//                fileMapper.insertFile(fileInfo);
//            }
//        }
//    }
    public void insertFile2(FileInfo fileInfo, MultipartFile file)throws Exception {
        String projectPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\files";
        UUID uuid = UUID.randomUUID();
        System.out.println("insertFile" + file.getOriginalFilename());
        String filename = uuid + "_" + file.getOriginalFilename();

        File saveFile = new File(projectPath, filename);
        file.transferTo(saveFile);
        fileInfo.setSystemFilename(filename);
        fileInfo.setOriginalFilename(file.getOriginalFilename());
        fileInfo.setFilepath("/files" + projectPath);
        fileMapper.insertFile(fileInfo);

    }


    /**
     * 파일 삭제
     * @param id
     * @return
     */
    public boolean deleteFile(String id) {
        logger.info("deleteFile Mapper Start id {}", id);
        FileInfo fileInfo = selectFile(id);
        logger.info("fileInfoGetId : {}", fileInfo.getId());
        if (fileInfo == null) return false;

        fileMapper.deleteFile(id);
        File f = new File(fileInfo.getFilepath() + fileInfo.getImageName());

        if(f.exists()) f.delete();

        return true;
    }


    /**
     * Thumbnai 생성
     * @param fileName
     * @param width
     * @param height
     * @throws Exception
     */
    private static String createTumbnail(String path, String fileName, int width, int height ) throws Exception {

        File source = new File(path +fileName);
        BufferedImage originalImage = ImageIO.read(source);

        // 원본 이미지의 너비와 높이
        int ow = originalImage.getWidth();
        int oh = originalImage.getHeight();

        // 비율 조정
        if( ow >= oh ) {
            ow = oh;
        } else {
            oh = ow;
        }

        // 계산된 크기로 원본이미지를 가운데에서 crop
        String[] thumbFile = fileName.split("\\.");
        String thumbFileName = thumbFile[0] + "_" + width +"x"+ height + "." +  thumbFile[1];

        Thumbnails.of(source)
                .sourceRegion(Positions.CENTER, ow, oh).size(width, height)
                .toFiles(new File(path), new Rename() {
                    @Override
                    public String apply(String name, ThumbnailParameter param) {
                        return thumbFileName;
                    }
                });
        return thumbFileName;
    }

    public void updateFile(FileInfo fileInfo) {
        fileMapper.updateFile(fileInfo);
    }
}
