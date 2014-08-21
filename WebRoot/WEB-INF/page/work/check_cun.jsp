<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
</head>
<body style="background:#E0EEFB;">
<h3 class="jiangbu-title">审核 [<s:property value="cunname"/>] 信息&nbsp;&nbsp;村码：<s:property value="cunbm"/>
	<span style="width:60px; float:right">
		<input type="button" value="返回" class="button43" onclick="location.href='${pageContext.request.contextPath }/system/govBrowerAction_viewArea.do?viewBM=<s:property value='#session.vts.curBM'/>'"/>
	</span>
</h3>
<div id="jiangbu-data">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
    <tr class="tabtr12">
        <td width="20%" align="center">代码</td>
        <td width="80%">描述</td>
    </tr>
    </thead>
    <tbody id="splitpage">
    <s:if test="#session.vts.list.size()!=0">
    <s:iterator value="#session.vts.list" var="ls" status="sc">
    <tr style="display:none">
        <td align="center"><s:property value="#ls.code"/></td>
        <td align="left">
        	<s:if test="#ls.code!=0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#ls.info"/></s:if>
        	<s:else>&nbsp;&nbsp;<s:property value="#ls.info"/>...</s:else>
       	</td>
    </tr>
    </s:iterator>
    </s:if>
    <s:else>
    <tr>
        <td align="center">1</td>
        <td align="left">&nbsp;&nbsp;审核结束</td>
    </tr>
    </s:else>
	</tbody>
</table>
</div>
<div class="split-page">
	<input type="hidden" id="pageRows" value="23"/>
	<div id="changePage"></div>
</div>
</body>
</html>