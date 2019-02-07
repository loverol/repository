<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function() {
		$("#e_name").on("focus", function() {
			$("#nameErrorMsg").empty();
		})
		$("#e_email").on("focus", function() {
			$("#emailErrorMsg").empty();
		})
	});

	function editUser(){
		var name =  $("#e_name").val();
		var email = $("#e_email").val();
		var birthday = $("#e_birthday").val();
		
		var nameReg = /^[\u4e00-\u9fa5]{2,6}$/;  //名字为中文2到6个字符
		var emailReg = /^[-a-zA-Z0-9_]{2,}@[a-z0-9A-Z]{2,6}\.[a-zA-Z]{2,5}$/; //校验邮件
		
		var flag = true;
		
		if(!nameReg.test(name)) {
			$("#nameErrorMsg").append('<span class="alert-panel alert alert-danger">用户名不符合规则.</span>');
			flag = false;
		}
		
		if(!emailReg.test(email)) {
			$("#emailErrorMsg").append('<span class="alert-panel alert alert-danger">邮件不符合规则.</span>');
			flag = false;
		}
		
		if("" == birthday) {
			$("#birthdayErrorMsg").append('<span class="alert-panel alert alert-danger">生日不能为空.</span>');
			flag = false;
		}
		
		/**
		   <form id="form">
				<input type="text" name="username"/>
				<select name="gender">
				
				</select>
		   </form>
		   $("#form").serializeJSON(); -> {username:"zhagnsan", gende:"F"}
		 */
		if(flag) {
			$("#editSaveBtn").button('loading');
			$.ajax({
				url: "user",
				type: "post",
				data: $("#editForm").serializeJSON(),
				dataType: "json",
				success: function(_data) {
					if(_data.success) {  //数据更新成功后，需要影藏模态窗，然后拴心数据
						$("#editUserModal").modal("hide");
						$("#editSaveBtn").button("reset");
						$("#dataTable").bootstrapTable("refresh");
					}else {
						$("#editSaveBtn").button("reset");
						alert("更新失败，请联系管理员.");
					}
				}
			})
		}
	}
</script>
<div id="editUserModal" data-backdrop="static" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">编辑用户</h4>
		    </div>
		    <div class="modal-body">
				<form id="editForm" class="form-horizontal">
					<input type="hidden" name="id" id="e_id" />
					<div class="form-group">
						<label class="col-xs-2 control-label">
							姓名: 
						</label>
						<div class="col-xs-6">
							<input id="e_name" name="name" type="text" class="form-control"/>
						</div>
						<div id="nameErrorMsg" class="col-xs-4">
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">
							邮件: 
						</label>
						<div class="col-xs-6">
							<input id="e_email" name="email" type="text" class="form-control"/>
						</div>
						<div id="emailErrorMsg" class="col-xs-4">
							
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">
							生日: 
						</label>
						<div class="col-xs-6">
							<input id="e_birthday" name="birthday" readonly="true" type="text" class="form-control"/>
						</div>
						<div id="birthdayErrorMsg" class="col-xs-4">
							
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">
							性别 : 
						</label>
						<div class="col-xs-6">
							<select id="e_gender" name="gender" class="form-control">
								<option value="M">男</option>
								<option value="F">女</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">
							公司 : 
						</label>
						<div class="col-xs-6">
							<select id="e_company" name="companyId" class="form-control">
							</select>
						</div>
					</div>
				</form>		        
		    </div>
		    <div class="modal-footer">
		        <button type="button"  class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" id="editSaveBtn" data-loading-text="保存中..." onclick="editUser()" class="btn btn-primary">保存</button>
		    </div>
		</div>
	</div>
</div>