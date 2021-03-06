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
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/keyproject.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
	<style type="text/css">
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:5px;cursor:move;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
		#overlay-keyproject{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-keyproject{position:absolute;top:30%;left:45%;width:500px;height:460px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-keyproject .back-input{height:20px; width:140px;}
	</style>
</head>
<body style="background:#E0EEFB;">
<h3 class="jiangbu-title">关键工程项目实施进度和扶贫资金使用情况&nbsp;[<s:property value="areaName"/>]</h3>
<p class="jiangbu-title1"><span><s:property value="title"/>&nbsp;(<s:property value="sdt"/>~<s:property value="edt"/>)</span></p>
<div id="jiangbu-data1">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
   	<tr>
     	<td rowspan="2" width="4%">序号</td>
        <td rowspan="2" width="16%">县名</td>
        <td rowspan="2" width="4%">项目数</td>
    	<td colspan="4">资金总量(万元)</td>
        <td colspan="2">资金拨付到项目情况(万元)</td>
        <td colspan="3">项目实施进度</td>
        <td rowspan="2" width="5%">
        	<p>
			<input type="button" value="导出" onclick="location.href='${pageContext.request.contextPath }/system/govKeyProjectAction_exportKeyProject.do?crid=<s:property value="crid"/>&navbm=<s:property value="navbm"/>&pianId=<s:property value="pianId"/>&title=<s:property value="title"/>'" class="button43"/>
        	</p>
        	<p>&nbsp;</p>
        	<p>
        	<input type="button" value="返回" onclick="javascript:history.go(-1)" class="button43"/>
        	</p>
        </td>
    </tr>
    <tr>
    	<td width="4%">合计</td>
        <td width="4%">省级财政安排</td>
        <td width="4%">市县财政安排</td>
        <td width="4%">其他资金</td>
        <td width="4%">合计</td>
        <td width="8%">其中：已拔付省级财政补助资金</td>
        <td width="4%">项目实施年限</td>
        <td width="4%">全年计划进度(%)</td>
        <td width="8%">截至报告日项目实际进度(%)</td>
    </tr>
    </thead>
    <tbody id="splitpage">
    <c:forEach items="${keyList}" var="ls" varStatus="status">
    <tr style="display:none">
		<td>${ls.bm }</td>
        <td>${ls.oname }</td>
        <td>${ls.rn }</td>
        <td>${ls.prt }</td>
        <td>${ls.spr }</td>
        <td>${ls.sspr }</td>
        <td>${ls.opr }</td>
        <td>${ls.pyt }</td>
        <td>${ls.spy }</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>
        	<a href="${pageContext.request.contextPath }/system/govKeyProjectAction_writeReportZhen.do?navbm=${ls.bm }&pianId=${pianId }&crid=${crid }&title=${title }&sdt=${sdt }&edt=${edt }&areaName=${ls.oname }">查看详细</a>
        </td>
	</tr>
	</c:forEach>
	</tbody>
</table>
</div>
<div class="split-page">
	<input type="hidden" id="pageRows" value="21"/>
	<div id="changePage"></div>
</div>
</body>
</html>