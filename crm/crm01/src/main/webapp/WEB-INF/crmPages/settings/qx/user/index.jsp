<%@ page import="com.nihao.crm.entityClass.user.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<%
	String path = request.getScheme() + "://" +
	request.getServerName() + ":" +
	request.getServerPort() +
	request.getContextPath() + "/";

	// 获取user对象
	User user = (User) session.getAttribute("userData");
	%>
	<meta charset="UTF-8">
	<base href="<%=path%>"/>
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
        // 给id为createButton按钮添加单击事件
        $("#createButton").click(function(){
            // 打开模态窗口
            $("#createUserModal").modal("show");
        });
		// 页面加载完毕后执行的函数
		$("#submitButton").click(function(){
			// 保存按钮被单击后执行
			// 获取用户输入的登录账号
			var accountName = $("#create-loginActNo")[0].value;
			// 获取用户输入的用户姓名
			var userName = $("#create-username")[0].value;
			// 获取用户输入的账户密码
			var accountPassword = $("#create-loginPwd")[0].value;
			// 获取用户输入的确认账户密码
			var accountConfirmPassword = $("#create-confirmPwd")[0].value;
			// 判断用户名和用户密码不为空
			if(accountName == null || accountPassword == null || accountName == "" || accountPassword == "") {
				window.alert("用户名或密码不能为空");
				$("#createUserModal").modal("show");
				return;
			}
			// 判断用户密码和确认密码是否相同
			if (accountPassword != accountConfirmPassword) {
				// 输出错误信息
				window.alert("输入的用户密码和确认密码不相同");
				$("#createUserModal").modal("show");
				return;
			}
			// 获取用户输入邮箱
			var email = $("#create-email")[0].value;
			// 获取用户输入的账户失效时间
			var expirationTime = $("#create-expireTime")[0].value;
			if(expirationTime != null){
				// 判断用户输入的失效时间是否符合语法规则
				// 定义正则表达式
				var expirationTimeRegRxp = /^[\d]{4}-[\d]{2}-[\d]{2}\s[\d]{2}-[\d]{2}-[\d]{2}$/;
				if (!(expirationTimeRegRxp.test(expirationTime.trim()))) {
					window.alert("失效时间格式不正确");
					$("#createUserModal").modal("show");
					return;
				}
			}
			// 获取用户输入的锁定状态
			var lockStatus = $("#create-lockStatus")[0].value;
			// 判断lockStatus是否为空
			if(lockStatus == null || lockStatus == ""){
				window.alert("锁定状态必须指定");
				$("#createUserModal").modal("show");
				return;
			}
			// 获取用户输入的部门名称
			var deptno = $("#create-org")[0].value;
			// 判断部门是否为空
			if(deptno == null || deptno == ""){
				window.alert("部门不能为空");
				$("#createUserModal").modal("show");
				return;
			}
			// 获取用户输入的ip地址
			var ips = $("#create-allowIps")[0].value;

			// 发起Ajax请求
			$.ajax({
				url : "<%=path%>createAccount.do",   // 发送Ajax请求地址
				dataType : "json",   // 希望获取的数据格式
				data : {
					"accountName" : accountName,
					"accountPassword" : accountPassword,
					"userName" : userName,
					"email" : email,
					"expireTime" : expirationTime,
					"lockState" : lockStatus,
					"deptno" : deptno,
					"allowIps" : ips
				},
				success : function(data){
					if(data.flag == true){
						// 刷新页面
						window.location.replace(window.location.href);
                        // 关闭模态窗口
                        $("#createUserModal").modal("hide");
						return;
					}
                    // 打开模态窗口
                    $("#createUserModal").modal("show");
					window.alert("用户创建失败");
				},
				error : function(){
					window.alert("出现错误");
				}
			})
		});

		// 当账户名输入框失去焦点时, 判断用户名是否不为空
		$("#create-loginActNo").blur(function(){
			// 获取用户输入的登录账号
			var accountName = $("#create-loginActNo")[0].value;
			if(accountName == null || accountName == "") {
				$("#info").html("<font color='red'>用户名不能为空</font>");
			}
		});

		// 当密码输入框失去焦点时, 判断用户输入的密码是否不为空
		$("#create-loginPwd").blur(function(){
			// 获取用户输入的账户密码
			var accountPassword = $("#create-loginPwd")[0].value;
			if(accountPassword == null || accountPassword == "") {
				$("#info").html("<font color='red'>密码不能为空</font>");
			}
		});

		// 当确认密码输入框失去焦点时, 判断用户输入的密码和确认密码是否相等
		$("#create-confirmPwd").blur(function(){
			// 获取用户输入的确认账户密码
			var accountConfirmPassword = $("#create-confirmPwd")[0].value;
			// 获取用户输入的账户密码
			var accountPassword = $("#create-loginPwd")[0].value;
			if (accountPassword != accountConfirmPassword) {
				// 输出错误信息
				$("#info").html("<font color='red'>密码和确认密码不相等</font>");
			}
		});

		// 当失效日期输入框失去焦点时, 判断日期是否符合要求
		$("#create-expireTime").blur(function(){
			// 获取用户输入的账户失效时间
			var expirationTime = $("#create-expireTime")[0].value;
			// 判断用户输入的失效时间是否符合语法规则
			// 定义正则表达式
			var expirationTimeRegRxp = /^[\d]{4}-[\d]{2}-[\d]{2}\s[\d]{2}-[\d]{2}-[\d]{2}$/;
			if (!(expirationTimeRegRxp.test(expirationTime.trim()))) {
				// 输出错误信息
				$("#info").html("<font color='red'>失效日期格式错误</font>");
			}
		});

		// 当部门输入框失去焦点时, 判断部门是否为空
		$("#create-org").blur(function(){
			// 获取用户输入的部门名称
			var deptno = $("#create-org")[0].value;
			if(deptno == null || deptno == ""){
				$("#info").html("<font color='red'>部门不能为空</font>");
			}
		});

		// 当账户名输入框获取焦点时, 清空错误信息
		$("#create-loginActNo").focus(function(){
			clearInfo();
		});

		// 当密码输入框获取焦点时, 清空错误信息
		$("#create-loginPwd").focus(function(){
			clearInfo();
		});

		// 当确认密码框获取焦点时, 清空错误信息
		$("#create-confirmPwd").focus(function(){
			clearInfo();
		});

		// 当失效日期输入框获取焦点时, 清空错误信息
		$("#create-expireTime").focus(function(){
			clearInfo();
		});

		// 当部门输入框获取焦点时, 清空错误信息
		$("#create-org").focus(function(){
			clearInfo();
		});
	});

	function clearInfo(){
		$("#info").html("");
	}
</script>
</head>
<body>

	<!-- 创建用户的模态窗口 -->
	<div class="modal fade" id="createUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增用户</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-loginActNo" class="col-sm-2 control-label">登录帐号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-loginActNo">
							</div>
							<label for="create-username" class="col-sm-2 control-label">用户姓名</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-username">
							</div>
						</div>
						<div class="form-group">
							<label for="create-loginPwd" class="col-sm-2 control-label">登录密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="create-loginPwd">
							</div>
							<label for="create-confirmPwd" class="col-sm-2 control-label">确认密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="create-confirmPwd">
								<span id="passwordInfo"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
							<label for="create-expireTime" class="col-sm-2 control-label">失效时间</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-expireTime" placeholder="日期格式: yyyy-MM-dd HH-mm-ss">
							</div>
						</div>
						<div class="form-group">
							<label for="create-lockStatus" class="col-sm-2 control-label">锁定状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-lockStatus">
								  <option></option>
								  <option value="1">启用</option>
								  <option value="0">锁定</option>
								</select>
							</div>
							<label for="create-org" class="col-sm-2 control-label">部门<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-org" placeholder="输入部门名称，自动补全">
							</div>
						</div>
						<div class="form-group">
							<label for="create-allowIps" class="col-sm-2 control-label">允许访问的IP</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-allowIps" style="width: 280%" placeholder="多个ip之间使用空格隔开">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="submitButton">保存</button>
					<span id="info"></span>
				</div>
			</div>
		</div>
	</div>
	
	
	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>用户列表</h3>
			</div>
		</div>
	</div>
	
	<div class="btn-toolbar" role="toolbar" style="position: relative; height: 80px; left: 30px; top: -10px;">
		<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
		  
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">用户姓名</div>
		      <input class="form-control" type="text">
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">部门名称</div>
		      <input class="form-control" type="text">
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">锁定状态</div>
			  <select class="form-control">
			  	  <option></option>
			      <option>锁定</option>
				  <option>启用</option>
			  </select>
		    </div>
		  </div>
		  <br><br>
		  
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">失效时间</div>
			  <input class="form-control" type="text" id="startTime" />
		    </div>
		  </div>
		  
		  ~
		  
		  <div class="form-group">
		    <div class="input-group">
			  <input class="form-control" type="text" id="endTime" />
		    </div>
		  </div>
		  
		  <button type="submit" class="btn btn-default">查询</button>
		  
		</form>
	</div>
	
	
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; width: 110%; top: 20px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" id="createButton"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
		<div class="btn-group" style="position: relative; top: 18%; left: 5px;">
			<button type="button" class="btn btn-default">设置显示字段</button>
			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				<span class="caret"></span>
				<span class="sr-only">Toggle Dropdown</span>
			</button>
			<ul id="definedColumns" class="dropdown-menu" role="menu"> 
				<li><a href="javascript:void(0);"><input type="checkbox"/> 登录帐号</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 用户姓名</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 部门名称</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 邮箱</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 失效时间</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 允许访问IP</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 锁定状态</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 创建者</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 创建时间</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 修改者</a></li>
				<li><a href="javascript:void(0);"><input type="checkbox"/> 修改时间</a></li>
			</ul>
		</div>
	</div>
	
	<div style="position: relative; left: 30px; top: 40px; width: 110%">
		<table class="table table-hover">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input type="checkbox" /></td>
					<td>序号</td>
					<td>登录帐号</td>
					<td>用户姓名</td>
					<td>部门名称</td>
					<td>邮箱</td>
					<td>失效时间</td>
					<td>允许访问IP</td>
					<td>锁定状态</td>
					<td>创建者</td>
					<td>创建时间</td>
					<td>修改者</td>
					<td>修改时间</td>
				</tr>
			</thead>
			<tbody>
			<%
				Object obj = session.getAttribute("allUser");
				if(obj != null){
					List<User> allUser = (List<User>)obj;
					for(User userInfo : allUser){
			%>
				<tr class="active">
					<td><input type="checkbox" /></td>
					<td>1</td>
					<td><a  href="detail.html"></a><%=userInfo.getLoginAct()%></td>
					<td><%=userInfo.getName()%></td>
					<td><%=userInfo.getDeptno()%></td>
					<td><%=userInfo.getEmail()%></td>
					<td><%=userInfo.getExpireTime()%></td>
					<td><%=userInfo.getAllowIps()%></td>
					<td><a href="javascript:void(0);" onclick="window.confirm('您确定要锁定该用户吗？');" style="text-decoration: none;"><%=userInfo.getLockState() == "0" ? "锁定" : "启用"%></a></td>
					<td><%=userInfo.getCreateBy()%></td>
					<td><%=userInfo.getCreatetime()%></td>
					<td><%=userInfo.getEditBy()%></td>
					<td><%=userInfo.getEditTime()%></td>
				</tr>
			<%
					}
				}
			%>
			</tbody>
		</table>
	</div>
	
	<div style="height: 50px; position: relative;top: 30px; left: 30px;">
		<div>
			<button type="button" class="btn btn-default" style="cursor: default;">共<b>50</b>条记录</button>
		</div>
		<div class="btn-group" style="position: relative;top: -34px; left: 110px;">
			<button type="button" class="btn btn-default" style="cursor: default;">显示</button>
			<div class="btn-group">
				<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					10
					<span class="caret"></span>
				</button>
				<ul class="dropdown-menu" role="menu">
					<li><a href="#">20</a></li>
					<li><a href="#">30</a></li>
				</ul>
			</div>
			<button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
		</div>
		<div style="position: relative;top: -88px; left: 285px;">
			<nav>
				<ul class="pagination">
					<li class="disabled"><a href="#">首页</a></li>
					<li class="disabled"><a href="#">上一页</a></li>
					<li class="active"><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#">下一页</a></li>
					<li class="disabled"><a href="#">末页</a></li>
				</ul>
			</nav>
		</div>
	</div>
			
</body>
</html>