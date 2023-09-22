package com.example.self_board_project.relationship.controller;

import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.relationship.service.RelationshipService;
import com.example.self_board_project.relationship.vo.Relationship;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RelationshipController {
    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    RelationshipService relationshipService;

    @RequestMapping(value="/user/sendingRelationship")
    @ResponseBody
    public Boolean sendingRelationship(Auth auth, Relationship relationship) {
        logger.info("auth.getid : {}", auth.getId());
//        logger.info("sendingRelationship_id : {}", relationship.getSendId());
        logger.info("sendingRelationship_id : {}", relationship.getGetId());
        relationship.setSendId(auth.getId());
        relationshipService.insertRelationship(relationship);
        return true;

    }

}
