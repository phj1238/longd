package com.longd.group;

import java.sql.Timestamp;

import com.longd.paging.PagingVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GroupVO extends PagingVO{
	
	private int group_no;
	private String group_name;
	private int user_no;
	private String nick;
	private int mem_check;
	private int group_check;
	private int group_member_no;
	private Timestamp group_regdate;
	private Timestamp group_member_regdate;
	
}
