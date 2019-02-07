<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="css/bootstrap.min.css" />
		<script type="text/javascript" src="js/jquery-1.11.1.min.js" ></script>
		<script type="text/javascript" src="js/bootstrap.min.js" ></script>
		<script type="text/javascript">
			$(function() {
				$("#submitBtn").on("click", function() {
					var username = $("#username").val();
					var password = $("#password").val();
					
					if(!username.trim()) {
						$("#errorMsgTip").html("用户名不能为空.");
						$("#errorMsgTip").show();
						return false;
					}
					
					$.ajax({
						url:"login",
						type:"get",
						data: {username:username, password:password},
						dataType:"json",
						success:function(_data) {
							if(_data.success) {
								location.href = "index";
							}else{
								$("#errorMsgTip").html(_data.msg);
								$("#errorMsgTip").show();
							}
						}
					})
					
					return false;
				});
				
				$("#username").focus(function() {
					$("#errorMsgTip").hide();
				})
			});
		</script>
	</head>
	<body>
		<div class="container">
			<div class="row" style="margin-top: 100px;">
				<div class="col-xs-6 col-xs-push-3">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">用户登录</h3>
						</div>
						<div class="panel-body">
							<div id="errorMsgTip" style="display: none;" class="alert alert-danger alert-dismissable">
																
							</div>
							<form>
								<div class="form-group">
									<label for="username">用户名</label>
									<input type="text" name="username" id="username" class="form-control" />
								</div>
								<div class="form-group">
									<label for="password">密码</label>							
									<input type="password" name="pasword" id="password" class="form-control" />
								</div>
								<div class="form-group">
									<input type="checkbox" /> 
									<span style="position: relative; bottom: 2px;">请记住我</span>
								</div>
								<button id="submitBtn" class="btn btn-primary btn-block">登录</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>