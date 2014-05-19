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
<h3 class="jiangbu-title">小额贷款情况&nbsp;[<s:property value="#session.vts.rbn"/>]</h3>
<div id="jiangbu-data">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
    <tr>
        <td width="10%">年份</td>
        <td width="20%">标题</td>
        <td width="20%">开始日期</td>
        <td width="20%">结束日期</td>
        <td width="30%">
        	操作
        </td>
    </tr>
    </thead>
    <tbody id="splitpage">
    <s:iterator value="#session.vts.list" var="ls" status="sc">
    <tr style="display:none">
        <td><s:property value="#ls.c0"/></td>
        <td><s:property value="#ls.c1"/></td>
        <td><s:property value="#ls.c2"/></td>
        <td><s:property value="#ls.c3"/></td>
        <td>
        	<s:if test="#session.vts.rbm.length()==2">
        		<a href="${pageContext.request.contextPath }/system/govXianCreditAction_viewCreditReport.do?year=<s:property value="#ls.c0"/>&title=<s:property value="#ls.c1"/>&sdt=<s:property value="#ls.c2"/>&edt=<s:property value="#ls.c3"/>&areaName=<s:property value="#session.vts.rbn"/>">年度查看</a>
        		&nbsp;&nbsp;&nbsp;&nbsp;
        		<a href="${pageContext.request.contextPath }/system/govXianCreditAction_viewMonthList.do?year=<s:property value="#ls.c0"/>&title=<s:property value="#ls.c1"/>&sdt=<s:property value="#ls.c2"/>&edt=<s:property value="#ls.c3"/>&areaName=<s:property value="#session.vts.rbn"/>">月度查看</a>
        	</s:if>
        	<s:else>
        		<a href="${pageContext.request.contextPath }/system/govXianCreditAction_viewCreditYear.do?year=<s:property value="#ls.c0"/>&title=<s:property value="#ls.c1"/>&sdt=<s:property value="#ls.c2"/>&edt=<s:property value="#ls.c3"/>&areaName=<s:property value='#session.vts.rbn'/>">查看</a>
        	</s:else>
        </td>
    </tr>
    </s:iterator>
	</tbody>
</table>
</div>
<div class="split-page">
	<input type="hidden" id="pageRows" value="23"/>
	<div id="changePage"></div>
</div>
</body>
</html>