package com.example.self_board_project.evaluation.service;

import com.example.self_board_project.evaluation.mapper.EvaluationMapper;
import com.example.self_board_project.evaluation.vo.Evaluation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EvaluationService {
    @Autowired
    EvaluationMapper evaluationMapper;

    public List<Evaluation> selectEvaluationList(Evaluation evaluation) {
        return evaluationMapper.selectEvaluationList(evaluation);
    }
    public Evaluation selectEvaluation(Evaluation evaluation) {
        return evaluationMapper.selectEvaluation(evaluation);
    }
    public void insertEvaluation(Evaluation evaluation) {
        evaluationMapper.insertEvaluation(evaluation);
    }

}
