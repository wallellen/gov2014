<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style-b.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/datePicker/skin/WdatePicker.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
	<script type="text/javascript">
		//保存查询参数
		function loadParam(){
			var qparam = document.getElementById("qparam").value;
			var qstr = document.getElementsByName("qstr");
		}
		function changeCurPage(){
			parent.document.getElementById("globalCurPage").value=1;
		}
	</script>
</head>
<body onload="loadParam()" style="background:#E0EEFB;">
<div style="float:left; width:668px; height:668px;">
	<div style="width:640px; height:22px; margin-top:10px;" class="title-stats">农户查询&nbsp;[<s:property value="#session.vts.map.name"/>]</div>
	<form name="farmerForm" action="${pageContext.request.contextPath }/system/govFarmerQueryAction_home.do" method="post" onsubmit="return changeCurPage()">
	<input type="hidden" id="qparam" name="qparam" value="<s:property value="qstr"/>"/>
	<fieldset style="border:1px solid #3B9FFF; margin:0; padding:0; width:99%;">
	<legend>查询条件</legend>
	<div style="height:30px;">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td width="10%" align="right">农户编码:&nbsp;</td>
				<td width="10%"><input type="text" name="qstr" value="<s:property value="#session.vts.map.qarr[0]"/>" maxlength="15" onkeyup="value=value.replace(/[^\d]/g,'')" class="inptxt1" onfocus="this.className='input_on1'" onblur="this.className='input_off1'"/></td>
				<td width="10%" align="right">户主姓名:&nbsp;</td>
				<td width="10%"><input type="text" name="qstr" value="<s:property value="#session.vts.map.qarr[1]"/>" maxlength="10" class="inptxt1" onfocus="this.className='input_on1'" onblur="this.className='input_off1'"/></td>
				<td width="10%" align="center"><input id="searchImg" type="submit" value="立即查询" class="button4"/></td>
			</tr>
		</table>	
	</div>
	</fieldset>
	<div style="height:5px;"></div>
	<!-- advance -->
	<fieldset style="border:1px solid #3B9FFF; margin:0; padding:0; width:99%;">
	<legend>高级选项</legend>
	<div style="height:80px;">
		<table cellpadding="0" cellspacing="0">
			<tr height="24px;">
				<td width="12%" align="right">家庭人口：</td>
				<td width="10%" align="left">
					<s:select name="qstr" list="#application.vta.GetList('opt')" listKey="id" listValue="str" value="%{#session.vts.map.qarr[2]}"></s:select>
				</td>
				<td width="16%" align="left"><input type="text" name="qstr" maxlength="5" value="<s:property value="#session.vts.map.qarr[3]"/>" onkeyup="value=value.replace(/[^\d]/g,'')" class="inptxt2" onfocus="this.className='input_on2'" onblur="this.className='input_off2'"/></td>
				<td width="12%" align="right">劳动力：</td>
				<td width="10%" align="left">
					<s:select name="qstr" list="#application.vta.GetList('opt')" listKey="id" listValue="str" value="%{#session.vts.map.qarr[4]}"></s:select>
				</td>
				<td width="16%" align="left"><input type="text" name="qstr" class="inptxt2" onfocus="this.className='input_on2'" onblur="this.className='input_off2'" maxlength="5" value="<s:property value="#session.vts.map.qarr[5]"/>" onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
				<td width="10%" align="right">家庭属性：</td>
				<td width="10%" align="left">
					<s:select name="qstr" cssClass="borwer-sel" list="#application.vta.GetList('familyex')" listKey="id" listValue="str" value="%{#session.vts.map.qarr[6]}"></s:select>
				</td>
			</tr>
			<tr height="24px;">
				<td align="right">住房面积：</td>
				<td align="left">
					<s:select name="qstr" list="#application.vta.GetList('opt')" listKey="id" listValue="str" value="%{#session.vts.map.qarr[7]}"></s:select>
				</td>
				<td align="left"><input type="text" name="qstr" class="inptxt2" onfocus="this.className='input_on2'" onblur="this.className='input_off2'" maxlength="5" value="<s:property value="#session.vts.map.qarr[8]"/>" onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
				<td align="right">耕地：</td>
				<td align="left">
					<s:select name="qstr" list="#application.vta.GetList('opt')" listKey="id" listValue="str" value="%{#session.vts.map.qarr[9]}"></s:select>
				</td>
				<td align="left"><input type="text" name="qstr" class="inptxt2" onfocus="this.className='input_on2'" onblur="this.className='input_off2'" maxlength="5" value="<s:property value="#session.vts.map.qarr[10]"/>" onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
				<td align="right">贫困原因：</td>
				<td align="left">
					<s:select name="qstr" cssClass="borwer-sel" list="#application.vta.GetList('dcauseex')" listKey="id" listValue="str" value="%{#session.vts.map.qarr[11]}"></s:select>
				</td>
			</tr>
			<tr height="24px;">
				<td align="right">家庭总收入：</td>
				<td align="left">
					<s:select name="qstr" list="#application.vta.GetList('opt')" listKey="id" listValue="str" value="%{#session.vts.map.qarr[12]}"></s:select>
				</td>
				<td align="left"><input type="text" name="qstr" class="inptxt2" onfocus="this.className='input_on2'" onblur="this.className='input_off2'" maxlength="5" value="<s:property value="#session.vts.map.qarr[13]"/>" onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
				<td align="right">年人均收入：</td>
				<td align="left">
					<s:select name="qstr" list="#application.vta.GetList('opt')" listKey="id" listValue="str" value="%{#session.vts.map.qarr[14]}"></s:select>
				</td>
				<td align="left"><input type="text" name="qstr" class="inptxt2" onfocus="this.className='input_on2'" onblur="this.className='input_off2'" maxlength="5" value="<s:property value="#session.vts.map.qarr[15]"/>" onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
				<td align="right">年份：</td>
				<td align="left">
					<input type="text" name="qstr" value="<s:property value="#session.vts.map.qarr[16]"/>" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy'})" class="Wdate" style="width:80px; height:18px;" maxlength="4"/>
				</td>
			</tr>
		</table>	
	</div>
	</fieldset>
	</form>
	<s:if test="#session.vts.list5!=null && #session.vts.list5.size()>0">
	<div style="height:16px; padding-top:2px; border:0px solid red;">符合查询条件农户数：<s:property value="#session.vts.map.farmernt"/>户</div>
	</s:if>
	<s:if test="#session.vts.list5!=null && #session.vts.list5.size()>0">
	<div class="table-c" style="width:666px; height:448px; border:0px solid red; margin-top:4px;">
		<table class="data_list" width="100%" bordercolor="gray" border="0" cellpadding="0" cellspacing="0">
			<thead>
			<tr class="tabtr1">
				<td width="20%">农户编码</td>
				<td width="49%">省、市、县、乡、村</td>
				<td width="15%">户主姓名</td>
				<td width="16%" class="tabtd1">操作</td>
			</tr>
			</thead>
			<tbody id="splitpage">
				<s:iterator value="#session.vts.list5" var="ls5">
				<tr align="center" style="height:20px; display:none;">
					<td align="left">&nbsp;<s:property value="#ls5.c0"/></td>
					<td align="left" title="<s:property value='#ls5.c1'/>">&nbsp;<s:property value="#ls5.c1.length()>26?#ls5.c1.substring(0,25)+'...':#ls5.c1"/></td>
					<td align="left" title="<s:property value='#ls5.c2'/>">&nbsp;<s:property value="#ls5.c2.length()>7?#ls5.c2.substring(0,6)+'...':#ls5.c2"/></td>
					<td class="tabtd1">
						<s:if test="#session.vts.isedit==1">
						<a href="${pageContext.request.contextPath }/system/govBrowerAction_detail.do?viewBM=<s:property value="#ls5.c0"/>&rtf=farmer">编辑</a>
						</s:if>
						<a href="${pageContext.request.contextPath }/system/govBrowerAction_viewReportFamilyWithQuery.do?viewBM=<s:property value="#ls5.c0"/>">查看</a>
						<a id="printBt" href="${pageContext.request.contextPath }/system/govBrowerAction_printFamily.do?viewBM=<s:property value="#ls5.c0"/>" target="printFrame">打印</a>
					</td>
				</tr>
				</s:iterator>
			</tbody>
		</table>
	</div>
	<!-- js分页div -->
	<div class="split-page">
		<!-- 每页行数 -->
		<input type="hidden" id="pageRows" value="21"/>
		<div id="changePage"></div>
	</div>
	</s:if>
</div>
<div id="rightCon">
<%@ include file="/WEB-INF/page/work/overView.jsp"%> 
</div>
</body>
</html>