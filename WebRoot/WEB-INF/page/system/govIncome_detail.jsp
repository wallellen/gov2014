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
<h3 class="jiangbu-title">
	<s:property value="year"/>&nbsp;年家庭收入及帮扶情况&nbsp;
	<s:if test="areaName!=null">[<s:property value="areaName"/>]</s:if>
</h3>
<div id="jiangbu-data">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
    <tr>
        <td width="20%">地区编码</td>
        <td width="20%">地区名称</td>
        <td width="20%">户均年总收入(元)</td>
        <td width="20%">
        	<p>
        	<input type="button" value="返回" onclick="javascript:history.go(-1)" class="button43"/>
        	</p>
        </td>
    </tr>
    </thead>
    <tbody id="splitpage">
    <s:iterator value="#session.vts.list" var="ls" status="sc">
    <tr style="display:none">
        <td><s:property value="#ls.c0"/></td>
        <td><s:property value="#ls.c1"/></td>
        <td><s:property value="#ls.c2"/></td>
        <td>
        	<s:if test="#ls.c0.length()<12">
        	<a href="${pageContext.request.contextPath }/system/govIncomeAction_viewYearIncome.do?cbm=<s:property value="#ls.c0"/>&year=<s:property value="year"/>&title=<s:property value="title"/>&sdt=<s:property value="sdt"/>&edt=<s:property value="edt"/>&areaName=<s:property value="#ls.c1"/>">查看</a>
        	</s:if>
        	<s:else>
        	<a href="${pageContext.request.contextPath }/system/govIncomeAction_viewIncomeHu.do?cbm=<s:property value="#ls.c0"/>&year=<s:property value="year"/>&title=<s:property value="title"/>&sdt=<s:property value="sdt"/>&edt=<s:property value="edt"/>&areaName=<s:property value="#ls.c1"/>">查看</a>
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