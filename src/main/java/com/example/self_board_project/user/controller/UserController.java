package com.example.self_board_project.user.controller;


import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.evaluation.service.EvaluationService;
import com.example.self_board_project.evaluation.vo.Evaluation;
import com.example.self_board_project.file.service.FileService;
import com.example.self_board_project.file.vo.FileInfo;
import com.example.self_board_project.relationship.service.RelationshipService;
import com.example.self_board_project.relationship.vo.Relationship;
import com.example.self_board_project.user.service.UserService;
import com.example.self_board_project.user.vo.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/view/{id}")
    public String userView(Model model, Auth auth, @PathVariable int id) {
        logger.info("로그인아이디 : {}", auth.getId() );
        logger.info("조회 아이디 : {}", id );
        User user = new User();
        user.setId(id);
        User userInfo = userService.selectUser(user);
        model.addAttribute("userInfo", userInfo);

        Relationship relationship = new Relationship();
        relationship.setSendId(auth.getId());
        relationship.setGetId(id);
        relationship.setType("get");
        Relationship relationshipInfo = relationshipService.selectRelationship(relationship);
        model.addAttribute("relationshipInfo", relationshipInfo);

        Evaluation evaluation = new Evaluation();
        evaluation.setEvaluationId(auth.getId());
        evaluation.setReceiveId(id);
        evaluation.setType("get");
        Evaluation evaluationInfo = evaluationService.selectEvaluation(evaluation);
        model.addAttribute("evaluationInfo", evaluationInfo);
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

        logger.info(" auth.getId : {}"+ auth.getId());
        User user = new User();
        user.setId(auth.getId());
        User userInfo = userService.selectUser(user);

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
            todayUser.setBossType("B");
            todayUser.setFlag("S");
            User userInfo2 = userService.selectUser(todayUser);
            Relationship relationship = new Relationship();
            relationship.setSendId(auth.getId());
            relationship.setGetId(Integer.parseInt(item3));
            Relationship relationshipInfo = relationshipService.selectRelationship(relationship);
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
     * default는 보낸 표현에서 친구해요
     * @param model
     * @param response
     * @param auth
     * @return
     */
    @RequestMapping(value = "/user/friendList")
    public String friendList(Model model, HttpServletResponse response,  Auth auth) {
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
        User userInfo = userService.selectUser(user);
        //대표파일 없으면 redirect
        if(userInfo.getImgUrl() == null) {
            logger.info("회원수정으로 가기");
//            StringUtil.alert(response, "파일을 등록해주세요");
            return String.format("redirect:/updateForm/%s", userInfo.getId());
        } else {
            return "true";
        }
    }
}
