package com.longd.paging;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PagingVO {
	
	private int page;
	private String stype;
	private String sword;
	
	private int startIdx;
	private int pageRow;
	
	
	public PagingVO() {
		this(1,10);					// 1페이지당 페이지로우 10개?
		
	}

	public PagingVO(int page, int pageRow) {
		this.page = page;
		this.pageRow = pageRow;
	}
	
}
