package com.example.self_board_project.file.service;

import com.example.self_board_project.file.mapper.FileMapper;
import com.example.self_board_project.file.vo.FileInfo;
import net.coobird.thumbnailator.ThumbnailParameter;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;
import net.coobird.thumbnailator.name.Rename;
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
        System.out.println("selectFileList");
        return fileMapper.selectFileList(fileInfo);
    }
    public void insertFile(FileInfo fileInfo, List<MultipartFile> files)throws Exception {
        List< FileInfo> list = new ArrayList< FileInfo>();
        String currentDate = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
        String projectPath = fileRootPath +  currentDate + "/";
        String resourcePathName = uploadResourcePath +  currentDate + "/";
        File folder = new File(projectPath);
        if(!folder.isDirectory()) {
            folder.mkdirs();
        }
        if (null != files && files.size() > 0) {

            int index = 0;
            for(MultipartFile multipartFile : files) {
                UUID uuid = UUID.randomUUID();
                String filename = uuid + "_" + multipartFile.getOriginalFilename();
                File saveFile = new File(projectPath, filename);
                multipartFile.transferTo(saveFile);

                List<Map<String,Object>> imageList = new ArrayList<>();

                String bossType = null;
                if(index == 0) {
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
                        put("name", createTumbnail(projectPath, filename, 200, 200));
                        put("flag", "S");
                        put("bossType", finalBossType);
                    }
                });
                imageList.add(new HashMap<String, Object>() {
                    {
                        put("name", createTumbnail(projectPath, filename, 400, 400));
                        put("flag", "M");
                        put("bossType", finalBossType);
                    }
                });
                fileInfo.setSystemFilename(filename);
                fileInfo.setOriginalFilename(multipartFile.getOriginalFilename());
                fileInfo.setFilepath(resourcePathName);

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
        FileInfo fileInfo = selectFile(id);

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


}
