package com.example.self_board_project.evaluation.controller;

import com.example.self_board_project.evaluation.service.EvaluationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class EvaluationController {
    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    EvaluationService evaluationService;


}
