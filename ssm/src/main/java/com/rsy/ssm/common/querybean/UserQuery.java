package com.rsy.ssm.common.querybean;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserQuery {
	private String name;
	private String gender;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date beginBirthday;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date endBirthday;
	private Integer companyId;
}
