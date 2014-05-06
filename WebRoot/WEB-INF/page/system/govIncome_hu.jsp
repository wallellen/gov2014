<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/income.js"></script>
	<style type="text/css">
		#overlay-year{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-year{position:absolute;top:30%;left:45%;width:500px;height:460px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;} 
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:5px;cursor:move;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
	</style>
</head>
<body style="background:#E0EEFB;">
<h3 class="jiangbu-title"><s:property value="year"/>&nbsp;年收入及帮扶情况&nbsp;<s:if test="areaName!=null">[<s:property value="areaName"/>]</s:if></h3>
<div id="jiangbu-data">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
   	<tr>
   		<td rowspan="3" width="12%">农户编码</td>
        <td rowspan="3" width="8%">户主姓名</td>
        <td colspan="8">家庭年收入情况</td>
        <td colspan="5">帮扶情况</td>
        <td rowspan="3" width="10%">
        	<p>
        	<input type="button" value="返回" onclick="javascript:history.go(-<s:property value='rflag'/>)" class="button43"/>
        	</p>
        </td>
    </tr>
    <tr>
    	<td rowspan="2" width="5%">1.全年家庭纯收入</td>
       	<td colspan="6">其中</td>
		<td rowspan="2" width="5%">2.家庭人均纯收入</td>
       	<td rowspan="2" width="5%">无偿帮扶资金</td>
       	<td rowspan="2" width="5%">得到股份</td>
       	<td rowspan="2" width="5%">小额贷款和互助资金</td>
       	<td rowspan="2" width="5%">劳动力转移培训</td>
       	<td rowspan="2" width="5%">劳动力转移就业人数</td>
    </tr>
    <tr>
        <td width="5%">种植业纯收入</td>
        <td width="5%">养殖业纯收入</td>
        <td width="5%">务工收入</td>
        <td width="5%">低保、五保、养老收入</td>
        <td width="5%">补贴性收入 </td>
        <td width="5%">其他收入</td>
    </tr>
    </thead>
    <tbody id="splitpage">
    <s:iterator value="#session.vts.list" var="ls" status="sc">
    <tr style="display:none">
        <td><s:property value="#ls.c0"/></td>
        <td title="<s:property value='#ls.c1'/>"><s:property value="#ls.c1.length()>5?#ls.c1.substring(0,4)+'...':#ls.c1"/></td>
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
        <td><s:property value="#ls.c14"/></td>
        <td>
        	<s:if test="#session.vts.isedit==1 && #session.vts.rbm.length()>2">
			<s:if test="#ls.c2.length()>0">        	
			<a href="javascript:popIncomeYear('edit','<s:property value="#ls.c0"/>','<s:property value="#ls.c3"/>','<s:property value="#ls.c4"/>','<s:property value="#ls.c5"/>','<s:property value="#ls.c6"/>','<s:property value="#ls.c7"/>','<s:property value="#ls.c8"/>','<s:property value="#ls.c10"/>','<s:property value="#ls.c11"/>','<s:property value="#ls.c12"/>','<s:property value="#ls.c13"/>','<s:property value="#ls.c14"/>')">修改</a>
        	</s:if>
        	<s:else>
        	<a href="javascript:popIncomeYear('add','<s:property value="#ls.c0"/>','','','','','','','','','','')">添加</a>
        	</s:else>
        	</s:if>
        	<a href="${pageContext.request.contextPath }/system/govBrowerAction_viewReportFamily.do?viewBM=<s:property value='#ls.c0'/>">查看</a>
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
<div id="overlay-year"></div>
<div id="win-year" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="ytitle"><font color="#fff">添加</font></span></h2>
<form name="incomeForm" action="" method="post">
<!-- areaName -->
<input type="hidden" id="areaName" name="areaName" value="<s:property value="areaName"/>"/>
<!-- return button flag -->
<input type="hidden" id="rflag" name="rflag" value="<s:property value="rflag"/>"/>
<!-- year -->
<input type="hidden" id="year" name="year" value="<s:property value="year"/>"/>
<!-- cbm -->
<input type="hidden" id="cbm" name="cbm" value="<s:property value="cbm"/>"/>
<!-- add or edit flag -->
<input type="hidden" id="i1" name="instr"/>
<!-- hm -->
<input type="hidden" id="i2" name="instr"/>
<div class="member-list">
	<table width="450px" cellpadding="0" cellspacing="0">
		<tr>
			<td align="right">种植业收入(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i3" name="instr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">养殖业收入(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i4" name="instr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">务工收入(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i5" name="instr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">低保、五保、养老收入(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i6" name="instr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">补贴性收入(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i7" name="instr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">其他收入(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i8" name="instr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">无偿帮扶资金(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i9" name="instr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">股份分红(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i10" name="instr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">小额贷款和互相资金(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i11" name="instr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">劳动力转移培训(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i12" name="instr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">劳动力转移就业人数(人):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i13" name="instr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
	</table>
</div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subYearBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-close" type="button" value="取消" class="button4"/>
</div>
</form>
</div>
<!-- add year end-->

</body>
</html>