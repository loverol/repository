package com.rsy.ssm.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
	
	public static final String SIMPLE_PATTERN = "yyyy-MM-dd";
	
	public static final String MEDIUM_PATTERN = "yyyy-MM-dd hh:mm:ss";
	
	/**
	 * 将日期转换字符串
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String dataToStr(Date date, String pattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		return sdf.format(date);
	}
}
