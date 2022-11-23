package com.longd.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

	@GetMapping("/longd/main.do")
	public String main() {
		return "/longd/common/main";
	}
	
}
