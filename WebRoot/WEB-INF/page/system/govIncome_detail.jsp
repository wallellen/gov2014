<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
</head>
<body style="background:#E0EEFB;">
<h3 class="jiangbu-title">
	${year }&nbsp;年家庭收入及帮扶情况&nbsp;
	<c:if test="${areaName ne null }">[${areaName }]</c:if>
</h3>
<div id="jiangbu-data">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
    <tr>
        <td width="20%">地区编码</td>
        <td width="20%">地区名称</td>
        <td width="20%">户均年总收入(元)</td>
        <td width="10%">填报户数</td>
        <td width="20%">
        	<p>
        	<input type="button" value="返回" onclick="javascript:history.go(-1)" class="button43"/>
        	</p>
        </td>
    </tr>
    </thead>
    <tbody id="splitpage">
    <c:forEach items="${yearList }" var="ls">
    <tr style="display:none">
        <td>${ ls.c0 }</td>
		<td>${ ls.c1 }</td>
		<td>${ ls.c2 }</td>
		<td>${ ls.c3 }</td>
        <td>
        	<c:choose>
        		<c:when test="${fn:length(ls.c0) lt 12 }">
        			<a href="${pageContext.request.contextPath }/system/govIncomeAction_viewYearIncome.do?cbm=${ls.c0 }&year=${year }&title=${title }&sdt=${sdt }&edt=${edt }&areaName=${ls.c1 }">查看</a>	
        		</c:when>
        		<c:otherwise>
        			<a href="${pageContext.request.contextPath }/system/govIncomeAction_viewIncomeHu.do?cbm=${ls.c0 }&year=${year }&title=${title }&sdt=${sdt }&edt=${edt }&areaName=${ls.c1 }">查看</a>	
        		</c:otherwise>
        	</c:choose>
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
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
</body>
</html>