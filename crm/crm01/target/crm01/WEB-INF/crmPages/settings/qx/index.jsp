<%@ page import="com.nihao.crm.entityClass.user.User" %>
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

		//页面加载完毕
		$(function(){
			//导航中所有文本颜色为黑色
			$(".liClass > a").css("color" , "black");

			//默认选中导航菜单中的第一个菜单项
			$(".liClass:first").addClass("active");

			//第一个菜单项的文字变成白色
			$(".liClass:first > a").css("color" , "white");

			//给所有的菜单项注册鼠标单击事件
			$(".liClass").click(function(){
				//移除所有菜单项的激活状态
				$(".liClass").removeClass("active");
				//导航中所有文本颜色为黑色
				$(".liClass > a").css("color" , "black");
				//当前项目被选中
				$(this).addClass("active");
				//当前项目颜色变成白色
				$(this).children("a").css("color","white");
			});

			window.open("permission/index.do","workareaFrame");

			$("#exitSystemButton").click(function(){
				// 退出登录
				window.location.href = "<%=path%>exitLogin.do";
			});

			// 修改用户密码
			$("#updateUser").click(function(){
				// 获取用户输入的原密码
				var userOriginalPassword = $("#oldPwd")[0].value;
				// 验证密码是否正确
				var userPassword = "<%=user.getLoginPwd()%>";

				if(userOriginalPassword != userPassword){
					window.alert("原密码错误");
					return;
				}

				// 获取用户输入的新密码
				var userNewPassword = $("#newPwd")[0].value;

				// 获取用户输入的确认密码
				var userConfirmPassword = $("#confirmPwd")[0].value;

				if(userConfirmPassword != userNewPassword){
					// 新密码和确认密码不相等
					window.alert("确认密码错误");
					return;
				}

				// 获取用户输入的新密码
				var userNewPassword = $("#newPwd")[0].value;

				// 获取用户输入的确认密码
				var userConfirmPassword = $("#confirmPwd")[0].value;

				if(userConfirmPassword != userNewPassword){
					window.alert("密码修改失败");
					return;
				}

				// 发起Ajax请求
				$.ajax({
					url : "<%=path%>changePassword.do",   // 发起Ajax请求路径
					dataType : "json",   // 希望获取到的数据
					data : {  // 发送的数据
						"password" : userNewPassword
					},
					success : function(data){
						// 请求发送完毕没有出现错误执行的函数
						if(data.flag == true){
							// 用户密码修改成功
							window.alert("密码修改成功");
							window.location.href = "<%=path%>exitLogin.do";
							return;
						}

						// 用户密码修改失败
						window.alert("密码修改失败");
					},
					erroe : function(){
						// 出现错误后执行的函数
						window.alert("出现错误");
					}
				})
			});

			// 当原密码框失去焦点时, 判断密码是否正确
			$("#oldPwd").blur(function(){
				// 获取用户输入的原密码
				var userOriginalPassword = $("#oldPwd")[0].value;
				// 账户密码
				var userPassword = "<%=user.getLoginPwd()%>";

				// 验证密码是否正确
				if(userOriginalPassword != userPassword){
					$("#info").html("<font color='red'>原密码错误</font>");
					return;
				}
			});

			// 当确认密码框失去焦点时, 判断确认密码与新密码是否相等
			$("#confirmPwd").blur(function(){
				// 获取用户输入的新密码
				var userNewPassword = $("#newPwd")[0].value;

				// 获取用户输入的确认密码
				var userConfirmPassword = $("#confirmPwd")[0].value;

				if(userConfirmPassword != userNewPassword){
					// 新密码和确认密码不相等
					$("#info").html("<font color='red'>确认密码错误</font>");
				}
			});

			// 输入原密码框获得焦点时
			$("#oldPwd").focus(function(){
				clearIdInfo();
			});

			// 输入新密码框获得焦点时
			$("#newPwd").focus(function(){
				clearIdInfo();
			});

			// 输入确认密码框获得焦点时
			$("#confirmPwd").focus(function(){
				clearIdInfo();
			});
		});

		function clearIdInfo(){
			$("#info").html("");
		}
	</script>

</head>
<body>

<!-- 我的资料 -->
<div class="modal fade" id="myInformation" role="dialog">
	<div class="modal-dialog" role="document" style="width: 30%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">我的资料</h4>
			</div>
			<div class="modal-body">
				<div style="position: relative; left: 40px;">
					姓名：<b><%=user.getName()%></b><br><br>
					登录帐号：<b><%=user.getLoginAct()%></b><br><br>
					组织机构：<b><%=user.getDeptno()%></b><br><br>
					邮箱：<b><%=user.getEmail()%></b><br><br>
					失效时间：<b><%=user.getExpireTime()%></b><br><br>
					允许访问IP：<b><%=user.getAllowIps()%></b>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- 修改密码的模态窗口 -->
<div class="modal fade" id="editPwdModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 70%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">修改密码</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form">
					<div class="form-group">
						<label for="oldPwd" class="col-sm-2 control-label">原密码</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="oldPwd" style="width: 200%;">
							<span id="originalPassword"></span>
						</div>
					</div>

					<div class="form-group">
						<label for="newPwd" class="col-sm-2 control-label">新密码</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="newPwd" style="width: 200%;">
						</div>
					</div>

					<div class="form-group">
						<label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" id="updateUser">更新</button>
				<span id="info"></span>
			</div>
		</div>
	</div>
</div>

<!-- 退出系统的模态窗口 -->
<div class="modal fade" id="exitModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 30%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">离开</h4>
			</div>
			<div class="modal-body">
				<p>您确定要退出系统吗？</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='login.html';" id="exitSystemButton">确定</button>
			</div>
		</div>
	</div>
</div>
	
	<!-- 顶部 -->
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2022&nbsp;CRM项目</span></div>
		<div style="position: absolute; top: 15px; right: 15px;">
			<ul>
				<li class="dropdown user-dropdown">
					<a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-user"></span> <%=user.getLoginAct()%> <span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="workbench/index.do"><span class="glyphicon glyphicon-home"></span> 工作台</a></li>
						<li><a href="settings/index.do"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file"></span> 我的资料</a></li>
						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
						<li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> 退出</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 中间 -->
	<div id="center" style="position: absolute;top: 50px; bottom: 30px; left: 0px; right: 0px;">
	
		<!-- 导航 -->
		<div id="navigation" style="left: 0px; width: 18%; position: relative; height: 100%; overflow:auto;">
		
			<ul id="no1" class="nav nav-pills nav-stacked">
				<li class="liClass"><a href="permission/index.do" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 许可维护</a></li>
				<li class="liClass"><a href="role/index.do" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 角色维护</a></li>
				<li class="liClass"><a href="user/index.do" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 用户维护</a></li>
			</ul>
			
			<!-- 分割线 -->
			<div id="divider1" style="position: absolute; top : 0px; right: 0px; width: 1px; height: 100% ; background-color: #B3B3B3;"></div>
		</div>
		
		<!-- 工作区 -->
		<div id="workarea" style="position: absolute; top : 0px; left: 18%; width: 82%; height: 100%;">
			<iframe style="border-width: 0px; width: 100%; height: 100%;" name="workareaFrame"></iframe>
		</div>
		
	</div>
	
	<div id="divider2" style="height: 1px; width: 100%; position: absolute;bottom: 30px; background-color: #B3B3B3;"></div>
	
	<!-- 底部 -->
	<div id="down" style="height: 30px; width: 100%; position: absolute;bottom: 0px;"></div>
	
</body>
</html>