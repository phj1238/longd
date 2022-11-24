package com.longd.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
	
	// 로그인 체크
	UserVO loginCheck(UserVO vo);
	// 아이디 중복확인
	int checkId(String id);
	// 닉네임 중복확인
	int checkNick(String nick);
	// 회원가입
	int join(UserVO vo);

}
