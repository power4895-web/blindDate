package com.example.self_board_project.board.controller;


import com.example.self_board_project.board.service.BoardService;
import com.example.self_board_project.board.vo.Board;
import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.file.vo.FileInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;
import java.util.List;

@Controller
//@RestController

public class BoardController {

    @Autowired
    private BoardService boardService;

    @RequestMapping(value = "/board/list")
    public String boardList(Model model,  Auth auth, Board board, Principal principal) {
        List<Board> boardList = boardService.selectBoardList(board);
        model.addAttribute("boardList", boardList);
        return "board/boardList";
    }
    @RequestMapping(value = "/board/form")
    public String boardForm(Model model, Auth auth, Board board) {
        if(board.getId() != null) {
            Board boardInfo = boardService.selectBoard( board.getId());
            model.addAttribute("boardInfo", boardInfo);
        }
        return "board/boardForm";
    }
    @RequestMapping(value = "/board/view/{id}")
    public String boardView(Model model, Auth auth, Board board, @PathVariable int id) {
        System.out.println(">>boardView" + id);
        Board boardInfo = boardService.selectBoard(id);
        model.addAttribute("boardInfo", boardInfo);
        return "board/boardView";
    }
    @RequestMapping(value = "/board/insert")
    public String boardInsert(Model model, Auth auth, Board board, MultipartFile file, FileInfo fileInfo)throws Exception {
        board.setUserId(auth.getId());
        System.out.println("multipartFile" + file.getOriginalFilename());
        boardService.insertBoard(board, fileInfo, file);
        return "redirect:/board/list";
    }
    @RequestMapping(value = "/board/update")
    public String boardUpdate(Model model, Auth auth, Board board, MultipartFile file) {
        System.out.println("boardId" + board.getId());
        System.out.println("getTitle" + board.getTitle());
        System.out.println("getContent" + board.getContent());
        boardService.updateBoard(board, file);
        return "redirect:/board/list";
    }
    @RequestMapping(value = "/board/delete")
    public String boardDelete(Model model, Auth auth, Board board) {
        System.out.println("boardId" + board.getId());
        boardService.deleteBoard(board);
        return "redirect:/board/list";
    }
}
