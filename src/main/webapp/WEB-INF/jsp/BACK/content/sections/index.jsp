<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/head.jsp"%>
<body>
	<div id="wrapper">
		<%@ include file="../../common/nav.jsp"%>
		<div id="page-wrapper" style="min-height: 243px;">
			<div class="modal  fade" id="delete" tabindex="-1"
				role="dialog">
				<div class="modal-dialog modal-danger modal-sm" role="document">
					<div class="modal-content">
						<div class="modal-body">
							<div class="modal-header">
								亲，确定要删除？
								(要删除请将先将所包含的话题删除，否则不能删除！！！)
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
				<%@ include file="../../common/msg.jsp" %>
					<div class="panel panel-info">
						<div class="panel-heading">节点</div>

						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#" >列表</a></li>
								<li class=""><a href="${back}/content/sections/new" >新增</a></li>
							</ul>
							<div class="tab-content">
									<div class="table-responsive">
										<table class="table table-hover">
											<thead>
												<tr>
												<th width="5%">#</th>
													<th width="15%">名字</th>
													<th width="57%">描述</th>
													<th width="10%">话题数</th>
													<th width="10%">处理</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${nodes}" var="node">
												<tr>
													<td>${node.id}</td>
													<td>${node.name}</td>
													<td>
													<c:choose>  
                   										<c:when test="${fn:length(node.description) > 20}">  
                      									<c:out value="${fn:substring(node.description, 0, 20)}" /> . . .  
                   										</c:when>  
                  										<c:otherwise>  
                   										<c:out value="${node.description}" />  
                   										</c:otherwise>  
              										</c:choose> 
													</td>
													<td>${node.topicCount}</td>
													<td>
														<a class="btn btn-info btn-xs" href="${x}/back/content/sections/${node.id}/edit" >编辑</a>
														<button class="btn btn-danger btn-xs btn-delete"
															 data-url="${x}/back/content/sections/${node.id}/delete">删除</button>
													</td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>
									<!-- /.table-responsive -->
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

	<script src="${x}/js/jquery.min.js"></script>

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
