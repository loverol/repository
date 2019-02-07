<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>主页</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-table.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.serializejson.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.min.js"></script>
		<script type="text/javascript">
			$(function() {
				var company = $("#company, #e_company");
				
				$("#endBirthday,#beginBirthday,#e_birthday").datetimepicker({
					format:"yyyy-mm-dd",
					weekStart: 2,   /** 星期的排列 */
					language: "zh-CN",   /* 语言 */
					todayBtn: true,  /* 是否展示今天按钮 */
					minView: 2,   /* 最小的视图，0是分钟，1是小时 */
					maxView: 4    /* 最大视图，4是年，3是月 */
				}); 
				
				$.ajax({
					headers: {"ssm-ajax":"ssm-helloworld"},
					url:"company",
					dataType:"json",
					type:"get",
					success:function(_data) {
						for(var i = 0; i < _data.length; i++) {
							company.append("<option value='" + _data[i].id + "'>" + _data[i].name + "</option>");
						}
					}
				})
				
				/**
				    该方法在编辑的模态窗出现之前调用，在此根据id获取对应的数据, 该方法之所以能被触发，是调用
				    $("#editUserModal").modal("show");	
				 */
				$("#editUserModal").on("shown.bs.modal", function() {
					var selects = $("#dataTable").bootstrapTable("getSelections"); 
					var id = selects[0].id; //获取被选中的数据的id
					$.ajax({
						url:"user/" + id,
						type: "get",
						dataType:"json",
						success: function(_data) {
							$("#e_name").val(_data.name);
							$("#e_email").val(_data.email);
							$("#e_gender").val(_data.gender);
							$("#e_birthday").val(_data.birthday);
							$("#e_company").val(_data.company.id);
							$("#e_id").val(_data.id);
						}
					});
				});
				
				 //该方法是在编辑的模态窗影藏的时候被调用
				 $("#editUserModal").on('hidden.bs.modal', function() {
					  $("#e_name").val("");
					  $("#e_email").val("");
					  $("#e_birthday").val("");
				 }); 
				
				$("#dataTable").bootstrapTable({
					url:"user", //请求的url地址
					striped:true, //各行换色
					method:"get", //请求的方式
					dataType: "json", //返回数据类型
					pageNumber: 1,   //设置首页的页码
					toolbar: "#toolbar", //工具条
					/**
					 * client: http://127.0.0.1:8020/jquery/datas.json?order=asc
					 * 	 数据的格式: [{}, {}, {}]
					 * server: http://127.0.0.1:8020/jquery/datas.json?order=asc&offset=0&limit=10
					 *  数据格式： {total: 23, rows:[{}, {}, {}]}
					 */
					sidePagination: 'server', //在那边分页，枚举值， 有client和server
					pageList: [10, 15, 20, 25],
					pagination: true,  //是否分页
					queryParams: getQueryUserParams,
					columns: [
						{field:"xyz", checkbox:true},  /** 该列的作用是设计checkbox复选框，field名字可以任意定义 */
						{field:"name", align:"center"},
						{field:"gender", align:"center", formatter: function(value) {
							return "F" == value ? "女" : "男";
						}},
						{field:"email", align:"center"},
						{field:"birthday", align:"center"},
						{field:"createTime", align:"center"},
						{field:"updateTime", align:"center"},
						{field:"company.name", align:"center"}
					]
				});
			});
			
			function getQueryUserParams(params) {
				var name = $("#name").val();
				var gender = $("#gender").val();
				var beginBirthday = $("#beginBirthday").val();
				var endBirthday = $("#endBirthday").val();
				var companyId = $("#company").val();
				
				params.name = name;
				params.gender = gender;
				params.beginBirthday = beginBirthday;
				params.endBirthday = endBirthday;
				params.companyId = companyId;
				return params;
			}
			
			function searchUser() {
				/**
				 * 重新加载表格数据
				 */
				$("#dataTable").bootstrapTable("selectPage", 1);	
				return false;
			}
			
			// 清空查询数据
			function clearSearch() {
				$("#name").val("");
				$("#gender").val("-1");
				$("#beginBirthday").val("");
				$("#endBirthday").val("");
				$("#company").val("-1");
				$("#dataTable").bootstrapTable("selectPage", 1);
			}
			
			//删除user
			function deleteUser() {
				//返回所有被选中的数据，类型为数组
				var selects = $("#dataTable").bootstrapTable("getSelections");
				var len = selects.length;
				if(len > 0) {
					if(confirm("是否确定删除选中的数据?")) {
						var ids = []; // 3,4,5,6 
						/**
						 *  ids = [3, 4, 5]; ids.join(",") -> 3,4,5
						 */
						for(var i = 0; i < len; i++) {
							ids.push(selects[i].id);  //将id都放到数组中
						}
						$.ajax({
							url:"user/delete", 
							method: "get",
							dataType: "json",
							data: {ids: ids.join(";")},
							success: function(_data) {
								if(_data.success) {
									$("#dataTable").bootstrapTable("refresh");
								}else {
									alert("删除失败, 请联系管理员.")
								}
							}
						})
					}				
				}else {
					alert("请至少选择一条数据");
				}
			}
			
			//编辑用户
			function showEditModal() {
				var selects = $("#dataTable").bootstrapTable("getSelections");
				if(selects.length == 1) {
					$("#editUserModal").modal("show");				
				}else {
					alert("请选择一条数据.");
				}
			}
			
			function exportFile() {
				/**
				   <form id="form">
						<input type="text" name="username"/>
						<select name="gender">
						
						</select>
				   </form>
				   $("#form").serialize(); username=zhangsan&gender=M
				 */
				location.href="user/export?" + $("#searchForm").serialize();
			}
		</script>
	</head>
	<body>
		<nav class="navbar navbar-static-top navbar-inverse">
			<div class="container-fluid">
				<div class="navbar-header">
					<a href="javascript:;" class="navbar-brand">信息管理系统</a>
				</div>
				<div class="collapse navbar-collapse">
					<ul class="nav navbar-nav navbar-right">
						<li>
							<a href="javascript:;">
								代办事项
								<span class="badge">3</span>
							</a>
						</li>
						<li class="dropdown">
							<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">
								欢迎您，${sessionScope.userInfo.nickname } 
								<i class="caret"></i>
							</a>
							<ul class="dropdown-menu">
								<li>
									<a href="#">退出登录</a>
									<a href="#">重置密码</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<div class="panel-group" id="menu">
			<div class="panel panel-primary border-control">
				<div class="panel-heading border-control">
					<h4>
						<a data-toggle="collapse" data-parent="#menu" href="#systemManager">系统管理</a>
					</h4>
				</div>
				<div class="collapse panel-collapse" id="systemManager">
					<div class="panel-body border-control">
						<ul class="list-group">
							<li class="list-group-item">
								<a href="javascript:;">用户管理</a>
							</li>
							<li class="list-group-item">
								<a href="javascript:;">角色管理</a>
							</li>
							<li class="list-group-item">
								<a href="javascript:;">权限管理</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4>
						<a data-toggle="collapse" data-parent="#menu" href="#companyManager">公司管理</a>
					</h4>
				</div>
				<div class="collapse panel-collapse" id="companyManager">
					<div class="panel-body">
						<ul class="list-group">
							<li class="list-group-item">
								<a href="javascript:;">员工管理</a>
							</li>
							<li class="list-group-item">
								<a href="javascript:;">部门管理</a>
							</li>
							<li class="list-group-item">
								<a href="javascript:;">资产管理</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="content">
			<div class="container-fluid">
				<div class="page-header">
					<h4>用户管理</h4>
				</div>
				<div class="row">
					<form id="searchForm" class="form-inline">
						<div class="form-group">
							<label for="name">用户名: </label>
							<input type="text" name="name" id="name" class="form-control" />
						</div>
						<div class="form-group">
							<label for="company">公司: </label>
							<select name="companyId" id="company" class="form-control">
								<option value="-1">全部</option>
							</select>
						</div>
						<div class="form-group">
							<label for="gender">性别: </label>
							<select name="gender" id="gender" class="form-control">
								<option value="-1">全部</option>
								<option value="F">女</option>
								<option value="M">男</option>
							</select>
						</div>
						<div style="height: 5px;"></div>
						<div class="form-group">
							<label>生&nbsp;&nbsp;&nbsp;&nbsp;日: </label>
							<input type="text" name="beginBirthday" readonly="true" id="beginBirthday" class="form-control" /> - 
							<input type="text" name="endBirthday" readonly="true" id="endBirthday" class="form-control" /> 
						</div> 
						<button onclick="return searchUser()" class="btn btn-success">
							<i class="fa fa-search"></i> 搜索
						</button>
						<button onclick="return clearSearch()" class="btn btn-danger">
							<i class="fa fa-trash"></i> 清空
						</button>
					</form>
				</div>
				<div class="row">
					<table id="dataTable">
						<thead>
							<tr>
								<th></th>
								<th>姓名</th>
								<th>性别</th>
								<th>邮件</th>
								<th>生日</th>
								<th>创建日期</th>
								<th>修改日期</th>
								<th>公司名称</th>
							</tr>
						</thead>
					</table>
					<div class="btn-group btn-group-sm" id="toolbar">
						<button onclick="showEditModal()" class="btn btn-info">
							<i class="fa fa-edit"></i> 编辑
						</button>
						<button class="btn btn-success">
							<i class="fa fa-plus"></i> 添加
						</button>
						<button onclick="deleteUser()" class="btn btn-danger">
							<i class="fa fa-minus"></i> 删除
						</button>
						<button class="btn btn-info">
							<i class="fa fa-upload"></i> 导入
						</button>
						<button onclick="exportFile()" class="btn btn-primary">
							<i class="fa fa-download"></i> 导出
						</button>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="edit.jsp"></jsp:include>
	</body>
</html>