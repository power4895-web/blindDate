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
    public Relationship selectRelationship(Relationship relationship) {
        return relationshipMapper.selectRelationship(relationship);
    }
    public void insertRelationship(Relationship relationship) {
        System.out.println(relationship.getGetId());
        System.out.println(relationship.getSendId());
        relationshipMapper.insertRelationship(relationship);
    }

}
