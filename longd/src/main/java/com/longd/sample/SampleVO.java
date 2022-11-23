package com.longd.sample;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class SampleVO {

	private int map_no;
	private Double px;
	private Double py;
	private String name;
	private String displayName;
	private String address;
	private Timestamp regdate;
	
}
