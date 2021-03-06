<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<h3 class="jiangbu-title">小额贷款情况&nbsp;[${sessionScope.vts.rbn }]</h3>
<div id="jiangbu-data">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
    <tr>
        <td width="10%">月份</td>
        <td width="20%">标题</td>
        <td width="20%">开始日期</td>
        <td width="20%">结束日期</td>
        <td width="30%">
        	<p><input type="button" value="返回" onclick="history.go(-1)" class="button43"/></p>
        </td>
    </tr>
    </thead>
    <tbody id="splitpage">
    <c:forEach items="${xiaoeList }" var="ls">
    <tr style="display:none">
        <td>${ls.c0 }</td>
		<td>${ls.c1 }</td>
		<td>${ls.c2 }</td>
		<td>${ls.c3 }</td>
        <td>
        	<a href="${pageContext.request.contextPath }/system/govXianCreditAction_viewCreditMonthReport.do?year=${year }&month=${ls.c0 }&sdt=${sdt }&edt=${edt }&areaName=${areaName }">查看</a>
        </td>
    </tr>
    </c:forEach>
	</tbody>
</table>
</div>
<div class="split-page">
	<input type="hidden" id="pageRows" value="23"/>
	<div id="changePage"></div>
</div>
</body>
</html>