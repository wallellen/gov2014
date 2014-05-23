<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>江苏省扶贫管理系统-常见问题</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
	<body>
		<p>如使用[IE8浏览器]打印农户详细信息时，页面显示不正常[页面缩小]时，可以点击
		<a href="${pageContext.request.contextPath }/regFileDownLoad">下载</a>
		，双击下载的文件安装，然后重启浏览器即可。</p>
	</body>
</html>
