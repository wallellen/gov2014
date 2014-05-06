<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/bangfu.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
	<style type="text/css">
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:5px;cursor:move;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
		#overlay-bangfu{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-bangfu{position:absolute;top:30%;left:45%;width:500px;height:490px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-bangfu .back-input{height:20px; width:140px;}
		#overlay-bangfus{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-bangfus{position:absolute;top:30%;left:45%;width:500px;height:190px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-bangfus .back-input{height:20px; width:140px;}
		.jiangbu-title1 .j_return{width:60px;}
	</style>
</head>
<body style="background:#E0EEFB;">
<h3 class="jiangbu-title">
	<s:if test="navbm.length()==4">
		请选择区县
	</s:if>
	<s:if test="navbm.length()==6">
		请选择乡镇
	</s:if>
	<s:if test="navbm.length()==9">
		请选择村或居委会
	</s:if>
</h3>
<p class="jiangbu-title1"><span class="j_return"><input type="button" value="返回" onclick="javascript:history.go(-1)" class="button43"/></span><span><s:property value="title"/>&nbsp;(<s:property value="sdt"/>~<s:property value="edt"/>)</span></p>
<div id="jiangbu-data1">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
    <tr>
        <td width="30%">地区编码</td>
        <td width="30%">地区名称</td>
        <td width="30%">操作</td>
    </tr>
    </thead>
    <tbody id="splitpage">
    <s:iterator value="#session.vts.list" var="ls" status="sc">
    <tr style="display:none">
        <td><s:property value="#ls.c0"/></td>
        <td><s:property value="#ls.c1"/></td>
        <td>
        	<s:if test="#ls.c0.length()==12">
        	<a href="${pageContext.request.contextPath }/system/govJiangBuAction_writeReport.do?crid=<s:property value="crid"/>&title=<s:property value="title"/>&sdt=<s:property value="sdt"/>&edt=<s:property value="edt"/>&navbm=<s:property value='#ls.c0'/>">进入</a>
        	</s:if>
        	<s:else>
        	<a href="${pageContext.request.contextPath }/system/govJiangBuAction_gotoCunLevel.do?crid=<s:property value="crid"/>&navbm=<s:property value="#ls.c0"/>&title=<s:property value="title"/>&sdt=<s:property value="sdt"/>&edt=<s:property value="edt"/>">进入</a>
        	</s:else>
        </td>
    </tr>
    </s:iterator>
</table>
</div>
<div class="split-page">
	<input type="hidden" id="pageRows" value="23"/>
	<div id="changePage"></div>
</div>
</body>
</html>