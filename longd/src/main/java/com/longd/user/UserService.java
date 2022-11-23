package com.longd.user;

import javax.servlet.http.HttpSession;

public interface UserService {

	boolean loginCheck(UserVO vo, HttpSession sess);

}
