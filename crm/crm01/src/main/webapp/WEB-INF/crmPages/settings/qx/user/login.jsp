<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<%
		String path = request.getScheme() + "://" +
						request.getServerName() + ":" +
						request.getServerPort() +
						request.getContextPath() + "/";
	%>
<meta charset="UTF-8">
	<base href="<%=path%>">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
</head>
<body>
	<script type="text/javascript">
		function clearSpan(){
			// 清空id为msg标签中的文本值
			$("#msg").html("");
		}

		function InitiateUserLoginRequest(){
			// 发起用户登录请求
			// 获取用户输入的用户名
			var name = $("#name")[0].value;
			// 获取用户输入的密码
			var password = $("#userPassword")[0].value;

			// 去除用户名和密码的前后空格
			name.trim();
			password.trim();

			// 判断用户名或密码是否为空
			if(name == "" || password == ""){
				$("#msg").html("<font color='red'>登录失败, 用户名或密码不能为空</font>");
				// 如果用户名或密码为空, 不会发送Ajax请求
				return;
			}

			$("#msg").html("<font color='red'>请稍后</font>");
			// 获取用户十天之内免登录按钮的value值
			var number = $("#num")[0].value;

			// 发起Ajax请求
			$.ajax({url : "<%=path%>userLogin.do",   // 请求路径
				dataType : "json",   // 希望获取的数据格式
				data : {
					"name" : name,
					"password" : password,
					"num" : number
				},
				success : function(data){
					// 请求结束后处理数据的函数
					if(data.loginInfo == true){
						window.alert("登录成功");
						// 跳转页面
						window.location.href = "<%=path%>workbench/index.do";
						return;
					}

					// 显示错误信息
					$("#msg").html("<font color='red'>" + data.errorInfo + "</font>");
				},
				error : function(){
					// 出现错误后执行的函数
					window.alert("出现错误");
				},
				// beforeSend : function(){
					// 在发起Ajax请求之前执行该函数
				// }
			});
		}

		$(function(){
			// name输入框获取焦点时
			$("#name").focus(function(){
				clearSpan();
			});

			// password输入框获取焦点时
			$("#userPassword").focus(function(){
				clearSpan();
			});

			// name输入框按下键按下执行该函数
			$("#name").keydown(function(key){
				if(key.keyCode == 13){
					InitiateUserLoginRequest();
				}
			});

			// password输入框键按下执行该函数
			$("#userPassword").keydown(function(key){
				if(key.keyCode == 13){
					InitiateUserLoginRequest();
				}
			});
			// 再页面加载完毕后执行
			$("#num").click(function(){
				// 判断十天之内免登录的值是0还是1
				if(document.getElementById("num").value == "0"){
					document.getElementById("num").value = "1";
				}else if(document.getElementById("num").value == "1"){
					document.getElementById("num").value = "0";
				}
			});

			// 通过登录按钮, 获取登录按钮对象
			$("#userLogin").click(function(){
				// 按钮被单击后, 执行该函数
				InitiateUserLoginRequest();
			});
		})
	</script>

	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2022&nbsp;CRM项目</span></div>
	</div>

	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="/workbench/index.do" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" type="text" placeholder="用户名" id="name"/>
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" type="password" placeholder="密码" id="userPassword"/>
					</div>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
						<label>
							<input type="checkbox" id="num" value="0"> 十天内免登录
						</label>
						&nbsp;&nbsp;
						<span id="msg"></span>
					</div>
					<input type="button" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;" value="登录" id="userLogin">
				</div>
			</form>
		</div>
	</div>
</body>
</html>