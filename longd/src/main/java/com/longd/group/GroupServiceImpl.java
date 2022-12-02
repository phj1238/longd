package com.longd.group;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class GroupServiceImpl implements GroupService {
	
	@Autowired
	GroupMapper mapper;
	
	
	@Override
	public Map listgroup(GroupVO vo) {
		int groupcount = mapper.countGroup(vo);
		int totalPage = groupcount / vo.getPageRow();
		if (groupcount % vo.getPageRow() > 0) totalPage++;
		
		// 시작인덱스
		int startIdx = (vo.getPage()-1) * vo.getPageRow();
		vo.setStartIdx(startIdx);
		
		List<GroupVO> list = mapper.listgroup(vo);
		
		// 페이징처리
		int endPage = (int)(Math.ceil(vo.getPage()/10.0)*10);
		int startPage = endPage-9;
		if (endPage > totalPage) endPage = totalPage;
		boolean prev = startPage > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;
		
		Map map = new HashMap();
		
		map.put("groupcount", groupcount);
		map.put("totalPage", totalPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("prev", prev);
		map.put("next", next);
		map.put("glist", list);
		
		return map;
	}
	
	// 그룹 체크
	@Override
	public int checkgroup(GroupVO vo) {
		return mapper.checkgroup(vo);
	}
	
	// 그룹 등록
	@Override
	public int insertgroup(GroupVO vo) {
		return mapper.insertgroup(vo);
		
	}
	
	// 회원 찾기
	@Override
	public int searchMember(GroupVO vo) {
		return mapper.searchMember(vo);
	}

	@Override
	public int insertMember(GroupVO vo) {
		return mapper.insertMember(vo);
	}

}
