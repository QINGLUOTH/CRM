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
	%>
	<base href="<%=path%>">
	<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
	<link rel="stylesheet" href="jquery/pagination/css/pagination.min.css" type="text/css"/>
	
	<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript" src="jquery/pagination/js/pagination.js"></script>
	<script type="text/javascript">
	$(function(){
		// 创建市场活动
		$("#preservation").click(function(){
			// 获取用户选择所有者
			var owner = $("#create-marketActivityOwner")[0].value;
			// 获取用户输入的活动名称
			var activityName = $("#create-marketActivityName")[0].value;
			// 判断用户输入的活动名称是否为空
			if(activityName == null || activityName == ""){
				// 输出错误信息
				window.alert("活动名称不能为空");
				return;
			}
			// 获取用户输入的开始日期
			var startDate = $("#create-startTime")[0].value;
			// 获取用户输入的结束日期
			var endDate = $("#create-endTime")[0].value;
			if(! ((startDate == "" || startDate == null) || (endDate == null || endDate == null))){
				// 判断用户输入的开始日期和结束日期是否符合要求
				// 定义正则表达式
				var dateRegRxp = /^[\d]{4}-[\d]{2}-[\d]{2}$/;
				if(! (dateRegRxp.test(startDate.trim()) || dateRegRxp.test(endDate.trim()))){
					window.alert("输入的日期格式不正确");
					return;
				}
				if(startDate > endDate){
					window.alert("开始日期不能大于结束日期");
					return;
				}
			}

			// 获取用户输入的成本
			var cost = $("#create-cost")[0].value;
			// 判断用户输入的成本数据是否符合要求
			if(cost != null && cost != ""){
				// 定义正则表达式
				var costRegRxp = /^[\d]+[\.]?[\d]*$/;
				if(!(costRegRxp.test(cost.trim()))){
					window.alert("成本必须是数字");
					$("#createActivityModal").modal("show");
					return;
				}
				if(cost < 0){
					window.alert("成本不能小于零");
					$("#createActivityModal").modal("show");
					return;
				}
			}
			// 获取用户输入的描述信息
			var describe = $("#create-describe")[0].value;

			// 发起Ajax请求
			$.ajax({
				url : "<%=path%>createActivity.do",   // 请求地址
				type : "post",   // 请求方式
				dataType : "json",   // 希望得到的数据格式
				data : {
					// 请求携带的数据
					"owner" : owner,   // 该活动的所有者
					"activityName" : activityName,   // 活动名称
					"startDate" : startDate,   // 开始日期
					"endDate" : endDate,   // 结束日期
					"cost" : cost,   // 活动成本
					"describe" : describe  // 活动描述
				},
				success : function(data){
					// 请求成功返回数据后执行
					if(data.flag == false){
						window.alert("创建失败");
						// 打开模态窗口
						$("#createActivityModal").modal("show");
						return;
					}
					// 更新页面
					queryDataShowPage();
					// 关闭模态窗口
					$("#createActivityModal").modal("hide");
				},
				error : function(){
					// 出现错误后执行
					window.alert("出现错误");
				}
			});
		});

        // 页面加载完毕后, 发起Ajax请求, 查询所有数据, 显示数据条数
        queryDataShowPage();

        $("#queryButton").click(function(){
            // 查询活动数据
            queryDataShowPage();
        });


		// 给创建市场活动按钮添加单击事件
		$("#createButton").click(function(){
			// 打开模态窗口
			$("#createActivityModal").modal("show");
		});

		// 查询数据
		$("#queryButton").click(function(){
			queryDataShowPage();
		});

		// 用户点击删除按钮时删除活动数据
		$("#removeButton").click(function(){
			removeActivity();
		});

		// 用户点击id为selectAllCheckbox的checkbox, 当前页面的checkbox变为全部选中状态
		$("#selectAllCheckbox").click(function(){
			var flag = $("#selectAllCheckbox").prop("checked");
			var $allCheckbox = $(":checkbox");
			$allCheckbox.prop("checked", flag);
		});

		// 实现选择导出功能
		$("#exportActivityXzBtn").click(function(){
			if(! window.confirm("是否要选择导出文件?")){
				return;
			}

			// 获取选中的checkbox
			var $checkedCheckbox = $(":checkbox:checked");
			if($checkedCheckbox.size() == 0){
				window.alert("请选择导出的文件");
				return;
			}


			// 获取用户选择活动的所有id
			var ids = "";
			for(var i = 0; i < $checkedCheckbox.size(); i++){
				var element = $checkedCheckbox[i];
				if(element.value == "selectCheckbox"){
					continue;
				}

				if(i == 0){
					ids += element.value;
					continue;
				}

				ids += "," + element.value;
			}
			// 发起请求
			window.location.href = "<%=path%>downloadActivityFile.do?id=" + ids;
		});

		// 实现批量导出功能
		$("#exportActivityAllBtn").click(function(){
			if(! window.confirm("是否要导出所有市场活动文件?")){
				return;
			}
			var ids = "1";

			// 发起批量导入请求
			window.location.href = "<%=path%>downloadActivityFile.do?id=" + ids;
		});

		// 实现用户点击上传按钮, 上传文件功能
		$("#importActivityBtn").click(function(){
			// 获取用户选择上传的文件
			var file = $("#activityFile")[0].files[0];
			// 获取上传的文件名
			var fileName = $("#activityFile")[0].value;
			// 判断文件是否符合要求
			// 文件的后缀名是.xls
			if(! (fileName.substring((fileName.length - 3), (fileName.length)) == "xls")){
				window.alert("所选文件的后缀名必须是.xls");
				return;
			}
			// 判断文件大小是否符合要求
			if(! (file.size <= (1024 * 1024 * 5))){
				window.alert("所传文件的大小必须在5MB以内");
				return;
			}

			// 符合要求, 发起Ajax请求, 将数据交给后台解析, 保存在数据库中
			var formData = new FormData();
			formData.append("file", file);
			$.ajax({
				url : "<%=path%>importFile.do",   // 请求地址
				dataType : "json",
				type : "post",   // 因为上传的数据是文件, 所以请求格式不能是get, get请求只能上传字符串
				contentType : false,   // contentType表示是否统一使用urlencoded编码, true表示使用, false表示不使用
				processData : false,   // processData表示是否将参数全部转换为字符串提交到后台, true表示是, false表示不
				data : formData,   // 请求携带的数据
				success : function(data){
					if(! data.flag){
						window.alert(data.info);
						// 关闭模态窗口
						$("#importActivityModal").modal("hide");
						return;
					}
					// 关闭模态窗口
					$("#importActivityModal").modal("hide");
					// 更新页面
					queryDataShowPage();
				},
				error : function(){
					window.alert("出现错误");
					// 关闭模态窗口
					$("#importActivityModal").modal("hide");
				}
			})
		});

		// 用户点击更新按钮, 更新数据
		$("#updateButton").click(function(){
			// 获取用户选择修改的活动id
			var $checkboxChecked = $(":checkbox:checked");
			if($checkboxChecked[0] == null || $checkboxChecked[0] == ""){
				window.alert("请选择更新的活动");
				return;
			}
			var ids = "";
			for(var i = 0; i < $checkboxChecked.length; i++){
				var element = $checkboxChecked[i];
				if(element.value == "selectCheckbox"){
					continue;
				}
				if(i == 0){
					ids += element.value;
					continue;
				}
				ids += "," + element.value;
			}

			// 获取用户选择的所有者
			var editActivityOwner = $("#edit-marketActivityOwner")[0].value;
			// 获取用户输入的修改名称
			var editActivityName = $("#edit-marketActivityName")[0].value;
			// 获取用户输入的修改开始日期
			var editStartDate = $("#edit-startTime")[0].value;
			// 获取用户输入的修改结束日期
			var editEndDate = $("#edit-endTime")[0].value;
			// 获取用户输入的修改成本
			var editCost = $("#edit-cost")[0].value;
			// 获取用户输入的修改描述信息
			var editDescribe = $("#edit-describe")[0].value;

			// 判断用户输入的修改信息是否为空
			if((editActivityOwner == null || editActivityOwner == "") && (editActivityName == null || editActivityName == "")
					&& (editStartDate == null || editStartDate == "") && (editEndDate == null || editEndDate == "")
					&& (editCost == null || editCost == "" && editDescribe == null || editDescribe == "")){
				// 用户输入的修改信息为空, 无需修改
				return;
			}

			// 判断用户输入的开始日期或结束日期是否为空
			if(editStartDate != null && editStartDate != "" && editEndDate != null && editEndDate != ""){
				// 判断用户输入的开始日期和结束日期是否符合要求
				// 定义正则表达式
				var dateRegRxp = /^[\d]{4}-[\d]{2}-[\d]{2}$/;
				if(! (dateRegRxp.test(editStartDate.trim()) || dateRegRxp.test(editEndDate.trim()))){
					window.alert("输入的日期格式不正确");
					return;
				}
				if(editStartDate > editEndDate){
					window.alert("开始日期不能大于结束日期");
					return;
				}

				// 判断用户输入的成本数据是否符合要求
				if(editCost != null && editCost != ""){
					// 定义正则表达式
					var costRegRxp = /^[\d]+[\.]?[\d]*$/;
					if(!(costRegRxp.test(editCost.trim()))){
						window.alert("成本必须是数字");
						return;
					}
					if(editCost < 0){
						window.alert("成本不能小于零");
						return;
					}
				}
			}else if((editStartDate == null || editStartDate == "") && (editEndDate == null || editEndDate == "")){

			}else{
				window.alert("修改开始日期和结束日期必须同时进行");
				return;
			}

			// 去除修改数据的前后空格
			if(editActivityName != null && editActivityName != ""){
				editActivityName.trim();
			}

			if(editDescribe != null && editDescribe != ""){
				editDescribe.trim();
			}

			// 发起Ajax请求
			$.ajax({
				url : "<%=path%>updateActivity.do",   // 请求地址
				dataType : "json",   // 请求希望返回的数据
				data : {
					// 请求携带的数据
					"activityIds" : ids,
					"editActivityOwner" : editActivityOwner,
					"editActivityName" : editActivityName,
					"editStartDate" : editStartDate,
					"editEndDate" : editEndDate,
					"editCost" : editCost,
					"editDescribe" : editDescribe
				},
				success : function(data){
					// 请求结束后对数据进行处理的函数
					if(! data.flag){
						window.alert("修改失败");
						return;
					}

					// 查询数据, 更新页面
					queryDataShowPage();
				},
				error : function(){
					window.alert("出现错误");
				}
			});
		});

		// 按钮全部选中时, 全选按钮选中, 按钮取消时, 全选按钮取消选中
		$("#showActivityInfo").on("click", ":checkbox", function(){
			if($("#selectAllCheckbox").prop("checked")){
				$("#selectAllCheckbox").prop("checked", false);
				return;
			}
			if(this.value == "selectCheckbox"){
				return;
			}

			if(($(":checkbox").length - 1) == $(":checkbox:checked").length){
				$("#selectAllCheckbox").prop("checked", true);
			}else{
				$("#selectAllCheckbox").prop("checked", false);
			}
		});
	});

    /**
     * 查询数据显示页面
     */
    function queryDataShowPage(currentPage) {
		var flag = $("#selectAllCheckbox").prop("checked");
		// 获取用户输入的查询活动条件
		// 获取用户输入的查询活动名称
		var queryActivityName = $("#queryActivityName")[0].value;
		// 获取用户输入的查询活动所有人
		var queryActivityOwner = $("#queryActivityOwner")[0].value;
		// 获取用户输入的查询活动开始日期
		var queryActivityStartDate = $("#queryActivityStartDate")[0].value;
		// 获取用户输入的查询活动结束日期
		var queryActivityEndDate = $("#queryActivityEndDate")[0].value;

		if(currentPage == null || currentPage == ""){
			currentPage = 1;
		}

		// 发起Ajax请求, 查询数据
		$.ajax({
			url: "<%=path%>queryActivityInfo.do",   // 请求地址
			dataType: "json",   // 希望获取的数据格式
			data: {
				// 请求携带的数据
				"activityName": queryActivityName,
				"activityOwner": queryActivityOwner,
				"activityStartDate": queryActivityStartDate,
				"activityEndDate": queryActivityEndDate,
				"pageShowNumber" : currentPage
			},
			success: function (data) {
				var showStr = "";
				/*// 处理数据, 显示页面
				if (data == null || data == "") {
					$("#showActivityInfo").html(showStr);
					$("#numberOfRecords").html("0");
					return;
				}*/
				// 遍历json数据
				$.each(data.activities, function (index, activity) {
					showStr += "<tr class=\"active\">";
					showStr += "<td><input type=\"checkbox\" value=\"" + activity.id + "\"/></td>";
					showStr += "<td><a style='text-decoration: none; cursor: pointer;' onclick=\"window.location.href='<%=path%>activity/detail.do?id=" + activity.id + "';\">" + activity.name + "</a></td>";
					showStr += "<td>" + activity.owner + "</td>";
					showStr += "<td>" + activity.startDate + "</td>";
					showStr += "<td>" + activity.endDate + "</td>";
					showStr += "</tr>";
				});
				$("#showActivityInfo").html(showStr);
				// 显示数据总条数
				/*$("#numberOfRecords").html(data.length);*/
				new Pagination({
					element : "#paginationDisplay",   // 显示分页的位置
					type : 1,   // 选择的样式
					pageIndex : currentPage,   // 当前页数
					pageSize : 10,   // 每页显示条数
					pageCount : 5,   // 页数显示数量
					total : data.number,   // 数据总条数
					singlePageHide : false,
					prevText : "上一页",   // 跳转上一页按钮显示文本
					nextText : "下一页",   // 跳转下一页按钮显示文本
					disabled : true,
					homePage : "首页",
					lastPage : "尾页",
					currentChange : function(index){
						queryDataShowPage(index);
					}
				});
				if(flag){
					$(":checkbox").prop("checked", true);
				}else{
					$(":checkbox").prop("checked", false);
				}
			},
			error: function () {
				// 出现错误
				window.alert("出现错误");
			}
		});
	}

	/**
	 * 删除市场活动
	 */
	function removeActivity(){
		var flag = window.confirm("确认要删除活动数据吗?");
		if(! flag){
			return;
		}
		// 获取所有选中的下拉列表值
		var $checkboxChecked = $(":checkbox:checked");
		if($checkboxChecked[0] == null){
			window.alert("请选择删除的活动");
			return;
		}
		var activityIds = "";
		for(var i = 0; i < $checkboxChecked.length; i++){
			var element = $checkboxChecked[i];
			if(element.value == "selectCheckbox"){
				continue;
			}

			if(i == 0){
				activityIds += element.value;
				continue;
			}
			activityIds += "," + element.value;
		}
		// 发起Ajax请求
		$.ajax({
			url : "<%=path%>removeActivity.do",   // 请求地址
			dataType : "json",   // 希望得到的数据类型
			data : {
				// 请求携带的数据
				"activityIds" : activityIds
			},
			success : function(data){
				// 处理请求结果
				if(data.flag == false){
					window.alert("删除失败");
					return;
				}
				$(":checkbox").prop("checked", false);
				// 删除成功, 更新数据
				queryDataShowPage();
			},
			error : function(){
				window.alert("出现错误");
			}
		});
	}
	</script>
</head>
<body>

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-marketActivityOwner">
									<%
										// 获取所有用户信息
										List<User> allUser = (List<User>)session.getAttribute("allUser");

										// 遍历集合, 显示数据
										for(User user : allUser){
											if(user.getLockState().equals("0")){
												continue;
											}
									%>
									<option value="<%=user.getId()%>"><%=user.getLoginAct()%></option>
									<%
										}
									%>
								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-marketActivityName">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-startTime" placeholder="日期格式: yyyy-MM-dd">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-endTime" placeholder="日期格式: yyyy-MM-dd">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-describe"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="preservation">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-marketActivityOwner">
									<%
										// 遍历集合, 显示数据
										for(User user : allUser){
											if(user.getLockState().equals("0")){
												continue;
											}
									%>
									<option value="<%=user.getId()%>"><%=user.getLoginAct()%></option>
									<%
										}
									%>
								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-marketActivityName">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-startTime" placeholder="日期格式: yyyy-MM-dd">
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-endTime" placeholder="日期格式: yyyy-MM-dd">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="updateButton">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 导入市场活动的模态窗口 -->
    <div class="modal fade" id="importActivityModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 85%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">导入市场活动</h4>
                </div>
                <div class="modal-body" style="height: 350px;">
                    <div style="position: relative;top: 20px; left: 50px;">
                        请选择要上传的文件：<small style="color: gray;">[仅支持.xls]</small>
                    </div>
                    <div style="position: relative;top: 40px; left: 50px;">
                        <input type="file" id="activityFile">
                    </div>
                    <div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;" >
                        <h3>重要提示</h3>
                        <ul>
                            <li>操作仅针对Excel，仅支持后缀名为XLS的文件。</li>
                            <li>给定文件的第一行将视为字段名。</li>
                            <li>请确认您的文件大小不超过5MB。</li>
                            <li>日期值以文本形式保存，必须符合yyyy\MM\dd或yyyy-MM-dd格式。</li>
                            <li>日期时间以文本形式保存，必须符合yyyy-MM-dd HH-mm-ss的格式。</li>
                            <li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
                            <li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
                        </ul>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button id="importActivityBtn" type="button" class="btn btn-primary">导入</button>
                </div>
            </div>
        </div>
    </div>
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="queryActivityName">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="queryActivityOwner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control" type="text" id="queryActivityStartDate"/>
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control" type="text" id="queryActivityEndDate">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="queryButton">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="createButton"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="removeButton"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				<div class="btn-group" style="position: relative; top: 18%;">
                    <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importActivityModal" ><span class="glyphicon glyphicon-import"></span> 上传列表数据（导入）</button>
                    <button id="exportActivityAllBtn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-export"></span> 下载列表数据（批量导出）</button>
                    <button id="exportActivityXzBtn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-export"></span> 下载列表数据（选择导出）</button>
                </div>
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="selectAllCheckbox" value="selectCheckbox"/></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="showActivityInfo">
					</tbody>
				</table>
				<div id="paginationDisplay"></div>
			</div>
			
			<%--<div style="height: 50px; position: relative;top: 30px;">
				<div>
					<button type="button" class="btn btn-default" style="cursor: default;">共<b id="numberOfRecords"></b>条记录</button>
				</div>
				<div class="btn-group" style="position: relative;top: -34px; left: 110px;">
					<button type="button" class="btn btn-default" style="cursor: default;">显示</button>
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" id="showNumberPage1">
							10
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a href="javascript:void(0)" id="showNumberPage2">20</a></li>
							<li><a href="javascript:void(0)" id="showNumberPage3">30</a></li>
						</ul>
					</div>
					<button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
				</div>
				<div style="position: relative;top: -88px; left: 285px;">
					<nav>
						<ul class="pagination">
							<li class="disabled"><a href="javascript:void(0)" id="homePage">首页</a></li>
							<li class="disabled"><a href="javascript:void(0)" id="previousPage">上一页</a></li>
							<li class="active" id="a"><a href="javascript:void(0)">1</a></li>
							<li><a href="javascript:void(0)">2</a></li>
							<li><a href="javascript:void(0)" id="nextPage">下一页</a></li>
							<li class="disabled"><a href="javascript:void(0)" id="lastPage">末页</a></li>
						</ul>
					</nav>
				</div>
			</div>--%>
			
		</div>
		
	</div>
</body>
</html>