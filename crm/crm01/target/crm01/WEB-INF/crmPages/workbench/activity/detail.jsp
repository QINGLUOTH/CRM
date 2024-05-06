<%@ page import="com.nihao.crm.entityClass.user.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.nihao.crm.entityClass.activity.Activity" %>
<%@ page import="com.nihao.crm.entityClass.activity.remark.ActivityRemark" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<%
		String path = request.getScheme() + "://" +
				request.getServerName() + ":" +
				request.getServerPort() +
				request.getContextPath() + "/";

		// 从request域中获取活动信息和活动备注信息
		Activity activity = (Activity)request.getAttribute("activity");
		List<ActivityRemark> activityRemarks = (List<ActivityRemark>) request.getAttribute("activityRemarks");
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

		// 添加保存按钮单击事件
		$("#saveButton").click(function(){
			createActivityRemark();
		});

        // 用户点击更新按钮, 更新活动备注数据
        $("#updateRemarkBtn").click(function(){
            // 获取更新数据的活动备注id
            var id = this.value;
            // 获取用户输入修改活动备注信息
            var editActivityRemark = $("#noteContent").val();

            // 发起Ajax请求, 更新活动备注信息
            $.ajax({
                url : "<%=path%>updateActivityRemark.do",   // 请求地址
                dataType : "json",
                data : {
                    // 请求携带的数据
                    "id" : id,
					"editActivityRemark" : editActivityRemark
                },
                success : function(data){
					// 请求结束后处理数据时执行的函数
                    if(! data.flag){
                        window.alert("修改失败");
                    }
					// 关闭修改活动备注模态窗口
                    $("#editRemarkModal").modal("hide");
					// 刷新页面, 更新数据
					window.location.replace(window.location.href);
                },
                error : function(){
                    window.alert("出现错误");
                    $("#editRemarkModal").modal("hide");
                }
            })
        });
	});

	function openUpdateWindow(id){
		// 打开修改活动备注的模态窗口
		$("#editRemarkModal").modal("show");
		$("#updateRemarkBtn").val(id);
		// 获取活动备注信息
		$.ajax({
			url : "<%=path%>queryActivityRemark.do",   // 请求地址
			dataType : "json",   // 请求希望得到的数据格式
			data : {
				// 请求携带的数据
				"id" : id
			},
			success : function(data){
				// 请求结束后处理数据执行的函数
				$("#noteContent").val(data.activityRemark);
			},
			error : function(){
				window.alert("出现错误");
			}
		});
	}

    /**
     * 删除市场活动备注
     * @param id 市场活动备注的id
     */
    function deleteActivityRemark(id){
		var flag = window.confirm("确定要删除吗?");
		if(! flag){
			return;
		}
        // 发起Ajax请求
        $.ajax({
            url : "<%=path%>deleteActivityRemark.do",   // 请求地址
            dataType : "json",   // 希望得到的数据格式
            data : {
                // 请求携带的数据
                "id" : id
            },
            success : function(data){
                if(data.flag){
                    // 数据删除成功, 刷新页面
                    window.location.replace(window.location.href);
                    return;
                }
                // 数据删除失败
                window.alert("删除失败");
            },
            error : function(){
                window.alert("出现错误");
            }
        });
    }

    /**
	 * 发起Ajax请求, 保存活动备注
	 */
	function createActivityRemark(){
		// 获取用户输入的备注信息
		var remarkStr = $("#remark")[0].value;
		// 判断用户输入的备注信息是否为空, 为空则提示出现错误
		if(remarkStr == null || remarkStr == ""){
			window.alert("备注信息不能为空");
			return;
		}
		// 发起Ajax请求
		$.ajax({
			url : "<%=path%>createActivityRemark.do",   // 请求地址
			dataType : "json",   // 希望获取的数据
			data : {
				// 请求携带的数据
				"remark" : remarkStr,
				"activityId" : "<%=activity.getId()%>"
			},
			success : function(data){
				if(data.flag == false){
					window.alert("创建失败");
					return;
				}
				// 刷新页面
				window.location.replace(window.location.href);
			},
			error : function(){
				window.alert("出现错误");
			}
		});
	}
</script>

</head>
<body>

	<!-- 修改市场活动备注的模态窗口 -->
	<div class="modal fade" id="editRemarkModal" role="dialog">
		<%-- 备注的id --%>
		<input type="hidden" id="remarkId">
		<div class="modal-dialog" role="document" style="width: 40%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改备注</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">内容</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="noteContent"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
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
			<h3>市场活动-<%=activity.getName()%> <small><%=activity.getStartDate()%> ~ <%=activity.getEndDate()%></small></h3>
		</div>

	</div>

	<br/>
	<br/>
	<br/>

	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b><%=activity.getOwner()%></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b><%=activity.getName()%></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">开始日期</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b><%=activity.getStartDate()%></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b><%=activity.getEndDate()%></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">成本</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b><%=activity.getCost()%></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b><%=activity.getCreateBy()%>&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;"><%=activity.getCreateTime()%></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b><%=activity.getEditBy()%>&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;"><%=activity.getEditTime()%></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					<%=activity.getDescription()%>
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>

	<!-- 备注 -->
	<div style="position: relative; top: 30px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>

		<%
			for(ActivityRemark activityRemark : activityRemarks){
		%>
		<div class="remarkDiv" style="height: 60px;">
			<img title="<%=activityRemark.getCreateBy()%>" src="image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5><%=activityRemark.getNoteContent()%></h5>
				<font color="gray">市场活动</font> <font color="gray">-</font> <b><%=activity.getName()%></b> <small style="color: gray;"> <%=activityRemark.getCreateTime()%> 由<%=activityRemark.getCreateBy()%></small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);" onclick="openUpdateWindow('<%=activityRemark.getId()%>');"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);" onclick="deleteActivityRemark('<%=activityRemark.getId()%>');"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>
		<%
			}
		%>

		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" class="btn btn-primary" id="saveButton">保存</button>
				</p>
			</form>
		</div>
	</div>
	<div style="height: 200px;"></div>
	</body>
</html>