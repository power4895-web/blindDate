package com.example.self_board_project.evaluation.mapper;

import com.example.self_board_project.evaluation.vo.Evaluation;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EvaluationMapper {
    public List<Evaluation> selectEvaluationList(Evaluation evaluation);
    public List<Evaluation> selectSendEvaluationList(Evaluation evaluation);
    public List<Evaluation> selectGetEvaluationList(Evaluation evaluation);
    public Evaluation selectEvaluation(Evaluation evaluation);
    public Evaluation selectSendEvaluation(Evaluation evaluation);
    public Evaluation selectGetEvaluation(Evaluation evaluation);
    public void insertEvaluation(Evaluation evaluation);
}
