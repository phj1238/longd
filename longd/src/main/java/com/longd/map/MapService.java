package com.longd.map;

import java.util.List;
import java.util.Map;

public interface MapService {

	Map list(MapVO vo);

	MapVO write(MapVO vo);

	Map mapList(MapVO vo);

	int insertContent(MapVO vo);
	int insertFile(MapVO vo);

	MapVO content(MapVO vo);
	List<MapVO> contentFile(MapVO vo);

	int update(MapVO vo);
	int updateFile(MapVO vo);
	int deleteFile(MapVO vo);

	int insertMap(MapVO vo);

	int checkMap(MapVO vo);

	MapVO maptotal(MapVO vo);

	List<MapVO> dislist(MapVO vo);


}
