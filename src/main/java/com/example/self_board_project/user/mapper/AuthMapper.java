package com.example.self_board_project.user.mapper;

import com.example.self_board_project.core.authority.Auth;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;


@Mapper
public interface AuthMapper {
	
	Auth getUserInfo(Map<String, String> user);

	void insertLoginLog(Map<String, Object> userLog);
	
	List<Auth> userList();
	
	
}