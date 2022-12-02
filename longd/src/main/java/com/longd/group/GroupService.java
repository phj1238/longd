package com.longd.group;

import java.util.List;
import java.util.Map;

public interface GroupService {
	// 그룹 체크
	int checkgroup(GroupVO vo);
	// 그룹 등록
	int insertgroup(GroupVO vo);
	// 회원 찾기
	int searchMember(GroupVO vo);
	
	int insertMember(GroupVO vo);
	
	Map listgroup(GroupVO vo);

}
