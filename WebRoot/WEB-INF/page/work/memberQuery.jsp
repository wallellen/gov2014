<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style-b.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
</head>
<body style="background:#E0EEFB;">
<div style="float:left; width:668px; height:668px;">
	<div style="width:640px; height:22px; margin-top:10px;" class="title-stats">人口查询&nbsp;[<s:property value="#session.vts.map.name"/>]</div>
	<form name="memberForm" action="${pageContext.request.contextPath }/system/govFarmerQueryAction_member.do" method="post" onsubmit="return changeCurPage()">
	<fieldset style="border:1px solid #3B9FFF; margin:0; padding:0; width:99%;">
	<legend>查询条件</legend>
	<div style="height:30px;">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td width="10%" align="right">姓名：&nbsp;</td>
				<td width="10%">
					<input type="text" name="memberstr" value="<s:property value="#session.vts.map.marr[0]"/>" maxlength="15" class="inptxt1" onfocus="this.className='input_on1'" onblur="this.className='input_off1'"/>
				</td>
				<td width="10%" align="right">性别：&nbsp;</td>
				<td width="10%">
					
					<s:select name="memberstr" list="#application.vta.GetList('sexex')" listKey="id" listValue="str" value="%{#session.vts.map.marr[1]}"></s:select>
					
				</td>
				<td width="10%" align="right">年龄：&nbsp;</td>
				<td width="8%" align="left">
					<s:select name="memberstr" list="#application.vta.GetList('opt')" listKey="id" listValue="str" value="%{#session.vts.map.marr[2]}"></s:select>
				</td>
				<td width="10%" align="left">
					<input type="text" name="memberstr" value="<s:property value="#session.vts.map.marr[3]"/>" maxlength="15" class="inptxt12" onfocus="this.className='input_on12'" onblur="this.className='input_off12'" onkeyup="checkIntInput(this)"/>
				</td>
				<td width="20%" align="center"><input id="searchImg" type="submit" value="立即查询" class="button4"/></td>
			</tr>
		</table>	
	</div>
	</fieldset>
	<div style="height:5px;"></div>
	<!-- advance -->
	<fieldset style="border:1px solid #3B9FFF; margin:0; padding:0; width:99%;">
	<legend>高级选项</legend>
	<div style="height:60px;">
		<table cellpadding="0" cellspacing="0">
			<tr height="24px;">
				<td width="20%" align="right">在校生：</td>
				<td width="10%" align="left">
					<s:select name="memberstr" cssClass="borwer-sel" list="#application.vta.GetList('yesnoex')" listKey="id" listValue="str" value="%{#session.vts.map.marr[4]}"></s:select>
				</td>
				<td width="20%" align="right">文化程度：</td>
				<td width="10%" align="left">
					<s:select name="memberstr" cssClass="borwer-sel" list="#application.vta.GetList('educationex')" listKey="id" listValue="str" value="%{#session.vts.map.marr[5]}"></s:select>
				</td>
				<td width="20%" align="right">身体状况：</td>
				<td width="10%" align="left">
					<s:select name="memberstr" cssClass="borwer-sel" list="#application.vta.GetList('healthex')" listKey="id" listValue="str" value="%{#session.vts.map.marr[6]}"></s:select>
				</td>
				<td width="10%"></td>
			</tr>
			<tr height="24px;">
				<td align="right">劳动力状况：</td>
				<td align="left">
					<s:select name="memberstr" cssClass="borwer-sel" list="#application.vta.GetList('laborex')" listKey="id" listValue="str" value="%{#session.vts.map.marr[7]}"></s:select>
				</td>
				<td align="right">打工状况：</td>
				<td align="left">
					<s:select name="memberstr" cssClass="borwer-sel" list="#application.vta.GetList('workex')" listKey="id" listValue="str" value="%{#session.vts.map.marr[8]}"></s:select>
				</td>
				<td align="right">低保人口：</td>
				<td align="left">
					<s:select name="memberstr" cssClass="borwer-sel" list="#application.vta.GetList('yesnoex')" listKey="id" listValue="str" value="%{#session.vts.map.marr[9]}"></s:select>
				</td>
				<td width="10%"></td>
			</tr>
		</table>	
	</div>
	</fieldset>
	</form>
	<s:if test="#session.vts.list!=null && #session.vts.list.size()>0">
	<div style="height:18px; line-height:18px; padding-top:2px;">
		<span>符合查询条件人口数：<s:property value="#session.vts.map.membernt"/>人</span>
		<span style="float:right; width:60px;">
			<input type="button" value="导出" onclick="location.href='${pageContext.request.contextPath }/system/govFarmerQueryAction_exportMemberInfo.do?memberstr=<s:property value="memberstr"/>'" class="button43"/>
		</span>
	</div>
	</s:if>
	<s:if test="#session.vts.list!=null && #session.vts.list.size()>0">
	<div class="table-c" style="width:666px; height:464px; border:0px solid red; margin-top:4px;">
		<table class="data_list" width="100%" bordercolor="gray" border="0" cellpadding="0" cellspacing="0">
			<thead>
			<tr class="tabtr2">
				<td width="6%">姓名</td>
				<td width="4%">性别</td>
				<td width="4%">年龄</td>
				<td width="4%">在校生</td>
				<td width="10%">文化程度</td>
				<td width="10%">身体状况</td>
				<td width="10%">劳动力状况</td>
				<td width="10%">打工状况</td>
				<td width="4%">低保人口</td>
				<td width="6%">领取金额(元)</td>
				<td width="4%">操作</td>
			</tr>
			</thead>
			<tbody id="splitpage">
				<s:iterator value="#session.vts.list" var="ls">
				<tr align="center" style="height:20px; display:none;">
					<td align="left" title="农户编码: <s:property value="#ls.c0"/>&#13;地区名称: <s:property value="#ls.c1"/>">&nbsp;<s:property value="#ls.c2"/></td>
					<td><s:property value="#ls.c3.substring(2,3)"/></td>
					<td align="right"><s:property value="#ls.c4"/>&nbsp;</td>
					<td><s:property value="#ls.c5.substring(2,3)"/></td>
					<td align="left">&nbsp;<s:property value="#ls.c6"/></td>
					<td align="left">&nbsp;<s:property value="#ls.c7"/></td>
					<td align="left">&nbsp;<s:property value="#ls.c9"/></td>
					<td align="left">&nbsp;<s:property value="#ls.c10"/></td>
					<td><s:property value="#ls.c11.substring(2,3)"/></td>
					<td align="right"><s:property value="#ls.c12"/>&nbsp;</td>
					<td>
						<a href="${pageContext.request.contextPath }/system/govBrowerAction_viewReportFamilyWithQuery.do?viewBM=<s:property value="#ls.c0"/>">查看</a>
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
<script type="text/javascript">
	//立即查询之后重置当前页
	function changeCurPage(){
		parent.document.getElementById("globalCurPage").value=1;
	}
</script>
</html>