package com.longd.map;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.longd.user.UserVO;

import util.MapWrtieApi;



@Controller
@RequestMapping("/map")
public class MapController {
	
	@Autowired
	MapService service;
	
	// 네이버 지도 마커
	@GetMapping("/map.do")
	public String map(MapVO vo, Model model, HttpServletRequest req) {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("userInfo"); 
		
		if (user == null) {
			model.addAttribute("msg","로그인이 필요합니다.");
			model.addAttribute("url", "/longd/user/loginPage.do");
			return "/longd/common/alert";
		}
		
		vo.setUser_no(user.getUser_no());
				
		model.addAttribute("list",service.list(vo));
		return "/longd/map/map";
	}
	
	// 지도 마커 클릭 후 내용 작성 페이지
	@GetMapping("/write.do")
	public String write(MapVO vo, Model model, 
			@RequestParam int map_no) {
		vo.setMap_no(map_no);
		model.addAttribute("list", service.write(vo));
		return "/longd/map/write";
	}
	
	
	// map content 저장
	@PostMapping("/insert.do")
	public String insert(MapVO vo, Model model, MultipartHttpServletRequest  mhsq , HttpServletRequest req
			) throws IllegalStateException, IOException {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("userInfo"); 
		vo.setUser_no(user.getUser_no());

		int no = service.insertContent(vo);
		System.out.println("no : "+ no);

		List<MultipartFile> fileMap = mhsq.getFiles("file");
		System.out.println("사이즈 : " + fileMap.size() + "String : " + fileMap.toString());
		
		for(int i=0; i<fileMap.size(); i++) {
			String org = fileMap.get(i).getOriginalFilename(); 	// 본래 파일명                
			System.out.println("이름 : " + org);
			String ext = org.substring(org.lastIndexOf(".")); // 확장자  구하는거 .jpg 이런거
			String real = new Date().getTime()+ext;	
			
			//파일 저장
			String path = req.getRealPath("/upload/");
			//System.out.println(path);
			File file = new File(path+real);
			try {
				System.out.println("try");
				fileMap.get(i).transferTo(file);
				//System.out.println("@@@@@@@@   :  "+file);
			} catch (Exception e) {
				System.out.println("저장오류" + e);
			}
			
			vo.setContent_no(no);
			vo.setFilename_org(org);
			vo.setFilename_real(real);
			service.insertFile(vo);
		}
		
		return "redirect:/map/map.do";
	}
	
	// map content 수정 페이지
	@GetMapping("/edit.do")
	public String edit (MapVO vo , Model model, @RequestParam int map_no) {
		vo.setMap_no(map_no);
		// 업체명, 주소
		model.addAttribute("mlist", service.write(vo));
		
		// content 내용 , file  
		model.addAttribute("clist", service.content(vo));
		model.addAttribute("flist", service.contentFile(vo));
		
		return "/longd/map/edit";
	}
	
	// 수정 시 파일 삭제
	@PostMapping("/deletefile.do")
	@ResponseBody
	public void deletefile (MapVO vo, Model model, MultipartHttpServletRequest  mhsq ,
			@RequestParam int file_no , @RequestParam String filenam_real
			) throws IllegalStateException, IOException {
		vo.setFile_no(file_no);
		vo.setFilename_real(filenam_real);
		
		service.deleteFile(vo);
	}
	
	// map content 수정 
	@PostMapping("/update.do")
	@ResponseBody
	public String update (MapVO vo, Model model, MultipartHttpServletRequest  mhsq , HttpServletRequest req
			) throws IllegalStateException, IOException {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("userInfo"); 
		vo.setUser_no(user.getUser_no());
		System.out.println("수정");
		// map_no 를 넘겨줄테니까
		service.update(vo);
		
		
		List<MultipartFile> fileMap = mhsq.getFiles("file");
		System.out.println("사이즈 : " + fileMap.size() + "String : " + fileMap.toString());
		
		for(int i=0; i<fileMap.size(); i++) {
			String org = fileMap.get(i).getOriginalFilename(); 	// 본래 파일명                
			System.out.println("이름 : " + org);
			String ext = org.substring(org.lastIndexOf(".")); // 확장자  구하는거 .jpg 이런거
			String real = new Date().getTime()+ext;	
			
			//파일 저장
			String path = req.getRealPath("/upload/");
			//System.out.println(path);
			File file = new File(path+real);
			try {
				System.out.println("try");
				fileMap.get(i).transferTo(file);
				//System.out.println("@@@@@@@@   :  "+file);
			} catch (Exception e) {
				System.out.println("저장오류" + e);
			}
			
			vo.setFilename_org(org);
			vo.setFilename_real(real);
			service.insertFile(vo);
		}
		
		return "redirect:/map/map.do";
	}
	
	
	// 로그인 후 - 지도 리스트
	@RequestMapping("/mapList.do")
	public String mapList(MapVO vo, Model model) {
		model.addAttribute("list", service.mapList(vo));
		return "/longd/map/maplist";
	}
	
	// map 추가 페이지
	@GetMapping("/newMapwrite.do")
	public String newmap () {
		return "/longd/map/newMapwrite";
	}
	
	@GetMapping("/searchMap.do")
	public String seachMap (@RequestParam String sword, Model model) {
		if (sword != null & !"".equals(sword)) {
			String res = MapWrtieApi.getResponse(sword);
			
			ObjectMapper om = new ObjectMapper();  // 담을 행위를 불러옴
			ResponseMapObject ro = new ResponseMapObject(); // 담을 곳
			
			try {
				om.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false );
				ro = om.readValue(res, ResponseMapObject.class);
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			
			model.addAttribute("search", ro.getItems());
			System.out.println(ro.getItems().toString());
		}
		return "longd/map/newMapwrite";
	}
	
	// 새로운 map 등록 페이지
	@GetMapping("/newWrite.do")
	public String newWrite (@RequestParam String px, @RequestParam String py, 
			@RequestParam String roadAddress, @RequestParam String title, 
			MapVO vo , Model model) {
		
		double x = Double.parseDouble(px);
		double y = Double.parseDouble(py);
		
		vo.setAddress(roadAddress);
		System.out.println("vo : " + vo.getAddress());
		System.out.println("vo : " + vo.getTitle());
		vo.setTitle(title);
		vo.setPx(x);
		vo.setPy(y);
		
		model.addAttribute("list", vo);
		
		return "longd/map/newWrite";
	}
	
	@GetMapping("/checkMap.do")
	@ResponseBody
	public int checkMap (@RequestParam String px, @RequestParam String py, @RequestParam String name ,MapVO vo) {
		
		double x = Double.parseDouble(px);
		double y = Double.parseDouble(py);
		vo.setPx(x);
		vo.setPy(y);
		vo.setName(name);
		
		int data = 0;
		int count = service.checkMap(vo);
		
		if (count > 0 ) {
			data = 1;
			return data;
		}else {
			return data;
		}
	}
	
	
	// map 등록 하면서 content추가
	@PostMapping("/newMapinsert.do")
	public String newMapinsert (MapVO vo, Model model, MultipartHttpServletRequest  mhsq , HttpServletRequest req
			) throws IllegalStateException, IOException {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("userInfo"); 
		vo.setUser_no(user.getUser_no());
		
		int map_no = service.insertMap(vo);
		vo.setMap_no(map_no);
		System.out.println("no : "+ map_no);
		
		int content_no = service.insertContent(vo);
		vo.setContent_no(content_no);
		System.out.println("no : "+ content_no);
		
		
		List<MultipartFile> fileMap = mhsq.getFiles("file");
		System.out.println("사이즈 : " + fileMap.size() + "String : " + fileMap.toString());
		
		for(int i=0; i<fileMap.size(); i++) {
			String org = fileMap.get(i).getOriginalFilename(); 	// 본래 파일명                
			System.out.println("이름 : " + org);
			String ext = org.substring(org.lastIndexOf(".")); // 확장자  구하는거 .jpg 이런거
			String real = new Date().getTime()+ext;	
			
			//파일 저장
			String path = req.getRealPath("/upload/");
			//System.out.println(path);
			File file = new File(path+real);
			try {
				System.out.println("try");
				fileMap.get(i).transferTo(file);
				//System.out.println("@@@@@@@@   :  "+file);
			} catch (Exception e) {
				System.out.println("저장오류" + e);
			}
			
			vo.getMap_no();
			vo.setContent_no(content_no);
			vo.setFilename_org(org);
			vo.setFilename_real(real);
			service.insertFile(vo);
		}
		
		return "/longd/common/main";
	}
	
}
