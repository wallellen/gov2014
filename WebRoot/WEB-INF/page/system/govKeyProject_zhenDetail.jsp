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
		
		.key-errtip{
			width:290px; 
			height:18px;
			line-height:18px;
			color:#F00;
		}
	</style>
	<script type="text/javascript">
		function deleteKeyProject(c0,c1){
			document.getElementById("bmIds").value=c1;
			document.getElementById("pidIds").value=c0;
			if(confirm('您确定要删除吗？')){
				document.Form1.action="govKeyProjectAction_deleteKeyProject.do";
				document.Form1.submit();
			}
		}
	</script>
</head>
<body style="background:#E0EEFB;">
<form name="Form1" id="Form1">
	<input type="hidden" name="bm" id="bmIds"/>
	<input type="hidden" name="pianId" value="<s:property value='pianId'/>"/>
	<input type="hidden" name="pid" id="pidIds"/>
	<input type="hidden" name="crid" value="<s:property value='crid'/>"/>
	<input type="hidden" name="navbm" value="<s:property value='navbm'/>"/>
	<input type="hidden" name="title" value="<s:property value='title'/>"/>
	<input type="hidden" name="sdt" value="<s:property value='sdt'/>"/>
	<input type="hidden" name="edt" value="<s:property value='edt'/>"/>
	<input type="hidden" name="rflag" value="<s:property value='rflag'/>"/>
	<input type="hidden" name="areaName" value="<s:property value='areaName'/>"/>
</form>
<h3 class="jiangbu-title">关键工程项目实施进度和扶贫资金使用情况&nbsp;[<s:property value="areaName"/>]</h3>
<p class="jiangbu-title1"><span><s:property value="title"/>&nbsp;(<s:property value="sdt"/>~<s:property value="edt"/>)</span></p>
<div id="jiangbu-data1">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
   	<tr>
     	<td rowspan="2" width="4%">序号</td>
        <td rowspan="2" width="15%">项目名称</td>
        <td rowspan="2" width="10%">项目实施所在乡(镇)</td>
    	<td colspan="4">资金总量(万元)</td>
        <td colspan="2">资金拨付到项目情况(万元)</td>
        <td colspan="3">项目实施进度</td>
        <td rowspan="2" width="6%">
        	<p>
        	<c:if test="${fn:length(sessionScope.vts.rbm) eq 6 }">
        	<input type="button" value="添加" onclick="popKeyProjectEdit('add','${sessionScope.vts.rbm }','','','','','','','','','','','')" class="button43"/>
        	</c:if>
        	</p>
        	<p style="margin-top:8px; margin-bottom:8px;">
        		<input type="button" value="导出" onclick="location.href='${pageContext.request.contextPath }/system/govKeyProjectAction_exportKeyProjectDetail.do?crid=<s:property value="crid"/>&navbm=<s:property value="navbm"/>&pianId=<s:property value="pianId"/>&title=<s:property value="title"/>'" class="button43"/>
        	</p>
        	<p>
        	<input type="button" value="返回" onclick="javascript:history.go(-<s:property value='rflag'/>)" class="button43"/>
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
    <c:forEach items="${keyList }" var="ls" varStatus="status">
    <tr style="display:none">
		<td>${ls.pid }</td>
        <td align="left" title="${ls.itemname }">
        	<c:choose>
				<c:when test="${fn:length(ls.itemname)>13}">${fn:substring(ls.itemname,0,12) }..</c:when>
				<c:otherwise>${ls.itemname }</c:otherwise>
			</c:choose>
        </td>
        <td align="left" title="${ls.oname }">
			<c:choose>
				<c:when test="${fn:length(ls.oname)>11}">${fn:substring(ls.oname,0,10) }..</c:when>
				<c:otherwise>${ls.oname }</c:otherwise>
			</c:choose>
		</td>
        <td>${ls.prt }</td>
        <td>${ls.spr }</td>
        <td>${ls.sspr }</td>
        <td>${ls.opr }</td>
        <td>${ls.pyt }</td>
        <td>${ls.spy }</td>
        <td>${ls.yt }</td>
        <td>${ls.yp }</td>
        <td>${ls.np }</td>
        <td>
        	<c:if test="${fn:length(sessionScope.vts.rbm ) eq 6 }">
        	<a href="javascript:popKeyProjectEdit('edit','${ls.bm }','${ls.pid }','${ls.itemname }','${ls.oname }','${ls.spr }','${ls.sspr }','${ls.opr }','${ls.pyt }','${ls.spy }','${ls.yt }','${ls.yp }','${ls.np }')">修改</a>
        	<a href="javascript:deleteKeyProject('${ls.pid }','${ls.bm }')">删除</a>
        	</c:if>
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
<!-- add key project start -->
<div id="overlay-keyproject"></div>
<div id="win-keyproject" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="ktitle"><font color="#fff">修改关键项目情况</font></span></h2>
<form name="keyProjectForm" action="" method="post">
<input type="hidden" id="kxxm" name="kptxt" value=""/>
<input type="hidden" id="kpid" name="kptxt" value=""/>
<div class="member-list">
	<table width="500px" cellpadding="0" cellspacing="0">
		<tr height="10px"></tr>
		<tr>
			<td width="50%" align="right">项目名称:&nbsp;&nbsp;</td>
			<td width="35%" align="left">
				<input type="text" id="kp1" name="kptxt" class="back-input" maxlength="20" onblur="checkKeyName(this)"/>
			</td>
			<td width="15%" align="left"></td>
		</tr>
		<tr>
			<td align="right">项目实施所在乡(镇):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="kp2" name="kptxt" class="back-input" maxlength="20"/>
			</td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">省级财政安排(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="kp3" name="kptxt" class="back-input" maxlength="10" onblur="checkMoney(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">市县财政安排(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="kp4" name="kptxt" class="back-input" maxlength="10" onblur="checkMoney(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">其他资金(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="kp5" name="kptxt" class="back-input" maxlength="10" onblur="checkMoney(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">资金拨付合计(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="kp6" name="kptxt" class="back-input" maxlength="10" onblur="checkMoney(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">其中,已拨付省级财政补助资金(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="kp7" name="kptxt" class="back-input" maxlength="10" onblur="checkMoney(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">项目实施年限:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="kp8" name="kptxt" class="back-input" maxlength="6" onblur="checkKprj(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">全年计划进度(%):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="kp9" name="kptxt" class="back-input" maxlength="3" onblur="checkPercent(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">截至报告日项目实施进度(%):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="kp10" name="kptxt" class="back-input" maxlength="3" onblur="checkPercent(this)"/>
			</td>
			<td></td>
		</tr>
		
	</table>
</div>
<div id="keyErrTip" class="key-errtip"></div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subKeyProjectBt()"/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-close" type="button" value="取消" class="button4"/>
</div>
<input type="hidden" name="navbm" value="<s:property value='navbm'/>"/>
<input type="hidden" name="pianId" value="<s:property value='pianId'/>"/>
<input type="hidden" name="title" value="<s:property value='title'/>"/>
<input type="hidden" name="sdt" value="<s:property value='sdt'/>"/>
<input type="hidden" name="edt" value="<s:property value='edt'/>"/>
<input type="hidden" name="crid" value="<s:property value='crid'/>"/>
<input type="hidden" name="rflag" value="<s:property value='rflag'/>"/>
<input type="hidden" name="areaName" value="<s:property value='areaName'/>"/>
</form>
</div>
</body>
</html>