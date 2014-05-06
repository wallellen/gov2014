<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/datePicker/skin/WdatePicker.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/report.js"></script>
	<style type="text/css">
		#overlay-report{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-report{position:absolute;top:30%;left:45%;width:450px;height:280px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;} 
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:5px;cursor:move;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
	</style>
</head>
<body style="background:#E0EEFB;">
<h3 class="jiangbu-title">[<s:property value="reportName"/>]&nbsp;报告列表</h3>
<div id="jiangbu-data">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
    <tr class="tabtr12">
        <td width="10%">代码</td>
        <td width="20%">标题</td>
        <td width="15%">开始日期</td>
        <td width="15%">结束日期</td>
        <td width="10%">编辑</td>
        <td width="10%">显示</td>
        <td width="20%">
        	<p>
        	<input type="button" value="添加" onclick="popReport('add','','','','','','')" class="button43"/>
        	&nbsp;&nbsp;
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
        <td><s:property value="#ls.c3"/></td>
        <td><s:property value="#ls.c4==1?'√':''"/></td>
        <td><s:property value="#ls.c5==1?'√':''"/></td>
        <td>
        	<a href="javascript:popReport('edit','<s:property value="#ls.c0"/>','<s:property value="#ls.c1"/>','<s:property value="#ls.c2"/>','<s:property value="#ls.c3"/>','<s:property value="#ls.c4"/>','<s:property value="#ls.c5"/>')">修改</a>
        	<a href="javascript:deleteReport('<s:property value="#ls.c0"/>')">删除</a>
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

<!-- add year start -->
<div id="overlay-report"></div>
<div id="win-report" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="ptitle"><font color="#fff">添加</font></span></h2>
<form name="reportForm" action="" method="post">
<input type="hidden" id="isde" name="isde"/>
<input type="hidden" name="reportflag" value="<s:property value='reportflag'/>"/>
<input type="hidden" name="reportName" value="<s:property value='reportName'/>"/>
<div class="member-list">
	<table width="450px" cellpadding="0" cellspacing="0">
		<tr>
			<td align="right" width="35%">代码:&nbsp;&nbsp;</td>
			<td align="left" width="65%">
				<input type="text" id="p1" name="pstr" class="report-back-input" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<td align="right" width="45%">标题:&nbsp;&nbsp;</td>
			<td align="left" width="55%">
				<input type="text" id="p2" name="pstr" class="report-back-input" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<td align="right">开始日期:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="p3" name="pstr" onclick="WdatePicker({maxDate:'%y-%M-%d',skin:'whyGreen'})" class="report-back-input Wdate"/>
			</td>
		</tr>
		<tr>
			<td align="right">结束日期:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="p4" name="pstr" onclick="WdatePicker({maxDate:'%y-%M-%d',skin:'whyGreen'})" class="report-back-input Wdate"/>
			</td>
		</tr>
		<tr>
			<td align="right">是否编辑:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="checkbox" id="p5" name="chkp"/>
			</td>
		</tr>
		<tr>
			<td align="right">是否显示:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="checkbox" id="p6" name="chkp"/>
			</td>
		</tr>
	</table>
</div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subReportBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-close" type="button" value="取消" class="button4"/>
</div>
</form>
</div>
<!-- add year end-->
<form name="delReportForm" action="" method="post">
<input type="hidden" id="delrid" name="drid"/>
<input type="hidden" name="reportflag" value="<s:property value='reportflag'/>"/>
<input type="hidden" name="reportName" value="<s:property value='reportName'/>"/>
<input type="hidden" name="rflag" value="<s:property value='rflag'/>"/>
</form>
<script type="text/javascript">
	function deleteReport(r){
		document.getElementById("delrid").value=r;
		if(confirm('您确定要删除吗？')){
			document.delReportForm.action="sysReportAction_deleteReport.do";
			document.delReportForm.submit();
		}
	}	
</script>
</body>
</html>