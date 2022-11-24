package com.longd.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserMapper mapper;
	
	// 로그인 
	@Override
	public boolean loginCheck(UserVO vo, HttpSession sess) {
		boolean r = false;
		UserVO userInfo = mapper.loginCheck(vo);
		if (userInfo != null) {
			r = true;
			// 로그인 성공시 세션에 저장
			sess.setAttribute("userInfo", userInfo);
		}
		return r;
	}
	
	// 아이디 중복확인
	@Override
	public int checkId(String id) {
		return mapper.checkId(id);
	}
	
	// 닉네임 중복확인
	@Override
	public int checkNick(String nick) {
		return mapper.checkNick(nick);
	}

	// 회원가입
	@Override
	public int join(UserVO vo) {
		return mapper.join(vo);
	}

}
