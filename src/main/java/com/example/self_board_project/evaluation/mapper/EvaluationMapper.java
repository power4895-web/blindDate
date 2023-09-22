package com.example.self_board_project.evaluation.mapper;

import com.example.self_board_project.evaluation.vo.Evaluation;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EvaluationMapper {
    public List<Evaluation> selectRelationshipList(Evaluation relationship);
    public Evaluation selectRelationship(Evaluation relationship);
    public void insertRelationship(Evaluation relationship);
}
