<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<style type="text/css">
		#overlay-year{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-year{position:absolute;top:30%;left:45%;width:500px;height:460px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;} 
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:5px;cursor:move;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
		.back-input{
			width:120px; height:20px;
		}
		.income-errtip{
			width:125px; 
			height:18px;
			line-height:18px;
			color:#F00;
		}
	</style>
</head>
<body style="background:#E0EEFB;">
<h3 class="jiangbu-title">${year }&nbsp;年收入及帮扶情况&nbsp;<c:if test="${areaName ne null }">[${areaName }]</c:if></h3>
<div id="jiangbu-data">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
   	<tr>
   		<td rowspan="3" width="12%">农户编码</td>
        <td rowspan="3" width="8%">户主姓名</td>
        <td colspan="8">家庭年收入情况(元)</td>
        <td colspan="5">帮扶情况</td>
        <td rowspan="3" width="8%">
        	<p>
        	<input type="button" value="导出" onclick="location.href='${pageContext.request.contextPath }/system/govIncomeAction_exportIncome.do?cbm=${cbm }&title=${title }&sdt=${sdt }&edt=${edt }&year=${year }&areaName=${areaName }'" class="button43"/>
        	</p>
        	<p>&nbsp;</p>
        	<p>
        	<input type="button" value="返回" onclick="javascript:history.go(-<s:property value='rflag'/>)" class="button43"/>
        	</p>
        </td>
    </tr>
    <tr>
    	<td rowspan="2" width="5%">1.全年家庭纯收入</td>
       	<td colspan="6">其中</td>
		<td rowspan="2" width="5%">2.家庭人均纯收入</td>
       	<td rowspan="2" width="5%">无偿帮扶资金(元)</td>
       	<td rowspan="2" width="5%">得到股份(元)</td>
       	<td rowspan="2" width="5%">小额贷款和互助资金(元)</td>
       	<td rowspan="2" width="5%">劳动力转移培训(人)</td>
       	<td rowspan="2" width="5%">劳动力转移就业人数(人)</td>
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
    <c:forEach items="${yearList }" var="ls">
    <tr style="display:none">
        <td>${ls.c0 }</td>
        <td title="${ls.c1 }">
        	<c:choose>
        		<c:when test="${fn:length(ls.c1)>5 }">
        			${fn:substring(ls.c1,0,4) }..
        		</c:when>
        		<c:otherwise>
        			${ls.c1 }
        		</c:otherwise>
        	</c:choose>
        </td>
        <td>${ls.c2 }</td>
		<td>${ls.c3 }</td>
		<td>${ls.c4 }</td>
		<td>${ls.c5 }</td>
		<td>${ls.c6 }</td>
		<td>${ls.c7 }</td>
		<td>${ls.c8 }</td>
		<td>${ls.c9 }</td>
		<td>${ls.c10 }</td>
		<td>${ls.c11 }</td>
		<td>${ls.c12 }</td>
		<td>${ls.c13 }</td>
		<td>${ls.c14 }</td>
        <td>
        	<s:if test="#session.vts.isedit==1 && #session.vts.rbm.length()>4">
			<c:choose>
				<c:when test="${fn:length(ls.c2) gt 0 }">
					<a href="javascript:popIncomeYear('edit','${ls.c0 }','${ls.c3 }','${ls.c4 }','${ls.c5 }','${ls.c6 }','${ls.c7 }','${ls.c8 }','${ls.c10 }','${ls.c11 }','${ls.c12 }','${ls.c13 }','${ls.c14 }','${ls.c1 }')">修改</a>	
				</c:when>
				<c:otherwise>
					<a href="javascript:popIncomeYear('add','${ls.c0 }','','','','','','','','','','','','${ls.c1 }')">添加</a>	
				</c:otherwise>
			</c:choose>
        	</s:if>
        	<a href="${pageContext.request.contextPath }/system/govBrowerAction_viewReportFamily.do?viewBM=${ls.c0 }">查看</a>
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

<!-- add year start -->
<div id="overlay-year"></div>
<div id="win-year" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="ytitle"><font color="#fff">添加</font></span></h2>
<form name="incomeForm" action="" method="post">
<!-- areaName -->
<input type="hidden" id="areaName" name="areaName" value="${areaName }"/>
<!-- return button flag -->
<input type="hidden" id="rflag" name="rflag" value="${rflag }"/>
<!-- year -->
<input type="hidden" id="year" name="year" value="${year }"/>
<!-- cbm -->
<input type="hidden" id="cbm" name="cbm" value="${cbm }"/>
<!-- add or edit flag -->
<input type="hidden" id="i1" name="instr"/>
<!-- hm -->
<input type="hidden" id="i2" name="instr"/>
<div class="member-list">
	<table width="500px" cellpadding="0" cellspacing="0">
		<tr>
			<td width="40%" align="right">种植业收入(元):&nbsp;&nbsp;</td>
			<td width="30%" align="left">
				<input type="text" id="i3" name="instr" size="12" class="back-input" maxlength="8" onblur="checkIncomeMoney(this)"/>
			</td>
			<td width="35%" rowspan="11">
				<div id="incomeErrTip" class="income-errtip"></div>
			</td>
		</tr>
		<tr>
			<td align="right">养殖业收入(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i4" name="instr" size="12" class="back-input" maxlength="8" onblur="checkIncomeMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">务工收入(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i5" name="instr" size="12" class="back-input" maxlength="8" onblur="checkIncomeMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">低保、五保、养老收入(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i6" name="instr" size="12" class="back-input" maxlength="8" onblur="checkIncomeMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">补贴性收入(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i7" name="instr" size="12" class="back-input" maxlength="8" onblur="checkIncomeMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">其他收入(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i8" name="instr" size="12" class="back-input" maxlength="8" onblur="checkIncomeMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">无偿帮扶资金(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i9" name="instr" size="12" class="back-input" maxlength="8" onblur="checkIncomeMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">股份分红(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i10" name="instr" size="12" class="back-input" maxlength="8" onblur="checkIncomeMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">小额贷款和互相资金(元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i11" name="instr" size="12" class="back-input" maxlength="8" onblur="checkIncomeMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">劳动力转移培训(人):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i12" name="instr" size="12" class="back-input" maxlength="8" onblur="checkIncomePerson(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">劳动力转移就业人数(人):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="i13" name="instr" size="12" class="back-input" maxlength="8" onblur="checkIncomePerson(this)"/>
			</td>
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
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/income.js"></script>
</body>
</html>