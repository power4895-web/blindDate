package com.example.self_board_project.core.authority;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.math.BigInteger;

@Getter
@Setter
@ToString
public class Auth implements Serializable {

//	private static final long serialVersionUID = -1540957347729418968L;

	private Integer id;
	private String loginId;
	private String realName;
	private String getnder;
	private String password;

	

}
