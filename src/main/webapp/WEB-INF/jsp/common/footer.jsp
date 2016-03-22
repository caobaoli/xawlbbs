<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="footer" style="border-top:1px;border-bottom:0px;border-left:0px;border-right:0px; border-style: solid;    border-color: #bce8f1;">
<div class="container">
	${p.nav_footer.content}
	<div class="row">
		<div class="col-md-4">
		♡ 系统开发者 xiao.peng.li 
		</div>
		<div class="col-md-4 text-center">
			版权所有：西安文理学院  邮编：710065
		</div>
		<div class="col-md-4 text-right">
		友情提示_页面加载时间：<b><%=System.currentTimeMillis()-(Long)request.getAttribute("startTime") %></b>ms
		</div>
	</div>
	${p.footer_script.content}
</div>