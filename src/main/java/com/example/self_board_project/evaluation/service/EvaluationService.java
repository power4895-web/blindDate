package com.example.self_board_project.evaluation.service;

import com.example.self_board_project.evaluation.mapper.EvaluationMapper;
import com.example.self_board_project.evaluation.vo.Evaluation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EvaluationService {
    @Autowired
    EvaluationMapper relationshipMapper;

    public List<Evaluation> selectRelationshipList(Evaluation relationship) {
        return relationshipMapper.selectRelationshipList(relationship);
    }
    public Evaluation selectRelationship(Evaluation relationship) {
        return relationshipMapper.selectRelationship(relationship);
    }
    public void insertRelationship(Evaluation relationship) {
        System.out.println(relationship.getGetId());
        System.out.println(relationship.getSendId());
        relationshipMapper.insertRelationship(relationship);
    }

}
