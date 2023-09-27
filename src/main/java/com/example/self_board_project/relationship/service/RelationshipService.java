package com.example.self_board_project.relationship.service;

import com.example.self_board_project.relationship.mapper.RelationshipMapper;
import com.example.self_board_project.relationship.vo.Relationship;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RelationshipService {
    @Autowired
    RelationshipMapper relationshipMapper;

    public List<Relationship> selectRelationshipList( Relationship relationship) {
        return relationshipMapper.selectRelationshipList(relationship);
    }
    public List<Relationship> selectSendRelationshipList( Relationship relationship) {
        return relationshipMapper.selectSendRelationshipList(relationship);
    }
    public List<Relationship> selectGetRelationshipList( Relationship relationship) {
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
        if(relationshipList.size()>0) {
            return false;
        } else {
            relationshipMapper.insertRelationship(relationship);
            return true;
        }
    }

}
