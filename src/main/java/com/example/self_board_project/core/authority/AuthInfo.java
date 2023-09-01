package com.example.self_board_project.core.authority;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@SuppressWarnings("serial")
public class AuthInfo implements UserDetails {

	private Auth user;

	public AuthInfo(Auth user) {
		this.user = user;
	}

	public Auth getUser() {
		return user;
	}

	public Collection<GrantedAuthority> getAuthorities() {
		System.out.println("getAuthorities, user.getRole() : " + user);
		System.out.println("getAuthorities, user.getRole() : " + user.getRole());
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add( new SimpleGrantedAuthority( user.getRole()));
//		for(int i = 0; i < user.getRoleList().size(); i++){
//			 authorities.add( new SimpleGrantedAuthority( "ROLE_" + user.getRoleList().get(i).toString()) );
//		}
		return authorities;
	}

	public String getUsername() {
		return user == null ? "" : user.getLoginId();
	}

	public String getPassword() {
		System.out.println("getPassword : user :  " + user );
		//return user == null ? "{noop}" : "{noop}" + user.getPassword(); //평서문읽기
		return user == null ? null : user.getPassword(); //암호화 읽기
	}

	public boolean isAccountNonExpired() {
		return true;
	}

	public boolean isAccountNonLocked() {
		return true;
	}

	public boolean isCredentialsNonExpired() {
		return true;
	}

	public boolean isEnabled() {
		return true;
	}

	@Override
	 public int hashCode() {
		return user.getLoginId().hashCode();
	 }

	@Override
    public boolean equals(Object rhs) {
        if (rhs instanceof AuthInfo) {
            return user.getLoginId().equals(((AuthInfo) rhs).user.getLoginId());
        }
        return false;
    }

	@Override
	public String toString() {
		return "AuthInfo [user=" + user + "]";
	}


//	@Override
//	public <A> A getAttribute(String name) {
//		return OAuth2User.super.getAttribute(name);
//	}
//
//	@Override
//	public String getName() {
//		return null;
//	}
}
