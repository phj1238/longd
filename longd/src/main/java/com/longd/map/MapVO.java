package com.longd.map;

import java.sql.Timestamp;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class MapVO {

	private int map_no;
	private Double px;
	private Double py;
	private String name;
	private String displayName;
	private String address;
	private Timestamp regdate;
	private int user_no;
	private int group_no;
	private String marker;
	
	private int content_no;
	private String content;

	private int file_no;
	private String filename_org;
	private String filename_real;
	
	
	private int page;
	private int pageRow;
	private int startIdx;
	private String sword;
	
	
	// 네이버 map api 검색 결과 (items)
	private String title;
	//private String address;  // 지번 주소
	private String roadAddress;  // 도로명 주
	private int mapx;
	private int mapy;
	
	
	
	public MapVO () {
		this.page = 1;
		this.pageRow = 10;	
	}
	
	
	
	public MapVO (int page, int pageRow) {
		this.page = page;
		this.pageRow = pageRow;
	}
	
	
}


