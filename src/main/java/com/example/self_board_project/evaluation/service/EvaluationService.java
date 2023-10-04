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
    public List<Evaluation> selectSendEvaluationList(Evaluation evaluation) {
        return evaluationMapper.selectSendEvaluationList(evaluation);
    }
    public List<Evaluation> selectGetEvaluationList(Evaluation evaluation) {
        return evaluationMapper.selectGetEvaluationList(evaluation);
    }
    public Evaluation selectEvaluation(Evaluation evaluation) {
        return evaluationMapper.selectEvaluation(evaluation);
    }
    public Evaluation selectSendEvaluation(Evaluation evaluation) {
        return evaluationMapper.selectSendEvaluation(evaluation);
    }
    public Evaluation selectGetEvaluation(Evaluation evaluation) {
        return evaluationMapper.selectGetEvaluation(evaluation);
    }
    public Boolean insertEvaluation(Evaluation evaluation) {
        List<Evaluation> evaluationList = selectEvaluationList(evaluation);
        if(evaluationList.size()>0) {
            return false;
        } else {
            evaluationMapper.insertEvaluation(evaluation);
            return true;
        }
    }

}
