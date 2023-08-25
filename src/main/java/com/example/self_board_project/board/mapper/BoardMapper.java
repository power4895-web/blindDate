package com.example.self_board_project.board.mapper;

import com.example.self_board_project.board.vo.Board;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Mapper
public interface BoardMapper {
    int  selectBoardCount(Board board);
    public Board selectBoard(int id);
    public void insertBoard(Board board);
    public void updateBoard(Board board, MultipartFile file);
    public void deleteBoard(Board board);
    public List<Board> selectBoardList(Board board);
}
