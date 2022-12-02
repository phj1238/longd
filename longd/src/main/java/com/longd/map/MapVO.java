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
	private String address2;
	private String creationtime;
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
	
	private int totalcount;
	private String district_county; 
	private String district_county2; 
	private int district_no;
	
	
	private int dlist_1;
	private int dlist_2;
	private int dlist_3;
	private int dlist_4;
	private int dlist_5;
	private int dlist_6;
	private int dlist_7;
	private int dlist_8;
	private int dlist_9;
	private int dlist_10;
	private int dlist_11;
	private int dlist_12;
	private int dlist_13;
	private int dlist_14;
	private int dlist_15;
	private int dlist_16;
	private int dlist_17;

	private Timestamp content_regdate;
	private String visit_regdate;
	private String content_title;
	
	
	
	public MapVO () {
		this.page = 1;
		this.pageRow = 10;	
	}
	
	
	
	public MapVO (int page, int pageRow) {
		this.page = page;
		this.pageRow = pageRow;
	}
	
	
	
}


