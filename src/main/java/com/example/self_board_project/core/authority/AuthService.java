package com.example.self_board_project.core.authority;


import com.example.self_board_project.user.mapper.AuthMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class AuthService  implements UserDetailsService {
	
	@Autowired
	private AuthMapper mapper;

    public UserDetails loadUserByUsername(String loginId) throws UsernameNotFoundException, DataAccessException {
		System.out.println("loadUserByUsername , loginId" + loginId);
    	
		//로그인 정보
		Map<String, String> user = new HashMap<String, String>();
		user.put("loginId", loginId);
		Auth loginInfo = (Auth)mapper.getUserInfo(user);
		System.out.println("loginInfo" + loginInfo.getLoginId());
		//회원 권한
//		if(loginInfo != null) {
//
//			List<String> roleList = new ArrayList<String>();
//			roleList.add("USR");
//			loginInfo.setRoleList(roleList);
//		}

		return new AuthInfo(loginInfo);
    }
    
    
    //로그인 시간 저장
//    public void insertLoginLog(long userId, String ip) {
//    	Map<String, Object>  map = new HashMap<String, Object>();
//    	map.put( "userId", userId);
//    	map.put( "ip", ip);
//		mapper.insertLoginLog(map);
//
//    }
    
    public List<Auth> userList() {
    	List<Auth> userList = mapper.userList();
		
    	return userList;
    }
    
}