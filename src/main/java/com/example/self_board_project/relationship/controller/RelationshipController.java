package com.example.self_board_project.relationship.controller;

import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.relationship.service.RelationshipService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class RelationshipController {
    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    RelationshipService relationshipService;

    @RequestMapping(value="/user/sendingRelationship")
    @ResponseBody
//    public Boolean sendingRelationship(Auth auth, @RequestBody String hello) {
//    public Boolean sendingRelationship(Auth auth, @RequestBody (value ="aaa") String map) {
//    public Boolean sendingRelationship(Auth auth, @RequestParam (value ="aaa") String map) {
    public Boolean sendingRelationship(Auth auth, @RequestBody Map<String,Object> map) {
        System.out.println("map" + map.get("aaa"));
//        System.out.println("map" + test);
//        System.out.println("map" + map.get("aaa"));
//        logger.info("auth.getid : {}", auth.getId());
//        logger.info("auth.getid : {}", sendIds);
//        logger.info("sendingRelationship_id : {}", relationship.getSendId());
//        relationshipService.insertRelationship(relationship.getSendId());
        return true;

    }

}
