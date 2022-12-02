package com.longd.group;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GroupMapper {
	
	
	//
	List<GroupVO> listgroup(GroupVO vo);
	
	int countGroup(GroupVO vo);
	// 그룹 체크
	int checkgroup(GroupVO vo);
	// 그룹 등록
	int insertgroup(GroupVO vo);
	// 회원 찾기
	int searchMember(GroupVO vo);
	// 멤버 등록
	int insertMember(GroupVO vo);

	
	

}
