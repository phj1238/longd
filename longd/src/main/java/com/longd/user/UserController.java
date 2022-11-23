package com.longd.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService service;
	
	// 로그인 화면 가기
	@GetMapping("/loginPage.do")
	public String loginPage () {
		return "longd/login/login";
	}
	
	// 로그인
	@PostMapping("/login.do")
	public String login (UserVO vo, HttpSession sess, Model model) {
		if (service.loginCheck(vo, sess)) {
			return "redirect:/longd/main.do";
		} else {
			model.addAttribute("msg", "아이디와 비밀번호를 확인해 주세요");
			return "/longd/common/alert";
		}
	}
	
	// 회원 가입 창
	@GetMapping("/join.do")
	public String join () {
		return "longd/login/join";
	}
	
	// 로그아웃
	@RequestMapping("/logout.do")
	public String logout (HttpServletRequest req, Model model) {
		HttpSession sess = req.getSession();
		sess.invalidate(); // 세션 초기화 ( 세션 객체에 있는 모든 값들이 삭제)
		//sess.removeAttribute("userInfo"); // 세션객체의 해당값만 삭제
		
		model.addAttribute("msg", "로그아웃 되었습니다");
		model.addAttribute("url" , "/longd/user/loginPage.do");
		return "/longd/common/alert";
	}
	
	
}
