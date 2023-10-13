package com.example.self_board_project.evaluation.service;

import com.example.self_board_project.evaluation.mapper.EvaluationMapper;
import com.example.self_board_project.evaluation.vo.Evaluation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EvaluationService {
    @Autowired
    EvaluationMapper evaluationMapper;
    Logger logger = LoggerFactory.getLogger(getClass());

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
            logger.info("평가를 이미 보낸적이 있습니다.");
            return false;
        } else {
            logger.info("평가를 보낸적이없습니다.");
            evaluationMapper.insertEvaluation(evaluation);
            return true;
        }
    }

}
