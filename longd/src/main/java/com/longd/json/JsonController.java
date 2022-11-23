package com.longd.json;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.longd.sample.SampleVO;


@Controller
public class JsonController {
	
	@GetMapping("/longd/list.do")
	@ResponseBody
	public void a (SampleVO vo , Model model) {
		
	}
}
