<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'header.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style>
#title {
	color: #fff;
	font-size: 30px;
	line-height: 30px;
	font-weight: bold;
	margin: 20px 0 0 50px;
}

#count {
	color: #fff;
	font-size: 10px;
	line-height: 10px;
	float: right;
	margin-right: 30px;
}
</style>
<script src="js/jquery.js" type="text/javascript"></script>

<script type="text/javascript">
	var socket = new WebSocket("ws://192.168.0.139:8080/stuWeb/socket");
	socket.onopen = function() {
		//浏览器socket开始进入
		console.log("open");

	};
	socket.onmessage = function(evt) {
	console.log(evt.data);
		$("#count span").html(evt.data)
	};
	socket.onclose = function(evt) {

	};
	socket.onerror = function(evt) {

	};
</script>
</head>

<body style="background: #337ab7">

	<div id="title">念字教务管理系统</div>

	<div id="count">
		当前在线人数:<span></span>
	</div>
</body>
</html>
