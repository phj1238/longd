package com.longd.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserMapper mapper;
	
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

}
