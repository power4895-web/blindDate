package com.example.self_board_project.relationship.service;

import com.example.self_board_project.notification.service.NotificationService;
import com.example.self_board_project.relationship.mapper.RelationshipMapper;
import com.example.self_board_project.relationship.vo.Relationship;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RelationshipService {
    @Autowired
    RelationshipMapper relationshipMapper;
    @Autowired
    NotificationService notificationService;

    Logger logger = LoggerFactory.getLogger(getClass());
    public List<Relationship> selectRelationshipList(Relationship relationship) {
        return relationshipMapper.selectRelationshipList(relationship);
    }

    public List<Relationship> selectSendRelationshipList(Relationship relationship) {
        return relationshipMapper.selectSendRelationshipList(relationship);
    }
    public List<Relationship> selectAcceptIsYList(Relationship relationship) {
        return relationshipMapper.selectAcceptIsYList(relationship);
    }

    public List<Relationship> selectGetRelationshipList(Relationship relationship) {
        return relationshipMapper.selectGetRelationshipList(relationship);
    }

    public Relationship selectRelationship(Relationship relationship) {
        return relationshipMapper.selectRelationship(relationship);
    }

    public Relationship selectSendRelationship(Relationship relationship) {
        return relationshipMapper.selectSendRelationship(relationship);
    }

    public Relationship selectGetRelationship(Relationship relationship) {
        return relationshipMapper.selectGetRelationship(relationship);
    }

    public Boolean insertRelationship(Relationship relationship) {
        List<Relationship> relationshipList = selectRelationshipList(relationship);
        if (relationshipList.size() > 0) {
            logger.info("친구해요를 이미 보낸적이 있습니다.");
            return false;
        } else {
            logger.info("최초 친구해요를 보냅니다.");
            relationshipMapper.insertRelationship(relationship);
            return true;
        }
    }

    public int allowRelationship(Relationship relationship) {
        Relationship relationshipInfo = selectRelationship(relationship);
        relationship.setId(relationshipInfo.getId());
        relationshipMapper.allowRelationship(relationship);
        return relationshipInfo.getId();
    }
}