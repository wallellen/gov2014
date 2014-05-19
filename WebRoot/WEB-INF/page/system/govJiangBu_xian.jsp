<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jiangbu.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
	
	<style type="text/css">
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:5px;cursor:move;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
		#overlay-jiangbu{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-jiangbu{position:absolute;top:30%;left:45%;width:500px;height:460px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-jiangbu .back-input{height:20px; width:140px;}
	</style>
</head>
<body style="background:#E0EEFB;">
<h3 class="jiangbu-title">脱贫奔小康财政奖补到户项目实施情况&nbsp;[<s:property value="xianName"/>]</h3>
<p class="jiangbu-title1"><span><s:property value="title"/>&nbsp;(<s:property value="sdt"/>~<s:property value="edt"/>)</span></p>
<div id="jiangbu-data1">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
   	<tr>
		<td rowspan="3" width="6%">建档立卡号</td>
        <td rowspan="3" width="10%">市、县名称</td>
		<td colspan="7">资金到户方式农户统计数</td>
		<td colspan="4">项目资金到户(元)</td>
        <td rowspan="3" width="4%">备注</td>
        <td rowspan="3" width="6%" align="center">
        	<p>
        	<input type="button" value="导出" onclick="location.href='${pageContext.request.contextPath }/system/govJiangBuAction_exportJiangbu.do?crid=<s:property value="crid"/>&navbm=<s:property value="navbm"/>&title=<s:property value="title"/>'" class="button43"/>
        	</p>
        	<p>&nbsp;</p>
        	<p>
        	<input type="button" value="返回" onclick="javascript:history.go(-1)" class="button43"/>
        	</p>
        </td>
	</tr>
	<tr>
       	<td rowspan="2" width="4%">资金直接扶持农户发展产业</td>
		<td rowspan="2" width="4%">资金量化入股农民专业合作社分红</td>
		<td colspan="2">购岗补贴</td>
       	<td rowspan="2" width="4%">股份量化入股小贷等投资公司</td>
       	<td rowspan="2" width="6%">资金股份量化到户，购置商业门面房等资产分红</td>
       	<td rowspan="2" width="4%">其他</td>
        <td rowspan="2" width="6%">合计</td>
        <td colspan="3">其中</td>
	</tr>
	<tr>
        <td width="4%">购买企业岗位</td>
        <td width="4%">购买公益性岗位</td>
        <td width="6%">省级财政奖补资金</td>
        <td width="6%">地方财政</td>
        <td width="6%">挂钩帮扶单位</td>
	</tr>
    </thead>
    <tbody id="splitpage">
    <s:iterator value="#session.vts.list" var="ls" status="sc">
    <tr style="display:none">
        <td><s:property value="#ls.c0"/></td>
        <td><s:property value="#ls.c1"/></td>
        <td><s:property value="#ls.c2"/></td>
        <td><s:property value="#ls.c3"/></td>
        <td><s:property value="#ls.c4"/></td>
        <td><s:property value="#ls.c5"/></td>
        <td><s:property value="#ls.c6"/></td>
        <td><s:property value="#ls.c7"/></td>
        <td><s:property value="#ls.c8"/></td>
        <td><s:property value="#ls.c9"/></td>
        <td><s:property value="#ls.c10"/></td>
        <td><s:property value="#ls.c11"/></td>
        <td><s:property value="#ls.c12"/></td>
        <td><s:property value="#ls.c13"/></td>
        <td>
        	<s:if test="#ls.c0.length()<10">
        	<a href="${pageContext.request.contextPath }/system/govJiangBuAction_viewXianDetail.do?cbm=<s:property value='#ls.c0'/>&crid=<s:property value='crid'/>&title=<s:property value='title'/>&sdt=<s:property value='sdt'/>&edt=<s:property value='edt'/>&xianName=<s:property value='#ls.c1'/>">查看详细</a>
        	</s:if>
        	<s:else>
        	<a href="${pageContext.request.contextPath }/system/govJiangBuAction_writeReport.do?navbm=<s:property value='#ls.c0'/>&crid=<s:property value='crid'/>&title=<s:property value='title'/>&sdt=<s:property value='sdt'/>&edt=<s:property value='edt'/>&xianName=<s:property value='#ls.c1'/>">查看详细</a>
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

<!-- add jiangbu start -->
<div id="overlay-jiangbu"></div>
<div id="win-jiangbu" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="jtitle"><font color="#fff">修改财政奖补到户情况</font></span></h2>
<form name="jBForm" action="" method="post">
<div class="member-list">
	<table width="490px" cellpadding="0" cellspacing="0">
		<tr>
			<td width="40%" align="right">
				<s:checkbox id="tt1" name="jbchk" value="1"></s:checkbox>&nbsp;
			</td>
			<td width="60%" align="left">资金直接扶持农户发展产业</td>
		</tr>
		<tr>
			<td align="right">
				<s:checkbox id="tt2" name="jbchk" value="1"></s:checkbox>&nbsp;
			</td>
			<td align="left">资金量化入股农民专业合作社分红</td>
		</tr>
		<tr>
			<td align="right">
				<s:checkbox id="tt3" name="jbchk"></s:checkbox>&nbsp;
			</td>
			<td align="left">购买企业岗位</td>
		</tr>
		<tr>
			<td align="right">
				<s:checkbox id="tt4" name="jbchk"></s:checkbox>&nbsp;
			</td>
			<td align="left">购买公益性岗位</td>
		</tr>
		<tr>
			<td align="right">
				<s:checkbox id="tt5" name="jbchk"></s:checkbox>&nbsp;
			</td>
			<td align="left">股份量化入股小贷等投资公司</td>
		</tr>
		<tr>
			<td align="right">
				<s:checkbox id="tt6" name="jbchk"></s:checkbox>&nbsp;
			</td>
			<td align="left">资金股份量化到户，购置商业门面房等资产分红</td>
		</tr>
		<tr>
			<td align="right">
				<s:checkbox id="tt7" name="jbchk"></s:checkbox>&nbsp;
			</td>
			<td align="left">其他</td>
		</tr>
		<tr>
			<td align="right">省级财政奖补资金(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vv1" name="jbtxt" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">地方财政(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vv2" name="jbtxt" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">挂钩帮扶单位(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vv3" name="jbtxt" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">
				<s:checkbox id="tt8" name="jbchk"></s:checkbox>&nbsp;
			</td>
			<td align="left">是否属于重点片区奖补项目</td>
		</tr>
	</table>
</div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subJiangBuBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-close" type="button" value="取消" class="button4"/>
</div>
<input type="hidden" id="rid1" name="rid" value=""/>
<input type="hidden" id="jbstr" name="jbstr" value=""/>
</form>
</div>
</body>
</html>