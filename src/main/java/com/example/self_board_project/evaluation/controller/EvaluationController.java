package com.example.self_board_project.evaluation.controller;

import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.evaluation.service.EvaluationService;
import com.example.self_board_project.evaluation.vo.Evaluation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class EvaluationController {
    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    EvaluationService evaluationService;

    @RequestMapping(value = "/evaluation/evaluationList/{type}")
    public String evaluatonList(Model model, HttpServletResponse response, Auth auth, @PathVariable String type) {
        logger.info("friendList Start type: {}" , type);
        logger.info(" auth.getId : {}"+ auth.getId());
        //relationship sendid가 로그인한유저의 list가져오기
        Evaluation evaluation = new Evaluation();
        evaluation.setType(type);
        //보낸사람의 아이디, 받은 사람의 정보를 가져올 떄 ex: 내가 설윤한테 보냄(where에 내 id), 회원정보를 가져오는건 설윤정보필요(join에선 getId)
        if(type.equals("send")) {
            evaluation.setEvaluationId(auth.getId());
            List<Evaluation> evaluationList = evaluationService.selectSendEvaluationList(evaluation);
            model.addAttribute("dataList", evaluationList);
        }
        //받은사람의 아이디, 보낸 사람의 정보를 가져올 때
        if(type.equals("get")) {
            evaluation.setReceiveId(auth.getId());
            List<Evaluation> evaluationList = evaluationService.selectGetEvaluationList(evaluation);
            model.addAttribute("dataList", evaluationList);
        }
        model.addAttribute("type", "evaluation");
        return "friendListAjax";
    }
}
