<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %><%@ taglib prefix="my" uri="http://spring-abc.xyz/mytaglib" %><c:set value="<%=request.getContextPath() %>" var="x"></c:set><c:set value="${applicationScope}" var="p"></c:set><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<title>文理论坛</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="apple-mobile-web-app-capable" content="no">
	<meta content="True" name="HandheldFriendly">
	<link rel="shortcut icon" href="${x}/img/favicon.ico"/>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<link href="${x}/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="${x}/css/bootstrap-flat.css">
	<link href="${x}/css/font-awesome.css" rel="stylesheet">
	<link href="${x}/css/dropzone.min.css" rel="stylesheet">
	<script src="${x}/js/jquery.min.js"></script>
	<script src="${x}/js/bootstrap.min.js"></script>
	<script src="${x}/js/app.min.js"></script>
	<script type="text/javascript">
	function count(){
		$.getJSON("${x}/notifications/count",function (msg){
				if(msg!=$("#notification-count").html()){
					$("#notification-count").html(msg);
				}
		});
	}
		setInterval(count,45000);
	</script>
</head>