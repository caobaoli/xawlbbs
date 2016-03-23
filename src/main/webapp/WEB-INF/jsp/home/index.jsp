<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<body>
	<%@ include file="/WEB-INF/jsp/common/nav.jsp"%>
	<div class="main-container container">
		<%@ include file="/WEB-INF/jsp/common/msg.jsp"%>
		<div class="row">
			<div class="col-md-9">
				<div class="panel panel-info">
					<div class="panel-heading">
						<div class="btu-group ">
							<a href="${x}/"
								class="btn btn-xs <c:if test="${'all' eq sectionName }">btn-info</c:if>">全部</a>
							<a href="${x}/!hot"
								class="btn btn-xs <c:if test="${'hot' eq sectionName }">btn-info</c:if>">热门</a>
							<a href="${x}/!focused"
								class="btn btn-xs <c:if test="${'focused' eq sectionName }">btn-info</c:if>">关注</a>
						</div>
					</div>

					<ul class="list-group-panel-body list-group">
						<c:forEach items="${topics}" var="topic">

							<li class="list-group-item">
								<div class="media">
									<div></div>
									<div class="media-body">
										<p>
											<a href="${x}/nodes/${topic.node.id}"
												class="btn btn-info btn-xs">${topic.node.name}</a> <a
												href="${x}/topics/${topic.id}" class="media-title">${topic.title}
											</a>
										</p>
										<p class="meta">
											<a href="${x}/users/${topic.user.id}/topics">
												${topic.user.nick}</a> •<my:Flashback time="${topic.createAt}"></my:Flashback>
										</p>
									</div>
									<div class="media-right media-middle">
										<span class="badge">${topic.commentCount}</span>
									</div>
								</div>
							</li>
						</c:forEach>
					</ul>
					<div class="panel-footer ">
						<%@ include file="/WEB-INF/jsp/common/pagination.jsp"%><!-- 公共部分用于分页 -->
					</div>
				</div>
			</div>
			<div class="col-md-3 sidebar">
				<div class="panel panel-info">
					<div class="panel-body">
						<div class="col-md-12">
							<a href="${x}/topics/create"
								class="btn btn-lg btn-info btn-block"> 发布新话题 </a>
						</div>
					</div>
				</div>
				
				<div class="panel panel-info">
					<div class="panel-heading">学校概况</div>
					<a class="btn btn-info btn-xs btn-tag" href="http://www.xawl.org/">学校官网</a>
					<a class="btn btn-info btn-xs btn-tag" href="http://www.xawl.org/info/iList.jsp?cat_id=10002">学校简介</a>
					<a class="btn btn-info btn-xs btn-tag" href="http://www.xawl.org/info/iList.jsp?cat_id=10005">学校发展史</a>
					<a class="btn btn-info btn-xs btn-tag" href="http://www.xawl.org/info/iList.jsp?cat_id=10007">校园风光</a>
				</div>
				
				<div class="panel panel-info">
					<div class="panel-heading">校园文化</div>
					<a class="btn btn-info btn-xs btn-tag" href="http://tuanwei.xawl.edu.cn/">文理先锋网</a>
					<a class="btn btn-info btn-xs btn-tag" href="http://www.xawl.org/info/iList.jsp?cat_id=10026">文理学生会</a>
					<a class="btn btn-info btn-xs btn-tag" href="http://www.xawl.org/info/iList.jsp?cat_id=10027">文理社团</a>
					<a class="btn btn-info btn-xs btn-tag" href="http://www.xawl.org/info/iList.jsp?cat_id=10028">文理大礼堂</a>
					<a class="btn btn-info btn-xs btn-tag" href="http://gonghui.xawl.edu.cn/">教工之家</a>
					<a class="btn btn-info btn-xs btn-tag" href="http://xuanchuanbu.xawl.org/xuanchuanbu/baozhi/">文理校报</a>
				</div>
	
				<div class="panel panel-info">
					<div class="panel-heading">热门分类</div>
						<c:forEach items="${hotNodes}" var="node">
							<a class="btn btn-info btn-xs btn-tag" href="${x}/nodes/${node.id}">${node.name}</a>
						</c:forEach>
						<a class="btn btn-info btn-xs btn-tag" href="${x}/nodes/${node.id}"><span class="fa fa-th"></span> 所有节点</a>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
</body>
</html>