<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/global_cn.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
</head>
<body style="background:#E0EEFB;">
	<h3 class="jiangbu-title">导出县数据</h3>
	<form name="form1" action="dataExportAction_exportData.do" method="post">
	<div style="margin:0 auto; width:310px; height:300px; padding-top:0px;">
		<p></p>
		<p>&nbsp;</p> 
		<p>导出文件名称：<input type="text" id="fname" name="zipFileName" value="【<s:property value='#session.vts.rbm'/>】<s:property value='#session.vts.rbn'/>" class="input_w160">
		</p>
		<br/>
        <p>
        	<input type="button" value="导出" class="btn_w70" onclick="exportData()">
        </p>
        <p>&nbsp;</p> 
	</div>
	</form>
	<script type="text/javascript">
		function exportData(){
			form1.submit();
		}
	</script>
</body>
</html>