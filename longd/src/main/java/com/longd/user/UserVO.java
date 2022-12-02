package com.longd.user;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserVO {
	
	
	private int user_no;
	private String id;
	private String pwd;
	private String nick;
	private Timestamp regdate;
	private int postcode;
	private String addr1;
	private String addr2;
}
