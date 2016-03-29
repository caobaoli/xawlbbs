<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="panel panel-info">
					<div class="panel-body ">
						<div class="media">
							<div class="media-left text-center">
								<a href="${x}/users/${topic.user.id}/topics"></a>
							</div>
							<div class="media-body">
								<p>
									<a href="${x}/users/${topic.user.id}/topics"><h4>发表人：${topic.user.nick}</h4>${topic.user.role}</a>
								</p>
								<p>第${topic.user.number}号会员</p>
								<p>加入于${topic.user.createAt}</p>
								<hr style="margin: 0px">
							</div>

						</div>
					</div>
				</div>