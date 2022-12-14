package com.longd.user;

import javax.servlet.http.HttpSession;

public interface UserService {
	// 로그인 체크
	boolean loginCheck(UserVO vo, HttpSession sess);
	// 아이디 중복확인
	int checkId(String id);
	// 닉네임 중복확인
	int checkNick(String nick);
	// 회원 가입
	int join(UserVO vo);

}
