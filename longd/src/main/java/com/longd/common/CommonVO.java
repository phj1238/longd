package com.longd.common;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class CommonVO {
	
	protected int page;
	protected int pageRow;
	protected int totalcount;	// 총 게시물수
	protected int totalPage;  // 총 페이지수 
	protected String sword;
	protected String stype;
	protected int startIdx;
}
