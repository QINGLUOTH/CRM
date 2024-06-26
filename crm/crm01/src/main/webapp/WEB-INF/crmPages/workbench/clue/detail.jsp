<%@ page import="com.nihao.crm.entityClass.user.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.nihao.crm.entityClass.clue.Clue" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<%
		String path = request.getScheme() + "://" +
				request.getServerName() + ":" +
				request.getServerPort() +
				request.getContextPath() + "/";

		// 获取clue信息
		Clue clue = (Clue) request.getAttribute("clue");
	%>
	<meta charset="UTF-8">
	<base href="<%=path%>">
	
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

	<script type="text/javascript">

		//默认情况下取消和保存按钮是隐藏的
		var cancelAndSaveBtnDefault = true;

		$(function(){
			$("#remark").focus(function(){
				if(cancelAndSaveBtnDefault){
					//设置remarkDiv的高度为130px
					$("#remarkDiv").css("height","130px");
					//显示
					$("#cancelAndSaveBtn").show("2000");
					cancelAndSaveBtnDefault = false;
				}
			});

			$("#cancelBtn").click(function(){
				//显示
				$("#cancelAndSaveBtn").hide();
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","90px");
				cancelAndSaveBtnDefault = true;
			});

			$(".remarkDiv").mouseover(function(){
				$(this).children("div").children("div").show();
			});

			$(".remarkDiv").mouseout(function(){
				$(this).children("div").children("div").hide();
			});

			$(".myHref").mouseover(function(){
				$(this).children("span").css("color","red");
			});

			$(".myHref").mouseout(function(){
				$(this).children("span").css("color","#E6E6E6");
			});
		});

	</script>

</head>
<body>

<!-- 关联市场活动的模态窗口 -->
<div class="modal fade" id="bundModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 80%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">关联市场活动</h4>
			</div>
			<div class="modal-body">
				<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
					<form class="form-inline" role="form">
						<div class="form-group has-feedback">
							<input type="text" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
							<span class="glyphicon glyphicon-search form-control-feedback"></span>
						</div>
					</form>
				</div>
				<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
					<thead>
					<tr style="color: #B3B3B3;">
						<td><input type="checkbox"/></td>
						<td>名称</td>
						<td>开始日期</td>
						<td>结束日期</td>
						<td>所有者</td>
						<td></td>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td><input type="checkbox"/></td>
						<td>发传单</td>
						<td>2020-10-10</td>
						<td>2020-10-20</td>
						<td>zhangsan</td>
					</tr>
					<tr>
						<td><input type="checkbox"/></td>
						<td>发传单</td>
						<td>2020-10-10</td>
						<td>2020-10-20</td>
						<td>zhangsan</td>
					</tr>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">关联</button>
			</div>
		</div>
	</div>
</div>


<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
	<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
	<div class="page-header">
		<h3>李四先生 <small>动力节点</small></h3>
	</div>
	<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
		<button type="button" class="btn btn-default" onclick="window.location.href='convert.html';"><span class="glyphicon glyphicon-retweet"></span> 转换</button>

	</div>
</div>

<br/>
<br/>
<br/>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
	<div style="position: relative; left: 40px; height: 30px;">
		<div style="width: 300px; color: gray;">名称</div>
		<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>李四先生</b></div>
		<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">所有者</div>
		<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>zhangsan</b></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 10px;">
		<div style="width: 300px; color: gray;">公司</div>
		<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>动力节点</b></div>
		<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">职位</div>
		<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>CTO</b></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 20px;">
		<div style="width: 300px; color: gray;">邮箱</div>
		<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>lisi@bjpowernode.com</b></div>
		<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">公司座机</div>
		<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>010-84846003</b></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 30px;">
		<div style="width: 300px; color: gray;">公司网站</div>
		<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>http://www.bjpowernode.com</b></div>
		<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
		<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>12345678901</b></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 40px;">
		<div style="width: 300px; color: gray;">线索状态</div>
		<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>已联系</b></div>
		<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">线索来源</div>
		<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>广告</b></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 50px;">
		<div style="width: 300px; color: gray;">创建者</div>
		<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>zhangsan&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">2017-01-18 10:10:10</small></div>
		<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 60px;">
		<div style="width: 300px; color: gray;">修改者</div>
		<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>zhangsan&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">2017-01-19 10:10:10</small></div>
		<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 70px;">
		<div style="width: 300px; color: gray;">描述</div>
		<div style="width: 630px;position: relative; left: 200px; top: -20px;">
			<b>
				这是一条线索的描述信息
			</b>
		</div>
		<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 80px;">
		<div style="width: 300px; color: gray;">联系纪要</div>
		<div style="width: 630px;position: relative; left: 200px; top: -20px;">
			<b>
				这条线索即将被转换
			</b>
		</div>
		<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 90px;">
		<div style="width: 300px; color: gray;">下次联系时间</div>
		<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>2017-05-01</b></div>
		<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px; "></div>
	</div>
	<div style="position: relative; left: 40px; height: 30px; top: 100px;">
		<div style="width: 300px; color: gray;">详细地址</div>
		<div style="width: 630px;position: relative; left: 200px; top: -20px;">
			<b>
				北京大兴大族企业湾
			</b>
		</div>
		<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
	</div>
</div>

<!-- 备注 -->
<div style="position: relative; top: 40px; left: 40px;">
	<div class="page-header">
		<h4>备注</h4>
	</div>

	<!-- 备注1 -->
	<div class="remarkDiv" style="height: 60px;">
		<img title="zhangsan" src="../../image/user-thumbnail.png" style="width: 30px; height:30px;">
		<div style="position: relative; top: -40px; left: 40px;" >
			<h5>哎呦！</h5>
			<font color="gray">线索</font> <font color="gray">-</font> <b>李四先生-动力节点</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>
			<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
				<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
			</div>
		</div>
	</div>

	<!-- 备注2 -->
	<div class="remarkDiv" style="height: 60px;">
		<img title="zhangsan" src="../../image/user-thumbnail.png" style="width: 30px; height:30px;">
		<div style="position: relative; top: -40px; left: 40px;" >
			<h5>呵呵！</h5>
			<font color="gray">线索</font> <font color="gray">-</font> <b>李四先生-动力节点</b> <small style="color: gray;"> 2017-01-22 10:20:10 由zhangsan</small>
			<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
				<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
			</div>
		</div>
	</div>

	<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
		<form role="form" style="position: relative;top: 10px; left: 10px;">
			<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
			<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
				<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
				<button type="button" class="btn btn-primary">保存</button>
			</p>
		</form>
	</div>
</div>

<!-- 市场活动 -->
<div>
	<div style="position: relative; top: 60px; left: 40px;">
		<div class="page-header">
			<h4>市场活动</h4>
		</div>
		<div style="position: relative;top: 0px;">
			<table class="table table-hover" style="width: 900px;">
				<thead>
				<tr style="color: #B3B3B3;">
					<td>名称</td>
					<td>开始日期</td>
					<td>结束日期</td>
					<td>所有者</td>
					<td></td>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td>发传单</td>
					<td>2020-10-10</td>
					<td>2020-10-20</td>
					<td>zhangsan</td>
					<td><a href="javascript:void(0);"  style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>
				</tr>
				<tr>
					<td>发传单</td>
					<td>2020-10-10</td>
					<td>2020-10-20</td>
					<td>zhangsan</td>
					<td><a href="javascript:void(0);"  style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>
				</tr>
				</tbody>
			</table>
		</div>

		<div>
			<a href="javascript:void(0);" data-toggle="modal" data-target="#bundModal" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>关联市场活动</a>
		</div>
	</div>
</div>


<div style="height: 200px;"></div>
</body>
</html>