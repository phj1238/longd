package com.longd.map;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MapMapper {
	// map marker 리스트
	List<MapVO> list(MapVO vo);
	List<MapVO> fileList(MapVO vo);

	// map list 목록
	List<MapVO> mapList(MapVO vo);
	// map list 목록 총 개수 
	int mapListcount(MapVO vo);

	// map content 작성 페이지
	MapVO write(MapVO vo);
	// map content 등록
	int insertContent(MapVO vo);
	// map content file 등록
	int insertFile(MapVO vo);
	
	// map content ,file 불러오기 - 수정 페이지 
	MapVO content(MapVO vo);
	List<MapVO> contentFile(MapVO vo);
	
	int update(MapVO vo);
	int updateFile(MapVO vo);
	int deleteFile(MapVO vo);
	
	int insertMap(MapVO vo);
	
	int checkMap(MapVO vo);


}
