package com.longd.group;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.longd.user.UserVO;


@Controller
@RequestMapping("/group")
public class GroupController {
	
	@Autowired
	GroupService service;
	
	
	@GetMapping("/newGroup.do")
	public String newGroup () {
		return "longd/group/newGroup";
	}
	
	@GetMapping("/listGroup.do")
	public String listGroup(GroupVO vo, Model model, HttpServletRequest req) {
		
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("userInfo");
		
		if (user != null) {
			vo.setUser_no(user.getUser_no());
			System.out.println("@@@@@@@@@@  " + vo.getUser_no());
		}

		model.addAttribute("glist", service.listgroup(vo));
		
		return "longd/group/listGroup";
	}
	
	@PostMapping("/checkgroup.do")
	@ResponseBody
	public int checkgroup(GroupVO vo, Model model, @RequestParam String group_name) {
		vo.setGroup_name(group_name);
		int no = service.checkgroup(vo);
		return no;
	}
	
	// 그룹 만들기
	@PostMapping("/insertgroup.do")
	public String insertgroup (GroupVO vo, Model model) {
		int no = service.insertgroup(vo);
		System.out.println(""+vo.getNick());
		
		String nick[] = vo.getNick().split(",");
		for (int i = 0; i <nick.length; i++) {
			vo.setNick(nick[i]);
			service.insertMember(vo);
			System.out.println("nick[i] : "+ nick[i]);
		}
		
		return "longd/group/listGroup";
//		
//		if(no > 0) {
//			return "longd/map/map";
//		}else {
//			return "redirect:/group/newGroup.do";
//		}
//		
	}
	
	// 회원 찾기
	@PostMapping("/searchMember.do")
	@ResponseBody
	public int searchMember(GroupVO vo, @RequestParam String nick) {
		vo.setNick(nick);
		int no = service.searchMember(vo);
		
		return no;
	}
}
