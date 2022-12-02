package com.longd.map;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;




@Service
public class MapServiceImpl implements MapService {

	@Autowired
	MapMapper mapper;
	
	
	// 그룹 전체 map marker 보여주기 
	@Override
	public Map list(MapVO vo)  {
		
		if(vo.getAddress() != null && !vo.getAddress().equals("")) {
			System.out.println("!null@@@@@");
			
			if(vo.getAddress().equals("경남")) {
				vo.setAddress2("경상남도");
			}
			if(vo.getAddress().equals("경북")) {
				vo.setAddress2("경상북도");
			}
			if(vo.getAddress().equals("전남")) {
				vo.setAddress2("전라남도");
			}
			if(vo.getAddress().equals("전북")) {
				vo.setAddress2("전라북도");
			}
			if(vo.getAddress().equals("충북")) {
				vo.setAddress2("충청북도");
			}
			if(vo.getAddress().equals("충남")) {
				vo.setAddress2("충청남도");
			}
			
		} else {
			System.out.println("null@@@@@");
		}
		
		List<MapVO> list = mapper.list(vo);
		List<MapVO> filelist = mapper.fileList(vo);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for (int i = 0; i < list.size(); i++) {
			try {
				list.get(i).setCreationtime(sdf.format(Long.parseLong(list.get(i).getCreationtime())));
				System.out.println("time + "+ list.get(i).getCreationtime());
			} catch (Exception e) {
				try {
					Date time = sdf.parse(list.get(i).getCreationtime());
					list.get(i).setCreationtime(sdf.format(time));
					System.out.println("time2222222222 + "+ list.get(i).getCreationtime());
				} catch (ParseException e1) {
					e1.printStackTrace();
					System.out.println("완전실패 +");
				}
			}
		}
		
		Map map = new HashMap();
		map.put("list", list);
		map.put("filelist", filelist);
		
		return map;
	}

	// map content 작성 페이지
	@Override
	public MapVO write(MapVO vo) {
		return mapper.write(vo);
	}

	// map List 목록
	@Override
	public Map mapList(MapVO vo) {
		// 로그인 후 니까 vo 에 user_no 컨트롤러에서 set해서 넘어옴 
		int totalCount = mapper.mapListcount(vo);
		// 총 페이지 수
		int totalPage = totalCount / vo.getPageRow();
		if (totalCount % vo.getPageRow() > 0) totalPage++;
		
		System.out.println("pagerow : "+vo.getPageRow());
		
		int startIdx = (vo.getPage() -1) * vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<MapVO> list = mapper.mapList(vo);

		// 페이징 처리
		int endPage = (int)(Math.ceil(vo.getPage()/ 10.0)* vo.getPageRow());
		int startPage = endPage-9;
		
		if (endPage > totalPage) endPage = totalPage;
		boolean prev = startIdx > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;

		Map map = new HashMap();
		map.put("list", list);
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("prev", prev);
		map.put("next", next);
		
		System.out.println("totalCount : "+totalCount+" totalPage : "+totalPage+": startPage :"+startPage+" endPage : "+ endPage+ "page: "+ vo.getPage());
		
		return map;
	}
	// map content 저장하고 content_no 가져오기
	@Override
	public int insertContent(MapVO vo) {
		int no = mapper.insertContent(vo);
		no = vo.getContent_no();
		System.out.println("content insert 하고 나서의 content_no : "+ no);
		return no;
	}
	// map content 저장
	@Override
	public int insertFile(MapVO vo) {
		return mapper.insertFile(vo);
	}

	@Override
	public MapVO content(MapVO vo) {
		return mapper.content(vo);
	}

	@Override
	public List<MapVO> contentFile(MapVO vo) {
		return mapper.contentFile(vo);
	}

	@Override
	public int update(MapVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int updateFile(MapVO vo) {
		return mapper.updateFile(vo);
	}

	@Override
	public int deleteFile(MapVO vo) {
		return mapper.deleteFile(vo);
	}

	@Override
	public int insertMap(MapVO vo) {
		int no = mapper.insertMap(vo);
		no = vo.getMap_no();
		System.out.println("map insert 하고 나서의 map_no : "+ no);
		return no;
	}

	@Override
	public int checkMap(MapVO vo) {
		int count = mapper.checkMap(vo);
		
		return count;
	}

	@Override
	public MapVO maptotal(MapVO vo) {
		return mapper.maptotal(vo);
	}

	@Override
	public List<MapVO> dislist(MapVO vo) {
		return mapper.dislist(vo);
	}



}
