package com.longd.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService service;
	
	// 로그인 화면 가기
	@GetMapping("/loginPage.do")
	public String loginPage () {
		return "longd/user/login";
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
		return "longd/user/join";
	}
	
	// 아이디 중복확인
	@ResponseBody
	@PostMapping("/checkId.do")
	public int checkId (UserVO vo , @RequestParam String id) {
		int no = service.checkId(id);
		return no;
	}
	// 닉네임 중복확인
	@ResponseBody
	@PostMapping("/checkNick.do")
	public int checkNick (UserVO vo , @RequestParam String nick) {
		int no = service.checkNick(nick);
		return no;
	}
	
	@PostMapping("/join.do")
	public String join(UserVO vo, Model model) {
		int join = service.join(vo);
		
		if (join > 0) {
			model.addAttribute("msg" , "회원가입을 축하드립니다.");
			model.addAttribute("url", "/longd/longd/main.do");
			return "longd/common/alert";
		}else {
			model.addAttribute("msg" , "회원가입에 실패하였습니다.");
			model.addAttribute("url", "redirect:join.do");			
			return "longd/common/alert";
		}
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
