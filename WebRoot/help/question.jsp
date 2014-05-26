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
		<center>
		<h4 style="width:600px; text-align:left">1.解决IE8下打印被缩小的问题</h4>
		<p style="width:600px; text-align:left">由于IE8对打印增加了【缩小字体填充】功能，会采用75%比例缩小模式，在打印农户信息时，
		可能不能占满A4纸张，如出现这样的问题，
		请点<a href="${pageContext.request.contextPath }/regFileDownLoad">下载</a>，
		双击下载的文件,选择是，将注册表信息导入系统，如下图所示</p>
		<p style="width:600px; text-align:left"><img src="<%=basePath %>/images/reg_writeg.jpg"/></p>
		<p style="width:600px; text-align:left">关闭IE8浏览器，重新登录并打开打印页面进行打印。</p>
		<h4 style="width:600px; text-align:left">2.解决IE8打印空白问题</h4>
		
		</center>
	</body>
</html>
