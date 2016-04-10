<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<body>

	<div id="wrapper">
		<%@ include file="../common/nav.jsp"%>
		<div id="page-wrapper" style="min-height: 243px;">
			<div class="row">
				<div class="col-md-12" style="margin-top: 30px">
					<div class="panel panel-info">
						<div class="panel-heading">用户</div>
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li role="presentation" class="active"><a href="#list" aria-controls="list" role="tab" data-toggle="tab">编辑</a></li>
							</ul>
							<div class="tab-content">
								<form action="${x}/account/setting/update?part=base"
									enctype="multipart/form-data" method="POST">
									<div class="form-horizontal">
										<div class="form-group ">
											<label class="control-label col-md-2">昵称</label>
											<div class="col-md-9">
												<input class="form-control" name="nick" id="nick"
													value="${user.nick}" />
												<div class="help-block with-errors" style="display: none;">昵称被占用</div>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-2">所属年级</label>
											<div class="col-md-9">
												<input class="form-control" name="location"
													value="${user.location}" />
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-2">最爱社交</label>
											<div class="col-md-9">
												<input class="form-control" name="twitter"
													value="${user.twitter}" />
											</div>
										</div>
										<div class="form-group ">
											<label class="control-label col-md-2">签名</label>
											<div class="col-md-9">
												<input class="form-control" name="signature" id="signature" value="${user.signature}">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-2">人生格言</label>
											<div class="col-md-9">
												<textarea rows="6" class="form-control" name="description">${user.description}</textarea>
											</div>
										</div>
										<div class="form-group">

											<div class="col-md-9 col-md-offset-2">
												<input type="submit" class="btn btn-info btn-block"
													value="更新资料">
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /#page-wrapper -->

	</div>

	<!-- /#wrapper -->

	<script src="${x}/js/bootstrap.min.js"></script>

	<script src="${x}/js/metisMenu.min.js"></script>

	<script src="${x}/js/sb-admin-2.js"></script>
	<script type="text/javascript">
	$("#nick").on("blur",function (e){
		var nick=$(this).val();
		var nickDIV=$(this);
		$.getJSON("${x}/account/checkNick?nick="+nick,function (msg){
			if(msg==1){
			nickDIV.parent().parent().addClass("has-error");
			nickDIV.parent().children(".with-errors").show();}
		});
	})
	$("#nick").on("focus",function (e){
						$(this).parent().parent().removeClass("has-error");
						$(this).parent().children(".with-errors").hide();
	});
	</script>
</body>
</html>
