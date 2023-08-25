package com.example.self_board_project.board.service;

import com.example.self_board_project.board.mapper.BoardMapper;
import com.example.self_board_project.board.vo.Board;
import com.example.self_board_project.file.vo.FileInfo;
import com.example.self_board_project.file.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class BoardService {

    @Autowired
    public BoardMapper boardMapper;
    @Autowired
    public FileService fileService;


    public int selectBoardCount(Board board) {
        return boardMapper.selectBoardCount(board);
    }
    public Board selectBoard(int id) {
        return boardMapper.selectBoard(id);
    }
    public List<Board> selectBoardList(Board board) {
        board.setTotalRow(selectBoardCount(board));
        return boardMapper.selectBoardList(board);
    }
    public void insertBoard(Board board, FileInfo fileInfo, MultipartFile file) throws Exception{
        System.out.println("multipartFile" + file.getOriginalFilename());
        fileService.insertFile2(fileInfo, file);
        boardMapper.insertBoard(board);
    }
    public void updateBoard(Board board, MultipartFile file) {
        boardMapper.updateBoard(board, file);
    }
    public void deleteBoard(Board board) {
        boardMapper.deleteBoard(board);
    }
}
