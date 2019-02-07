package com.rsy.poi.test;

import java.util.ArrayList;
import java.util.List;

import com.rsy.ssm.utils.ExportExcel;

public class ExcelExportTest {
	public static void main(String[] args) throws Exception {
		String[] titles = {"名字", "年龄"};
		
		List<Object[]> datas = new ArrayList<>();
		datas.add(new Object[] {"张三", 10});
		datas.add(new Object[] {"李四", 20});
		datas.add(new Object[] {"王五", 30});
		
		ExportExcel export = new ExportExcel("信息", titles, datas);
		
		export.export("D:\\files\\test.xlsx");
	}
}
