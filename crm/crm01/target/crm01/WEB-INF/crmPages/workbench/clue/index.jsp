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
	<meta charset="UTF-8">
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
		queryClueShowPage();
		// 用户点击查询按钮, 查询线索数据, 显示页面
		$("#queryButton").click(function(){
			queryClueShowPage();
		});

		// 用户点击id为selectAllCheckbox的checkbox, 当前页面的checkbox变为全部选中状态
		$("#selectAllCheckbox").click(function(){
			var flag = $("#selectAllCheckbox").prop("checked");
			var $allCheckbox = $(":checkbox");
			$allCheckbox.prop("checked", flag);
		});

		// 按钮全部选中时, 全选按钮选中, 按钮取消时, 全选按钮取消选中
		$("#showClueData").on("click", ":checkbox", function(){
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

		// 用户点击保存按钮, 创建线索, 刷新页面, 显示数据
		$("#saveButton").click(function(){
			// 获取用户选择的创建线索所有者
			var createClueOwner = $("#create-clueOwner").val();
			// 获取用户输入的创建线索公司
			var createCompany = $("#create-company").val();
			// 获取用户输入的创建线索用户称呼
			var createCall = $("#create-call").val();
			// 获取用户输入的创建线索用户姓名
			var createFullname = $("#create-surname").val();
			// 获取线索用户职位
			var createJob = $("#create-job").val();
			// 获取用户输入的创建线索邮箱
			var createEmail = $("#create-email").val();
			//  获取用户输入的创建公司座机
			var createCompanyLandline = $("#create-phone").val();
			// 获取用户输入的创建公司网站
			var createWebsite = $("#create-website").val();
			// 获取用户输入的创建线索手机
			var createMobilePhone = $("#create-mphone").val();
			// 获取用户输入的创建线索状态
			var createClueState = $("#create-status").val();
			// 获取用户输入的创建线索来源
			var createClueSource = $("#create-source").val();
			// 获取用户输入的创建线索描述
			var createClueDescribe = $("#create-describe").val();
			// 获取用户输入的创建联系纪要
			var createContactSummary = $("#create-contactSummary").val();
			// 获取用户输入的下次联系时间
			var createNextContactTime = $("#create-nextContactTime").val();
			// 获取用户输入的创建详细地址
			var createDetailedAddress = $("#create-address").val();
			// 判断是否全部为空
			if(isEmpty(createCompany) && isEmpty(createCall) && isEmpty(createFullname) && isEmpty(createJob)
					&& isEmpty(createCompanyLandline) && isEmpty(createWebsite) && isEmpty(createMobilePhone) && isEmpty(createClueState)
					&& isEmpty(createClueSource) && isEmpty(createClueDescribe) && isEmpty(createContactSummary) && isEmpty(createNextContactTime)
					&& isEmpty(createDetailedAddress)){
				window.alert("线索为空");
				return;
			}
			// 判断公司是否为空
			if(isEmpty(createCompany)){
				window.alert("公司不能为空");
				return;
			}
			if(isEmpty(createFullname)){
				window.alert("名称不能为空");
				return;
			}

			if(! isEmpty(createEmail)){
				createEmail = createEmail.trim();
				// 判断用户输入的创建线索邮箱是否符合语法
				// 创建正则表达式对象
				var emailRegRxp = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
				if(! emailRegRxp.test(createEmail)){
					window.alert("输入的邮箱格式不符合要求");
					return;
				}
			}
			var clueData = "clueOwner=" + createClueOwner + "&company=" + createCompany + "&call=" + createCall + "&fullname=" + createFullname
					+ "&job=" + createJob + "&email=" + createEmail + "&companyLandline=" + createCompanyLandline + "&website=" + createWebsite
					+ "&mobilePhone=" + createMobilePhone + "&clueState=" + createClueState + "&clueSource=" + createClueSource
					+ "&clueDescribe=" + createClueDescribe + "&contactSummary=" + createContactSummary + "&nextContactTime=" + createNextContactTime
					+ "&detailedAddress=" + createDetailedAddress

			// 发起Ajax请求
			$.ajax({
				url : "<%=path%>createClue.do?" + clueData,   // 请求地址
				type : "post",   // 请求方式
				dataType : "json",   // 希望得到的数据格式
				success : function(data){
					if(! data.flag){
						window.alert("创建失败");
						return;
					}
					queryClueShowPage();
				},
				error : function(){
					window.alert("出现错误");
				}
			});
		});

		// 用户点击删除按钮, 删除线索
		$("#removeClue").click(function(){
			if(! window.confirm("是否要删除线索")){
				return;
			}
			// 获取所有被选中的checkbox
			var $allCheckboxChecked = $(":checkbox:checked");
			// 遍历数组, 取出每一个checkbox的value值
			var ids = "";
			$.each($allCheckboxChecked, function(index, element){
				if(index == 0){
					ids += element.value;
					return;
				}

				if(element.value == "selectCheckbox"){
					return;
				}
				ids += "," + element.value;
			});

			// 判断用户是否选择了要删除的线索
			if(isEmpty(ids)){
				window.alert("请选择要删除的线索");
				return;
			}

			// 发起Ajax请求
			$.ajax({
				url : "<%=path%>removeClue.do",
				dataType : "json",
				type : "post",
				data : {
					"ids" : ids
				},
				success : function(data){
					if(! data.flag){
						window.alert("删除失败");
						return;
					}
					$(":checkbox:checked").prop("checked", false);
					queryClueShowPage();
				},
				error : function(){
					window.alert("出现错误");
				}
			});
		});

		// 用户点击修改按钮, 打开修改界面, 显示需要修改的页面
		$("#showUpdateButton").click(function(){
			var $checkboxChecked = $(":checkbox:checked");
			if($checkboxChecked.size() != 1 && ! ($checkboxChecked.size() == 2 && $(":checkbox").size() == 2)){
				window.alert("请选择一个要修改的线索");
				return;
			}
			// 打开修改模态窗口
			$("#editClueModal").modal("show");
			var id = "";
			if($checkboxChecked[0].value == "selectCheckbox"){
				id = $checkboxChecked[1].value;
			}else{
				id = $checkboxChecked[0].value;
			}
			// 发起Ajax请求, 获取线索数据, 显示数据
			$.ajax({
				url : "<%=path%>byIdQueryClue.do",
				dataType : "json",
				type : "post",
				data : {
					"id" : id
				},
				success : function(data){
					$("#edit-clueOwner option[value = '"+data.owner+"']").prop("selected", "selected");
					$("#edit-company").val(data.company);
					$("#edit-call option[value ='"+data.appellation+"']").prop("selected", "selected");
					$("#edit-surname").val(data.fullname);
					$("#edit-job").val(data.job);
					$("#edit-email").val(data.email);
					$("#edit-phone").val(data.phone);
					$("#edit-website").val(data.website);
					$("#edit-mphone").val(data.mphone);
					$("#edit-status option[value = '"+data.state+"']").prop("selected", "selected");
					$("#edit-source option[value = '"+data.source+"']").prop("selected", "selected");
					$("#edit-describe").text(data.description);
					$("#edit-contactSummary").text(data.contactSummary);
					$("#edit-nextContactTime").val(data.nextContactTime);
					$("#edit-address").text(data.address);
				},
				error : function(){
					window.alert("出现错误");
				}
			});
		});

		// 用户点击更新按钮, 通过线索id更新数据
		$("#updateButton").click(function(){
			var $checkboxChecked = $(":checkbox:checked");
			// 获取用户选中的线索id
			var id = "";
			if($checkboxChecked[0].value == "selectCheckbox"){
				id = $checkboxChecked[1].value;
			}else{
				id = $checkboxChecked[0].value;
			}
			// 获取线索所有者
			var owner = $("#edit-clueOwner").val();
			// 获取线索公司
			var company = $("#edit-company").val();
			// 获取用户称呼
			var cell = $("#edit-call").val();
			// 获取用户名字
			var name = $("#edit-surname").val();
			// 获取线索用户职位
			var job = $("#edit-job").val();
			// 获取用户邮箱
			var email = $("#edit-email").val();
			// 获取公司座机
			var companyLandline = $("#edit-phone").val();
			// 获取用户公司网站
			var website = $("#edit-website").val();
			// 获取用户手机
			var mobilePhone = $("#edit-mphone").val();
			// 获取线索状态
			var clueState = $("#edit-status").val();
			// 获取线索来源
			var clueSource = $("#edit-source").val();
			// 获取线索描述
			var clueDescribe = $("#edit-describe").val();
			// 获取联系纪要
			var contactSummary = $("#edit-contactSummary").val();
			// 获取下次联系时间
			var nextContactTime = $("#edit-nextContactTime").val();
			// 获取地址
			var address = $("#edit-address").val();
			// 判断数据是否符合要求
			// 判断是否全部为空
			if(isEmpty(company) && isEmpty(cell) && isEmpty(name) && isEmpty(job) && isEmpty(email)
					&& isEmpty(companyLandline) && isEmpty(website) && isEmpty(mobilePhone) && isEmpty(clueState)
					&& isEmpty(clueSource) && isEmpty(clueDescribe) && isEmpty(contactSummary) && isEmpty(nextContactTime)
					&& isEmpty(address)){
				window.alert("线索为空");
				return;
			}
			// 判断公司是否为空
			if(isEmpty(company)){
				window.alert("公司不能为空");
				return;
			}
			if(isEmpty(name)){
				window.alert("名称不能为空");
				return;
			}

			if(! isEmpty(email)){
				email = email.trim();
				// 判断用户输入的创建线索邮箱是否符合语法
				// 创建正则表达式对象
				var emailRegRxp = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
				if(! emailRegRxp.test(email)){
					window.alert("输入的邮箱格式不符合要求");
					return;
				}
			}
			var data = "?owner=" + owner + "&company=" + company + "&cell=" + cell + "&name=" + name + "&job=" + job + "&email=" + email
					+ "&companyLandline=" + companyLandline + "&website=" + website + "&mobilePhone=" + mobilePhone + "&clueState=" + clueState
					+ "&clueSource=" + clueSource + "&clueDescribe=" + clueDescribe + "&contactSummary=" + contactSummary
					+ "&nextContactTime=" + nextContactTime + "&address=" + address + "&id=" + id;
			// 发起Ajax请求, 更新线索
			$.ajax({
				url : "<%=path%>alterClue.do" + data,
				dataType : "json",
				type : "post",
				success : function(data){
					if(! data.flag){
						window.alert("修改失败");
						return;
					}
					queryClueShowPage();
				},
				error : function(){
					window.alert("出现错误");
				}
			});
		});
	});

	/**
	 * 查询线索, 显示页面
	 */
	function queryClueShowPage(currentPage){
		if(currentPage == null || currentPage == ""){
			// 初始页面为第一页
			currentPage = 1;
		}
		// 获取checkbox按钮的选中状态
		var allCheckboxFlag = $(":checkbox").prop("checked");
		// 获取用户输入的查询线索名称
		var clueName = $("#queryClueName").val();
		// 获取用户输入的查询公司
		var clueCompany = $("#queryClueCompany").val();
		// 获取用户输入的查询公司座机
		var companyLandline = $("#queryClueCompanyLandline").val();
		// 获取用户选中的查询线索来源
		var clueSource = $("#checkedQueryClueSource").val();
		// 获取用户输入的查询的线索所有者
		var clueOwner = $("#queryClueOwner").val();
		// 获取用户输入的查询的手机
		var mobilePhone = $("#queryMobilePhone").val();
		// 获取用户输入的查询线索状态
		var clueState = $("#queryClueState").val();

		// 发起Ajax请求, 通过条件查询线索数据, 显示页面
		$.ajax({
			url : "<%=path%>queryClue.do",   // 请求地址
			dataType : "",   // 请求希望获取的数据类型
			data : {
				// 请求携带的数据
				"clueName" : clueName,   // 线索名
				"clueCompany" : clueCompany,   // 公司
				"companyLandline" : companyLandline,   // 公司座机
				"clueSource" : clueSource,   // 线索来源
				"clueOwner" : clueOwner,   // 线索所有者
				"mobilePhone" : mobilePhone,   // 手机
				"clueState" : clueState,  // 线索状态
				"pageNumber" : currentPage  // 显示页数
			},
			success : function(data){
				// 请求结束后执行的函数
				// 显示数据
				var showStr = "";
				$.each(data.clue, function(index, clue){
					showStr += "<tr class=\"active\">";
					showStr += "<td><input type=\"checkbox\" value='"+clue.id+"'/></td>";
					showStr += "<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='<%=path%>workbench/clue/detail.do?id="+clue.id+"';\">" + clue.fullname + clue.appellation + "</a></td>";
					showStr += "<td>"+clue.company+"</td>";
					showStr += "<td>"+clue.phone+"</td>";
					showStr += "<td>"+clue.mphone+"</td>";
					showStr += "<td>"+clue.source+"</td>";
					showStr += "<td>"+clue.owner+"</td>";
					showStr += "<td>"+clue.state+"</td>";
					showStr += "</tr>";
				});
				$("#showClueData").html(showStr);
				new Pagination({
					element : "#paginationDisplay",   // 显示分页插件的位置
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
						queryClueShowPage(index);
					}
				});

				if(allCheckboxFlag){
					// 查询数据之前是选中状态
					$(":checkbox").prop("checked", true);
				}else{
					// 查询数据之前是没有选中状态
					$(":checkbox").prop("checked", false);
				}
			},
			error : function(){
				// 出现错误后执行的函数
				window.alert("出现错误");
			}
		});
	}

	/**
	 * 判断数据是否为空, 数据为空返回true, 数据不为空返回false
	 */
	function isEmpty(data){
		if(data == null || data == ""){
			return true;
		}
		return false;
	}

	</script>
</head>
<body>

	<!-- 创建线索的模态窗口 -->
	<div class="modal fade" id="createClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">创建线索</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-clueOwner">
								  <%
									  // 获取所有用户信息
									  List<User> allUser = (List<User>)session.getAttribute("allUser");
								  	  for(User user : allUser){
											// 账号被锁定时, 该账号不显示
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
							<label for="create-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-company">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-call">
								  <option></option>
								  <option>先生</option>
								  <option>夫人</option>
								  <option>女士</option>
								  <option>博士</option>
								  <option>教授</option>
								</select>
							</div>
							<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-surname">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-job">
							</div>
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone">
							</div>
							<label for="create-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-website">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-mphone">
							</div>
							<label for="create-status" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-status">
								  <option></option>
								  <option>试图联系</option>
								  <option>将来联系</option>
								  <option>已联系</option>
								  <option>虚假线索</option>
								  <option>丢失线索</option>
								  <option>未联系</option>
								  <option>需要条件</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-source">
								  <option></option>
								  <option>广告</option>
								  <option>推销电话</option>
								  <option>员工介绍</option>
								  <option>外部介绍</option>
								  <option>在线商场</option>
								  <option>合作伙伴</option>
								  <option>公开媒介</option>
								  <option>销售邮件</option>
								  <option>合作伙伴研讨会</option>
								  <option>内部研讨会</option>
								  <option>交易会</option>
								  <option>web下载</option>
								  <option>web调研</option>
								  <option>聊天</option>
								</select>
							</div>
						</div>
						

						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">线索描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-describe"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-nextContactTime">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>
						
						<div style="position: relative;top: 20px;">
							<div class="form-group">
                                <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="create-address"></textarea>
                                </div>
							</div>
						</div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="saveButton">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改线索的模态窗口 -->
	<div class="modal fade" id="editClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改线索</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-clueOwner">
									<%
										for(User user : allUser){
											// 账号被锁定时, 该账号不显示
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
							<label for="edit-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-company">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-call">
								  <option value=""></option>
								  <option value="先生">先生</option>
								  <option value="夫人">夫人</option>
								  <option value="女士">女士</option>
								  <option value="博士">博士</option>
								  <option value="教授">教授</option>
								</select>
							</div>
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-surname">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job">
							</div>
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone">
							</div>
							<label for="edit-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-website">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone">
							</div>
							<label for="edit-status" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-status">
								  <option value=""></option>
								  <option value="试图联系">试图联系</option>
								  <option value="将来联系">将来联系</option>
								  <option value="已联系">已联系</option>
								  <option value="虚假线索">虚假线索</option>
								  <option value="丢失线索">丢失线索</option>
								  <option value="未联系">未联系</option>
								  <option value="需要条件">需要条件</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-source">
								  <option value=""></option>
								  <option value="广告">广告</option>
								  <option value="推销电话">推销电话</option>
								  <option value="员工介绍">员工介绍</option>
								  <option value="外部介绍">外部介绍</option>
								  <option value="在线商场">在线商场</option>
								  <option value="合作伙伴">合作伙伴</option>
								  <option value="公开媒介">公开媒介</option>
								  <option value="销售邮件">销售邮件</option>
								  <option value="合作伙伴研讨会">合作伙伴研讨会</option>
								  <option value="内部研讨会">内部研讨会</option>
								  <option value="交易会">交易会</option>
								  <option value="web下载">web下载</option>
								  <option value="web调研">web调研</option>
								  <option value="聊天">聊天</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-nextContactTime">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address"></textarea>
                                </div>
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
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>线索列表</h3>
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
				      <input class="form-control" type="text" id="queryClueName">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司</div>
				      <input class="form-control" type="text" id="queryClueCompany">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司座机</div>
				      <input class="form-control" type="text" id="queryClueCompanyLandline">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">线索来源</div>
					  <select class="form-control" id="checkedQueryClueSource">
					  	  <option value=""></option>
					  	  <option value="广告">广告</option>
						  <option value="推销电话">推销电话</option>
						  <option value="员工介绍">员工介绍</option>
						  <option value="外部介绍">外部介绍</option>
						  <option value="在线商场">在线商场</option>
						  <option value="合作伙伴">合作伙伴</option>
						  <option value="公开媒介">公开媒介</option>
						  <option value="销售邮件">销售邮件</option>
						  <option value=合作伙伴研讨会"">合作伙伴研讨会</option>
						  <option value="内部研讨会">内部研讨会</option>
						  <option value="交易会">交易会</option>
						  <option value="web下载">web下载</option>
						  <option value="web调研">web调研</option>
						  <option value="聊天">聊天</option>
					  </select>
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="queryClueOwner">
				    </div>
				  </div>
				  
				  
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">手机</div>
				      <input class="form-control" type="text" id="queryMobilePhone">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">线索状态</div>
					  <select class="form-control" id="queryClueState">
					  	<option value=""></option>
					  	<option value="试图联系">试图联系</option>
					  	<option value="将来联系">将来联系</option>
					  	<option value="已联系">已联系</option>
					  	<option value="虚假线索">虚假线索</option>
					  	<option value="丢失线索">丢失线索</option>
					  	<option value="未联系">未联系</option>
					  	<option value="需要条件">需要条件</option>
					  </select>
				    </div>
				  </div>

				  <button type="button" class="btn btn-default" id="queryButton">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createClueModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" data-toggle="modal" id="showUpdateButton"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="removeClue"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 50px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="selectAllCheckbox" value="selectCheckbox"/></td>
							<td>名称</td>
							<td>公司</td>
							<td>公司座机</td>
							<td>手机</td>
							<td>线索来源</td>
							<td>所有者</td>
							<td>线索状态</td>
						</tr>
					</thead>
					<tbody id="showClueData">
						<!--显示线索信息-->
						<%--<tr>
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">李四先生</a></td>
							<td>动力节点</td>
							<td>010-84846003</td>
							<td>12345678901</td>
							<td>广告</td>
							<td>zhangsan</td>
							<td>已联系</td>
						</tr>--%>
					</tbody>
				</table>
				<div id="paginationDisplay"></div>
			</div>
			
			<%--<div style="height: 50px; position: relative;top: 60px;">
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
			</div>--%>
			
		</div>
		
	</div>
</body>
</html>