<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/xian-credit.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
	<style type="text/css">
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:5px;cursor:move;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
		#overlay-credit{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-credit{position:absolute;top:30%;left:45%;width:500px;height:360px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-credit .back-input{height:20px; width:100px;}
		
		.xiaoe-errtip{
			width:290px; 
			height:18px;
			line-height:18px;
			color:#F00;
		}
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
<h3 class="jiangbu-title">扶贫小额贷款发放、回收情况&nbsp;[<s:property value="areaName"/>]</h3><div class="jiangbu-unit1">单位：户、万元</div>
<p class="jiangbu-title1"><span class="j_return"></span><span><s:property value="title"/>&nbsp;(<s:property value="sdt"/>~<s:property value="edt"/>)</span></p>
<div id="village-data1">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
   	<tr>
   		<td rowspan="4" width="5%">月份</td>
   		<td colspan="2">一</td>
   		<td colspan="2">二</td>
   		<td colspan="2">三</td>
        <td colspan="6">四</td>
        <td width="5%">五</td>
        <td rowspan="4" width="8%">
        	<p>
        		<input type="button" value="导出" onclick="location.href='${pageContext.request.contextPath }/system/govXianCreditAction_exportXiaoeMonth.do?year=<s:property value="year"/>&xbm=<s:property value="xbm"/>&title=<s:property value="title"/>&rflag=<s:property value="rflag"/>'" class="button43"/>
        	</p>
        	<p>&nbsp;</p>
        	<p>
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
    	<td rowspan="3">贷款指导性计划</td>
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
    <s:iterator value="#session.vts.list" var="ls" status="sc">
    	<tr style="display:none">
	        <td><s:property value="#ls.month"/></td>
	        <td><s:property value="#ls.lh"/></td>
	        <td><s:property value="#ls.lv"/></td>
	        <td><s:property value="#ls.tsh"/></td>
	        <td><s:property value="#ls.tsv"/></td>
	        <td><s:property value="#ls.trh"/></td>
	        <td><s:property value="#ls.trv"/></td>
	        <td><s:property value="#ls.th"/></td>
	        <td><s:property value="#ls.tv"/></td>
	        <td><s:property value="#ls.nh"/></td>
	        <td><s:property value="#ls.nv"/></td>
	        <td><s:property value="#ls.eh"/></td>
	        <td><s:property value="#ls.ev"/></td>
	        <td>&nbsp;</td>
	        <td>
	        	<s:if test="#session.vts.rbm.length()==6">
		        	<s:if test="#ls.lh.length()>0">
			        	<s:if test="#session.vts.map.month-1==#ls.month">
			        	<a href="javascript:popXianCreditEdit('edit','<s:property value="#ls.month"/>','<s:property value="#ls.lh"/>','<s:property value="#ls.lv"/>','<s:property value="#ls.tsh"/>','<s:property value="#ls.tsv"/>','<s:property value="#ls.trh"/>','<s:property value="#ls.trv"/>','<s:property value="#ls.th"/>','<s:property value="#ls.tv"/>','<s:property value="#ls.nh"/>','<s:property value="#ls.nv"/>','<s:property value="#ls.eh"/>','<s:property value="#ls.ev"/>')">修改</a>
			        	<a href="javascript:deleteXianCredit('<s:property value="#ls.month"/>')">删除</a>
			        	</s:if>
		        	</s:if>
		        	<s:else>
			        	<s:if test="#session.vts.map.month==#ls.month">
			        	<a href="javascript:popXianCreditEdit('add','<s:property value="#ls.month"/>','<s:property value="#session.vts.map.lh"/>','<s:property value="#session.vts.map.lv"/>','','','','','','','','','','')">添加</a>
			        	</s:if>
		        	</s:else>
	        	</s:if>
	        </td>
    	</tr>
	</s:iterator>
	</tbody>
</table>
</div>
<div class="split-page">
	<input type="hidden" id="pageRows" value="18"/>
	<div id="changePage"></div>
</div>

<!-- add xian credit start -->
<div id="overlay-credit"></div>
<div id="win-credit" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="xtitle"><font color="#fff">修改关键项目情况</font></span></h2>
<form name="xianCreditForm" action="" method="post">
<!-- edit or add flag -->
<input type="hidden" id="c0" name="xestr"/>
<!-- month flag -->
<input type="hidden" id="i_month" name="xestr"/>
<div class="xiaoe-tab">
	<table width="450px" cellpadding="0" cellspacing="0">
		<tr>
			<td width="20%" align="right"></td>
			<td width="10%" align="right"></td>
			<td width="40%" colspan="2" align="center">
			<h3>[&nbsp;<s:property value="year"/>年&nbsp;&nbsp;<label id="c1"></label>月&nbsp;]</h3>
			</td>
			<td width="20%" align="left"></td>
			<td width="10%"></td>
		</tr>
		<tr>
			<td width="20%" align="right">上年(月)结余</td>
			<td width="10%" align="right">户数:&nbsp;&nbsp;</td>
			<td width="20%" align="left">
				<label id="c2"></label>
			</td>
			<td width="20%" align="right">金额(万元):&nbsp;&nbsp;</td>
			<td width="10%" align="left">
				<label id="c3"></label>	
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">本月发放</td>
			<td align="right">户数:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c4" name="xestr" class="back-input" maxlength="8" onblur="checkHuInt(this)"/>
			</td>
			<td align="right">金额(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c5" name="xestr" class="back-input" maxlength="8" onblur="checkMoney(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">本月收回</td>
			<td align="right">户数:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c6" name="xestr" class="back-input" maxlength="8" onblur="checkHuInt(this)"/>
			</td>
			<td align="right">金额(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c7" name="xestr" class="back-input" maxlength="8" onblur="checkMoney(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">本月结余</td>
			<td align="right">户数:&nbsp;&nbsp;</td>
			<td align="left">
				<label id="c8"></label>
			</td>
			<td align="right">金额(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<label id="c9"></label>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">未到期贷款</td>
			<td align="right">户数:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c10" name="xestr" class="back-input" maxlength="8" onblur="checkHuInt(this)"/>	
			</td>
			<td align="right">金额(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c11" name="xestr" class="back-input" maxlength="8" onblur="checkMoney(this)"/>
			</td>
			<td>
				<input type="button" value="计算" onclick="autoCalculate1()"/>
			</td>
		</tr>
		<tr>
			<td align="right">逾期贷款</td>
			<td align="right">户数:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c12" name="xestr" class="back-input" maxlength="8" onblur="checkHuInt(this)"/>
			</td>
			<td align="right">金额(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="c13" name="xestr" class="back-input" maxlength="8" onblur="checkMoney(this)"/>	
			</td>
			<td>
				<input type="button" value="计算" onclick="autoCalculate2()"/>
			</td>
		</tr>
		
	</table>
</div>
<div id="xiaoErrTip" class="xiaoe-errtip"></div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subXianCreditBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-close" type="button" value="取消" class="button4"/>
</div>
<p><label id="xerrortip" style="color:#f00"></label></p>
<input type="hidden" id="i_year" name="year" value="<s:property value='year'/>"/>
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