package com.example.self_board_project.user.controller;


import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.core.utils.SysUtil;
import com.example.self_board_project.evaluation.service.EvaluationService;
import com.example.self_board_project.evaluation.vo.Evaluation;
import com.example.self_board_project.file.service.FileService;
import com.example.self_board_project.file.vo.FileInfo;
import com.example.self_board_project.notification.service.NotificationService;
import com.example.self_board_project.relationship.service.RelationshipService;
import com.example.self_board_project.relationship.vo.Relationship;
import com.example.self_board_project.user.service.UserService;
import com.example.self_board_project.user.vo.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
//@RestController

public class UserController {

    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private UserService userService;

    @Autowired
    private FileService fileService;
    @Autowired
    private RelationshipService relationshipService;
    @Autowired
    private EvaluationService evaluationService;
    @Autowired
    private NotificationService notificationService;

    /**
     * 회원목록
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/list")
    public String userList(Model model) {
        return "main";
    }

    /**
     * 회원상세
     * 친구리스트에서, 내가 보낸 친구해요일 땐 type이 send
     * @param model
     * @return
     */
    @RequestMapping(value = {"/user/view/{id}/{type}", "/user/view/{id}"})
    public String userView(Model model, Auth auth, @PathVariable int id,  @PathVariable(required = false) String type) {
        logger.info("userView Start");
        logger.info("로그인아이디 : {}", auth.getId() );
        logger.info("조회 아이디 : {}", id );
        logger.info("type : {}", type );
        User user = new User();
        user.setId(id);
        user.setFlag("M");
        User userInfo = userService.selectUser(user);
        model.addAttribute("userInfo", userInfo);

        FileInfo fileInfo = new FileInfo();
        fileInfo.setRefId(id);
        fileInfo.setFlag("user");
        List<FileInfo> fileList = fileService.selectFileList(fileInfo);
        model.addAttribute("fileList", fileList);


        Relationship relationship = new Relationship();
        relationship.setSendId(auth.getId());
        relationship.setGetId(id);
        Relationship relationshipInfo = relationshipService.selectRelationship(relationship);
        model.addAttribute("relationshipInfo", relationshipInfo);
        model.addAttribute("type", type);

        Evaluation evaluation = new Evaluation();
        evaluation.setEvaluationId(auth.getId());
        evaluation.setReceiveId(id);
        Evaluation evaluationInfo = evaluationService.selectEvaluation(evaluation);
        model.addAttribute("evaluationInfo", evaluationInfo);
        model.addAttribute("type", type);
        return "front:user/userView";
    }



    /**
     * 회원수정폼
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "/user/updateForm/{id}", method = RequestMethod.GET)
    public String updateForm(Model model, @PathVariable int id, Auth auth) {
        logger.info("updateForm_id : {}" ,id);
        User user = new User();
        user.setId(id);
        User userInfo = userService.selectUser(user);

        FileInfo fileInfo = new FileInfo();
        fileInfo.setRefId(id);
        fileInfo.setFlag("S");
        List<FileInfo> fileList = fileService.selectFileList(fileInfo);
        model.addAttribute("userInfo", userInfo);
        model.addAttribute("fileList", fileList);
        return "front:user/updateForm";
    }


    /**
     * 회원수정
     * @param model
     * @param user
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/user/update", method = RequestMethod.POST)
    public boolean userUpdate(Model model, User user) {
        userService.updateUser(user);
        return true;
    }


    /**
     * 오늘의 프로필
     * @param model
     * @param response
     * @param auth
     * @return
     */
    @RequestMapping(value = "/user/todayProfile")
    public String todayProfile(Model model, HttpServletResponse response,  Auth auth) {

        logger.info(" todayProfile Start");
        logger.info(" 로그인 Id : {}"+ auth.getId());
        User user = new User();
        user.setId(auth.getId());
        User userInfo = userService.selectUser(user);
        logger.info(" 로그인한 회원 이름 : {}"+ userInfo.getRealName());

        //자신의 대표사진이 없으면 회원수정으로 가기
        String result = goUpdateForm(user, response);
        logger.info("대표사진이 있는 결과 result : {}", result);
        if(result == "true") {
            logger.info("대표사진 존재함");
        }  else {
            return result;
        }
        String ids = userInfo.getTodayProfileId();
        logger.info("todayId: {} " , ids);
        if(ids == null || ids.equals("")) {
            logger.info("todayId가 존재하지 않음 ");
            userService.todayRandom(user);
            userInfo = userService.selectUser(user);
            ids = userInfo.getTodayProfileId();
        }
        String todayIds[] = ids.split(",");
        logger.info("todayIds.length : {}", todayIds.length);
        List<User> dataList = new ArrayList<>();
        for (String item3 : todayIds) {
            User todayUser = new User();
            todayUser.setId(Integer.parseInt(item3));
            User userInfo2 = userService.selectUser(todayUser);
            logger.info(" 오늘의 프로필 이름 :  : {}"+ userInfo.getRealName());

            if(userInfo.getLatitude() != null && userInfo.getLongitude() != null && userInfo2.getLatitude() != null && userInfo2.getLongitude() != null) {
                double distanceKiloMeter = SysUtil.getDistance(userInfo.getLatitude(), userInfo.getLongitude(), userInfo2.getLatitude(), userInfo2.getLongitude());
                userInfo2.setDistance(Math.round(distanceKiloMeter));
                logger.info(" 나와 이성간의 거리 :  : {}" + Math.round(distanceKiloMeter));
            } else {
                logger.info("회원 중 위도, 적도 데이터 없음");
            }

            Relationship relationship = new Relationship();
            relationship.setSendId(auth.getId());
            relationship.setGetId(Integer.parseInt(item3));
            Relationship relationshipInfo = relationshipService.selectRelationship(relationship);

            FileInfo fileInfo = new FileInfo();
            fileInfo.setRefId(Integer.parseInt(item3));
            fileInfo.setDivision("user");
            List<FileInfo> fileList = fileService.selectFileList(fileInfo);
            userInfo2.setFileList(fileList);
            if(relationshipInfo != null) {
                userInfo2.setSendYn("Y");
            } else {
                userInfo2.setSendYn("N");
            }
            dataList.add(userInfo2);
        }
        model.addAttribute("dataList", dataList);
        return "front:user/todayProfile";
    }

    /**
     * 회원카드삭제
     * @param auth
     * @param id
     * @return
     */
    @RequestMapping(value = "/user/deleteUserIds/{id}")
    public boolean deleteUserIds (Auth auth, @PathVariable String id ) {
        logger.info("id : {}", id);
        User user = new User();
        user.setId(auth.getId());
        userService.deleteUserIds(user, id);
        return true;
    }


    /**
     * default는 보낸 표현에서 친구해요
     * @param model
     * @param response
     * @param auth
     * @return
     */
    @RequestMapping(value = "/user/friendList/{flag}")
    public String friendList(Model model, HttpServletResponse response,  Auth auth, @PathVariable String flag) {
        logger.info("friendListForm Start flag : {}", flag);
        model.addAttribute("flag", flag);
//        Notification notification = new Notification();
//        notification.setUserId(auth.getId());
//        notification.setField("relationship");
//        notificationService.updateNotification(notification);
        return "front:user/friendList";
    }

    @RequestMapping(value = "/user/getFriendList")
    @ResponseBody
    public String getFriendList(Model model, HttpServletResponse response,  Auth auth) {
        logger.info("friendListForm Start");
        return "front:user/friendList";
    }


    /**
     * 파일이 등록되어있지 않아서 회원수정으로 다시 가는 메소드
     * @param user
     * @param response
     * @return
     */
    public String goUpdateForm(User user, HttpServletResponse response) {
        logger.info("goUpdateForm");
        user.setFlag("M");
        User userInfo = userService.selectUser(user);
        if(userInfo == null) {
            logger.info("회원수정으로 가기");
//            StringUtil.alert(response, "파일을 등록해주세요");
            return String.format("redirect:/user/updateForm/%s", user.getId());
        }
        //대표파일 없으면 redirect
        if(userInfo.getImgUrl() == null ) {
            logger.info("회원수정으로 가기");
//            StringUtil.alert(response, "파일을 등록해주세요");
            return String.format("redirect:/user/updateForm/%s", userInfo.getId());
        } else {
            return "true";
        }
    }

    @RequestMapping(value = "/user/randomUserList")
    public String randomUserList(User user, Auth auth, Model model,HttpServletResponse response) {

        logger.info("randomUserList");
        user.setId(auth.getId());
        //자신의 대표사진이 없으면 회원수정으로 가기
        String result = goUpdateForm(user, response);
        logger.info("대표사진이 있는 결과 result : {}", result);
        if(result == "true") {
            logger.info("대표사진 존재함");
        }  else {
            return result;
        }

        List<User> randomUserList = userService.randomList(user);
        model.addAttribute("randomUserList", randomUserList);
        return "front:user/randomUserList";
    }
}
