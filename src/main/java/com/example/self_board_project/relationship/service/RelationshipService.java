package com.example.self_board_project.relationship.service;

import com.example.self_board_project.relationship.mapper.RelationshipMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RelationshipService {
    @Autowired
    RelationshipMapper relationshipMapper;

    public String insertRelationship(int sendId) {
        return relationshipMapper.insertRelationship(sendId);
    }

}
