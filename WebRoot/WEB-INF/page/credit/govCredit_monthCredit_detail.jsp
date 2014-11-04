<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/datePicker/skin/WdatePicker.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/xian-credit.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/validate.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
	<style type="text/css">
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:5px;cursor:move;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
		#overlay-credit{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-credit{position:absolute;top:30%;left:45%;width:500px;height:450px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-credit .back-input{height:20px; width:140px;}
	</style>
	<script type="text/javascript">
		function deleteXianCredit(x){
			document.getElementById("d_month").value=x;
			if(confirm('您确定要删除吗？')){
				document.Form1.action="govXianCreditAction_deleteCreditInfo.do";
				document.Form1.submit();
			}
		}
	</script>
</head>
<body style="background:#E0EEFB;">
<form name="Form1" id="Form1">
	<input type="hidden" id="d_month" name="month"/>
	<input type="hidden" name="year" value="<s:property value='year'/>"/>
	<input type="hidden" name="title" value="<s:property value='title'/>"/>
	<input type="hidden" name="sdt" value="<s:property value='sdt'/>"/>
	<input type="hidden" name="edt" value="<s:property value='edt'/>"/>
	<input type="hidden" name="rflag" value="<s:property value='rflag'/>"/>
	<input type="hidden" name="areaName" value="<s:property value='areaName'/>"/>
</form>
<h3 class="jiangbu-title">扶贫小额贷款发放、回收情况&nbsp;[${areaName }]</h3><div class="jiangbu-unit1">单位：户、万元</div>
<p class="jiangbu-title1"><span class="j_return"></span><span>${title }&nbsp;(${sdt }~${edt })</span></p>
<div id="village-data1">
<table class="data_list1" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
   	<tr>
   		<td rowspan="4" width="8%">栏次/项目/信用社名称</td>
   		<td colspan="2">一</td>
   		<td colspan="2">二</td>
   		<td colspan="2">三</td>
        <td colspan="6">四</td>
        <td rowspan="4" width="8%">
        	<p>
        		<input type="button" value="导出" onclick="location.href='${pageContext.request.contextPath }/system/govXianCreditAction_exportXiaoeByue.do?year=${year }&month=${month }&title=${title }&rflag=${rflag }'" class="button43"/>
        		<input type="button" value="返回" onclick="history.go(-<s:property value="rflag"/>)" class="button43"/>
        	</p>
        </td>
    </tr>
    <tr>
    	<td rowspan="2" colspan="2">上年(月)余额</td>
    	<td rowspan="2" colspan="2">本月发放</td>
    	<td rowspan="2" colspan="2">本月收回</td>
    	<td rowspan="2" colspan="2">本月余额</td>
    	<td colspan="4">其中</td>
    </tr>
    <tr>
    	<td colspan="2">未到期贷款</td>
    	<td colspan="2">逾期贷款</td>
    </tr>
    <tr>
    	<td width="5%">户数</td>
    	<td width="5%">金额</td>
    	<td width="5%">户数</td>
    	<td width="5%">金额</td>
    	<td width="5%">户数</td>
    	<td width="5%">金额</td>
    	<td width="5%">户数</td>
    	<td width="5%">金额</td>
    	<td width="5%">户数</td>
    	<td width="5%">金额</td>
    	<td width="5%">户数</td>
    	<td width="5%">金额</td>
    </tr>
    
    </thead>
    <tbody id="splitpage">
    <c:forEach items="${xiaoeList }" var="ls">
    	<c:choose>
    		<c:when test="${ls.xid eq 0 }">
    			<tr style="display:none; background-color:#c0c0c0;">
    			<td align="left" style="font-weight:bold;">&nbsp;&nbsp;${ls.oname }</td>
    		</c:when>
    		<c:otherwise>
    			<tr style="display:none;">
    			<td>${ls.oname }</td>
    		</c:otherwise>
    	</c:choose>
	        <td>${ls.lh }</td>
	        <td>${ls.lv }</td>
	        <td>${ls.tsh }</td>
	        <td>${ls.tsv }</td>
	        <td>${ls.trh }</td>
	        <td>${ls.trv }</td>
	        <td>${ls.th }</td>
	        <td>${ls.tv }</td>
	        <td>${ls.nh }</td>
	        <td>${ls.nv }</td>
	        <td>${ls.eh }</td>
	        <td>${ls.ev }</td>
	        <td>
	        	<c:if test="${ls.xid gt 0 }">
	        	<a href="${pageContext.request.contextPath }/system/govXianCreditAction_viewXianCreditWithXbm.do?xbm=${ls.bm }&year=${year }&sdt=${sdt }&edt=${edt }&areaName=${ls.oname }">查看</a>
	        	</c:if>
	        </td>
    	</tr>
	</c:forEach>
	</tbody>
</table>
</div>
<div class="split-page">
	<input type="hidden" id="pageRows" value="24"/>
	<div id="changePage"></div>
</div>

<!-- add xian credit start -->
<div id="overlay-credit"></div>
<div id="win-credit" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="xtitle"><font color="#fff">修改关键项目情况</font></span></h2>
<form name="xianCreditForm" action="" method="post">
<!-- edit or add flag -->
<input type="hidden" id="c1" name="xestr"/>
<div class="member-list">
	<table width="450px" cellpadding="0" cellspacing="0">
		<tr>
			<td align="right" width="45%">年份:&nbsp;&nbsp;</td>
			<td align="left" width="55%">
				<s:property value="year"/>
			</td>
		</tr>
		<tr>
			<td align="right">月份:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c2" name="xestr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">本月发放户数:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c3" name="xestr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">本月发放金额:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c4" name="xestr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">本月收回户数:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c5" name="xestr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">本月收回金额:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c6" name="xestr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">未到期贷款户数:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c7" name="xestr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">未到期贷款金额:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c8" name="xestr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">逾期贷款户数:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c9" name="xestr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">逾期贷款金额:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c10" name="xestr" size="12" class="back-input" maxlength="8" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
	</table>
</div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subXianCreditBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-close" type="button" value="取消" class="button4"/>
</div>
<input type="hidden" name="year" value="<s:property value='year'/>"/>
<input type="hidden" name="navbm" value="<s:property value='navbm'/>"/>
<input type="hidden" name="title" value="<s:property value='title'/>"/>
<input type="hidden" name="sdt" value="<s:property value='sdt'/>"/>
<input type="hidden" name="edt" value="<s:property value='edt'/>"/>
<input type="hidden" name="rflag" value="<s:property value='rflag'/>"/>
<input type="hidden" name="areaName" value="<s:property value='areaName'/>"/>
</form>
</div>
</body>
</html>