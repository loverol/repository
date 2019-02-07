package com.rsy.ssm.common.beans;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 设计该类的目的是为了适配 bootstrap-table(包括easyui的datagrid),
 *  他们所需要的数据类型为：
 *  	{"total": 34,
 *       "rows": [{}, {}, {}]
 *      } 
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Datas<T> {
	private long total;  //总数据量
	private List<T> rows; //数据
}
