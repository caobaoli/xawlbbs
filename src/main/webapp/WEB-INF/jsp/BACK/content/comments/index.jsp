<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/head.jsp"%>
<body>

	<div id="wrapper">
		<%@ include file="../../common/nav.jsp"%>
		<div id="page-wrapper" style="min-height: 243px;">
			<div class="modal fade" id="delete" tabindex="-1"
				role="dialog">
				<div class="modal-dialog modal-danger modal-sm" role="document">
					<div class="modal-content">
						<div class="modal-body">
							<div class="modal-header">
								确定要删除？
							</div>
						</div>
						<div class="modal-body">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">取消</button>
							<button type="button" class="btn btn-danger btn-sure">删除</button>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12" style="margin-top: 30px">
					<div class="panel panel-info">
						<div class="panel-heading">话题</div>

						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li role="presentation" class="active"><a href="#list"
									aria-controls="list" role="tab" data-toggle="tab">列表</a></li>
							</ul>
							<div class="tab-content">
								<div role="tabpanel" class="tab-pane active" id="list">
									<div class="table-responsive">
										<table class="table table-hover">
											<thead>
												<tr>
													<th width="5%">#</th>
													<th width="45%">话题标题</th>
													<th width="10%">楼层</th>
													<th width="10%">创建者</th>
													<th width="10%">时间</th>
													<th width="10%">处理</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${comments}" var="comment">
												<tr>
													<td>${comment.id}</td>
													<td>
													<c:choose>  
                   										<c:when test="${fn:length(comment.topic.title) > 20}">  
                      									<c:out value="${fn:substring(comment.topic.title, 0, 20)}" /> . . .  
                   										</c:when>  
                  										<c:otherwise>  
                   										<c:out value="${comment.topic.title}" />  
                   										</c:otherwise>  
              										</c:choose>  
													</td>
													<td>#${comment.floor}</td>
													<td>${comment.user.nick}</td>
													<td>
														<fmt:formatDate value="${comment.createAt}" type="both"/>
													</td>
													<td>
														<a class="btn btn-info btn-xs" href="${x}/back/content/comments/${comment.id}/edit" target="_blank" >编辑</a>
														<button class="btn btn-danger btn-xs btn-delete" data-url="${x}/back/content/comments/${comment.id}/delete">删除</button>
													</td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>
									<!-- /.table-responsive -->
								</div>
							</div>
						</div>
						<div class="panel-footer">
						<%@ include file="/WEB-INF/jsp/common/pagination.jsp" %>
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
	$(".btn-delete").on("click",function (e){
		var url=$(this).attr("data-url");
		$("#delete").modal('show');
		$(".btn-sure").on("click",function (e){
			location.href=url;
		})
	})
	</script>
</body>
</html>
