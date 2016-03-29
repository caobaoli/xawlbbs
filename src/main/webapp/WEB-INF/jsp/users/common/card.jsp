<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-info">
	<div class="panel-body ">
		<div class="media">
			<div class="media-body">
				<p>
					<a href="${x}/users/${user.id}/topics"><h4>${user.nick}</h4>(${user.role})</a>
				</p>
				<p>第${user.number}号会员</p>
				<p>加入于${user.createAt}</p>
				<hr style="margin: 0px">
			</div>
		</div>
	</div>
</div>