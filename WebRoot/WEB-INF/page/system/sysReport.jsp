<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
</head>
<body style="background:#E0EEFB;">
<h3 class="jiangbu-title">报告列表管理</h3>
<div id="jiangbu-data">
<div style="margin:0 auto; width:200px; padding-top:10px;">
<table class="data_list" cellpadding="0" cellspacing="0" width="180px;">
   	<thead>
    <tr class="tabtr12">
        <td width="20%">报告标题</td>
    </tr>
    </thead>
    <tbody id="splitpage">
    <s:iterator value="#application.vta.GetList('reportlist')" var="rl">
    	<tr>
    		<td align="left">
    			&nbsp;&nbsp;<a href="${pageContext.request.contextPath }/system/sysReportAction_configReport.do?reportflag=<s:property value="#rl.id"/>&reportName=<s:property value="#rl.str"/>"><s:property value="#rl.str"/></a>
    		</td>
    	</tr>	
    </s:iterator>
	</tbody>
</table>
</div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
</body>
</html>