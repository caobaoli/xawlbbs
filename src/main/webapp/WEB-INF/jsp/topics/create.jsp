<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<body>
	<%@ include file="/WEB-INF/jsp/common/nav.jsp"%>
	<div class="main-container container">
		<%@ include file="/WEB-INF/jsp/common/msg.jsp"%>
		<!-- Modal -->
		<div class="modal fade" id="preview" tabindex="-1" role="dialog"
			aria-labelledby="preview">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">预览</h4>
					</div>
					<div class="modal-body" id="preview-body"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" data-dismiss="modal">确定</button>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-9">
							<ol class="breadcrumb">
  <li><a href="${x}/">Topic</a></li>
  <li class="active">新建</li>
</ol>
				<div class="panel panel-info">
					<div class="panel-heading">创建</div>
					<div class="panel-body">
						<form role="form" action="${x}/topics/save" method="POST" data-toggle="validator">
							<div class="form-group">
								<label class="control-label">定位</label>
								<div class="row">
									<div class="col-md-6">
										<div class="input-group">
											<span class="input-group-addon">分类</span> <select
												class="form-control" id="section">
												<c:forEach items="${sections}" var="section">
													<option value="${section.name}">${section.name}</option>
												</c:forEach>
											</select>
										</div>
									</div>
									<div class="col-md-6">
										<div class="input-group">
											<span class="input-group-addon">节点</span> <select
												class="form-control" id="topicNodeName" name="topicNodeName">
												<option value="${topic.node.name}">${topic.node.name}</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label>标题</label> <input name="title" data-minlength="6" data-error="标题至少六个字" id="title"
									class="form-control" required="required">
									<div class="help-block with-errors"></div>
							</div>
							<div class="form-group">
								<label>正文</label>
								<div class="btn-group pull-right">
									<button type="button" id="btn-preview" class="btn btn-info"
										style="border-right-width: 2px; border-right-color: #555;"
										data-toggle="modal" data-target="#preview">预览</button>
								</div>
								<textarea rows="30" class="form-control" name="content"
									id="content" data-minlength="6" data-error="正文不少于六个字" required="required"></textarea>
									<div class="help-block with-errors"></div>
							</div>
							<div class="btn-group">
								<button type="submit"  class="btn btn-info">
									发 送</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- 
			<div class="col-md-3 sidebar">
				<div class="panel panel-info">
					<div class="panel-heading">须知</div>
				</div>
			</div>
			 -->
		</div>
	</div>
	<script src="${x}/js/marked.min.js"></script>
	<script src="${x}/js/dropzone.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			var sectionName = $("#section").val();
			var url = "${x}/nodes/list/"+ sectionName;
			$.getJSON(url,function (nodeNames){
				var nodeNamesStr="";
				for(var i=0;i<nodeNames.length;i++){
					nodeNamesStr+="<option>"+nodeNames[i]+"</option>";
				}
				console.log(nodeNamesStr);
				$("#topicNodeName").html(nodeNamesStr);
			});
		});
		$("#section").on("change",function(e) {
							var sectionName = $("#section").val();
							var url = "${x}/nodes/list/"+ sectionName;
							$.getJSON(url,function (nodeNames){
								var nodeNamesStr="";
								for(var i=0;i<nodeNames.length;i++){
									nodeNamesStr+="<option>"+nodeNames[i]+"</option>";
								}
								console.log(nodeNamesStr);
								$("#topicNodeName").html(nodeNamesStr);
							});
											
						});
		$("#btn-preview").on("click", function(e) {
			var content = $("#content").val();
			console.log(content);
			var content_marked = marked(content);
			$("#preview-body").html(content_marked);
		});
	</script>
	<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
</body>
</html>