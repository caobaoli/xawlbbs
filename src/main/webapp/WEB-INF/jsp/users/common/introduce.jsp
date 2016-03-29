<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-info">
	<div class="panel-heading">会员信息</div>
	<ul class="list-group">
		<li class="list-group-item"><i class="fa fa-map-marker"></i> 所属年级:
		<span>${user.location}</span>
		</li>
		<li class="list-group-item"><i class="fa  fa-twitter"></i> 最爱社交: 
		<a href="${user.twitter}"><span>${user.twitter}</span></a></li>
		<li class="list-group-item"><i class="fa  fa-info-circle fa-lg"></i> 人生格言:
		<p>${user.description}</p></li>
	</ul>

</div>