package com.example.self_board_project.relationship.controller;

import com.example.self_board_project.chat.service.ChatService;
import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.evaluation.service.EvaluationService;
import com.example.self_board_project.evaluation.vo.Evaluation;
import com.example.self_board_project.notification.service.NotificationService;
import com.example.self_board_project.relationship.service.RelationshipService;
import com.example.self_board_project.relationship.vo.Relationship;
import com.example.self_board_project.room.service.RoomService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class RelationshipController {
    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    RelationshipService relationshipService;
    @Autowired
    EvaluationService evaluationService;
    @Autowired
    NotificationService notificationService;
    @Autowired
    RoomService roomService;
    @Autowired
    ChatService chatService;

    /**
     * 마이페이지 > 친구리스트 (default 받은 친구해요)
     * @param model
     * @param response
     * @param auth
     * @param type
     * @return
     */
    @RequestMapping(value = "/relationship/relationshipList/{type}")
    public String relationshipList(Model model, HttpServletResponse response, Auth auth, @PathVariable String type) {
        logger.info("friendList Start type: {}" , type);
        logger.info(" auth.getId : {}"+ auth.getId());
        //relationship sendid가 로그인한유저의 list가져오기
        Relationship relationship = new Relationship();
        //보낸사람의 아이디, 받은 사람의 정보를 가져올 떄 ex: 내가 설윤한테 보냄(where에 내 id), 회원정보를 가져오는건 설윤정보필요(join에선 getId)
        if(type.equals("send")) {
            relationship.setSendId(auth.getId());
            List<Relationship> relationshipList = relationshipService.selectSendRelationshipList(relationship);
            if(relationshipList.size() != 0) {
                model.addAttribute("relationshipList", relationshipList);
            }
        }
        //받은사람의 아이디, 보낸 사람의 정보를 가져올 때
        if(type.equals("get")) {
            relationship.setGetId(auth.getId());
            List<Relationship> relationshipList = relationshipService.selectGetRelationshipList(relationship);
            if(relationshipList.size() != 0) {
                model.addAttribute("relationshipList", relationshipList);
            }
        }
        model.addAttribute("type", type);
        model.addAttribute("field", "relationship");
        return "friendListAjax";
    }


    /**
     * 친구해요 insert
     * @param relationship
     * @param auth
     * @return
     */
    @RequestMapping(value="/relationship/sendingRelationship")
    @ResponseBody
    public int insertRelationship(Relationship relationship, Auth auth) {
        relationship.setSendId(auth.getId());
        relationship.setAcceptCheck("N");
        Boolean result = relationshipService.insertRelationship(relationship);
        logger.info("relationship 생성된 아이디: {}", relationship.getId());
        logger.info("result: {}", result);
        if(result) {
            return relationship.getId();
        } else {
            return 0;
        }
    }
    /**
     * 친구승낙
     * @param relationship
     * @param auth
     * @return
     */
    @RequestMapping(value="/relationship/allowRelationship")
    @ResponseBody
    public int allowRelationship(Relationship relationship, Auth auth) {
        relationship.setGetId(auth.getId());
        int relationshipId = relationshipService.allowRelationship(relationship);

        relationship.setGetId(relationship.getSendId());
        relationship.setSendId(auth.getId());
        relationship.setAcceptCheck("Y");
        relationshipService.insertRelationship(relationship);

        return relationshipId;
    }

    /**
     * 친구리스트 > 전체태그
     * @param auth
     * @param model
     * @param type
     * @return
     */
    @RequestMapping(value="/relationship/totalFriendList/{type}")
    public String totalSendFriendList(Auth auth, Model model,@PathVariable String type) {
        logger.info("totalSendFriendList Start type : {}", type);

        Relationship relationship = new Relationship();
        Evaluation evaluation = new Evaluation();

        if(type.equals("send")) {
            relationship.setSendId(auth.getId());
            List<Relationship> relationshipList = relationshipService.selectSendRelationshipList(relationship);
            if(relationshipList.size() != 0) {
                model.addAttribute("relationshipList", relationshipList);
            }
            evaluation.setEvaluationId(auth.getId());
            List<Evaluation> evaluationList = evaluationService.selectSendEvaluationList(evaluation);
            if(evaluationList.size() != 0) {
                model.addAttribute("evaluationList", evaluationList);
            }
        }
        //받은사람의 아이디, 보낸 사람의 정보를 가져올 때
        if(type.equals("get")) {
            relationship.setGetId(auth.getId());
            List<Relationship> relationshipList = relationshipService.selectGetRelationshipList(relationship);
            if(relationshipList.size() != 0) {
                model.addAttribute("relationshipList", relationshipList);
            }
            evaluation.setReceiveId(auth.getId());
            List<Evaluation> evaluationList = evaluationService.selectGetEvaluationList(evaluation);
            if(evaluationList.size() != 0) {
                model.addAttribute("evaluationList", evaluationList);
            }
        }
        model.addAttribute("type", type);
        model.addAttribute("field", "total");
        return "friendListAjax";
    }

    /**
     * header에서 채팅 눌렀을 떄 > 서로 relation을 보낸 이력
     * @param auth
     * @param model
     * @return
     */
    @RequestMapping(value="/relationship/exchangeRelationship")
    public String exchangeRelationship(Auth auth, Model model) {
        logger.info("exchangeRelationship Start");
        Relationship relationship = new Relationship();
        relationship.setGetId(auth.getId());
        List<Relationship> relationshipList = relationshipService.selectExchangeRelationshipList(relationship);

        model.addAttribute("exchangeRelationshipList", relationshipList);
        return "front:relationship/exchangeRelationshipList";
    }

}
