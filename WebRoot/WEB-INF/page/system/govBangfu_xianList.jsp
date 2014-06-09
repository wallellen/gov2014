<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/bangfu.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
	<style type="text/css">
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:5px;cursor:move;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
		#overlay-bangfu{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-bangfu{position:absolute;top:30%;left:45%;width:500px;height:490px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-bangfu .back-input{height:20px; width:140px;}
		#overlay-bangfus{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-bangfus{position:absolute;top:30%;left:45%;width:500px;height:190px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-bangfus .back-input{height:20px; width:140px;}
		
		.hourf-errtip{
			width:265px; 
			height:18px;
			line-height:18px;
			color:#F00;
		}
	</style>
	<script type="text/javascript">
		function deleteBangFu(c){
			document.getElementById("iids").value=c;
			if(confirm('您确定要删除吗？')){
				document.Form1.action="govBangfuAction_deleteBangfuInfo.do";
				document.Form1.submit();
			}
		}
	</script>
</head>
<body style="background:#E0EEFB;">
<form name="Form1" id="Form1">
	<input type="hidden" name="iid" id="iids"/>
	<input type="hidden" name="rid" value="<s:property value='rid'/>"/>
	<input type="hidden" name="title" value="<s:property value='title'/>"/>
	<input type="hidden" name="sdt" value="<s:property value='sdt'/>"/>
	<input type="hidden" name="edt" value="<s:property value='edt'/>"/>
	<input type="hidden" name="rflag" value="<s:property value='rflag'/>"/>
	<input type="hidden" name="deptName" value="<s:property value='deptName'/>"/>
</form>
<h3 class="jiangbu-title">省级后方单位挂钩帮扶情况&nbsp;[<s:property value="deptName"/>]</h3>
<p class="jiangbu-title1"><span><s:property value="title"/>&nbsp;(<s:property value="sdt"/>~<s:property value="edt"/>)</span></p>
<div id="jiangbu-data1">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
   	<tr>
   		<td rowspan="3" width="4%">序号</td>
        <td rowspan="3" width="16%">省级后方单位名称</td>
        <td colspan="4">挂钩帮扶村情况</td>
       	<td colspan="10">挂钩帮扶全县情况</td>
        <td rowspan="3" width="4%">备注</td>
        <td rowspan="3" width="8%">
        	<p>
        	<input type="button" value="导出" onclick="location.href='${pageContext.request.contextPath }/system/govBangfuAction_exportWriteWithDept.do?rid=<s:property value="rid"/>&title=<s:property value="title"/>&byunit=<s:property value="byunit"/>'" class="button43"/>
        	</p>
        	<p>&nbsp;</p>
        	<p>
        	<input type="button" value="添加" onclick="location.href='${pageContext.request.contextPath }/system/govBangfuAction_addBangfu.do?rid=<s:property value="rid"/>&title=<s:property value="title"/>&sdt=<s:property value="sdt"/>&edt=<s:property value="edt"/>&deptName=<s:property value="deptName"/>'" class="button43"/>
        	</p>
        	<p>&nbsp;</p>
        	<p>
        	<input type="button" value="返回" onclick="javascript:history.go(-<s:property value='rflag'/>)" class="button43"/><br/><br/>
        	</p>
        </td>
    </tr>
    <tr>
    	<td rowspan="2" width="4%">所在乡镇名称</td>
        <td rowspan="2" width="4%">挂钩村名称</td>
        <td rowspan="2" width="5%">到村项目资金(万元)</td>
        <td rowspan="2" width="5%">到村项目个数(个)</td>
       	<td rowspan="2" width="5%">1.无偿帮扶资金投入合计(万元)</td>
       	<td colspan="2">其中</td>
        <td rowspan="2" width="5%">2.实施帮扶项目总数(个)</td>
       	<td colspan="2">其中</td>
       	<td rowspan="2" width="5%">3.帮扶实物折价(万元)</td>
        <td rowspan="2" width="5%">4.现场办公人次合计</td>
        <td colspan="2">其中</td>
    </tr>
    <tr>
        <td width="5%">后方单位自筹资金(万元)</td>
        <td width="5%">协调资金(万元)</td>
        <td width="5%">完成项目数(个)</td>
        <td width="5%">在建项目数(个)</td>
        <td width="4%">单位领导</td>
        <td width="4%">中层及以下人员</td>
    </tr>
    </thead>
    <tbody id="splitpage">
    <s:iterator value="#session.vts.list" var="ls" status="sc">
    <tr style="display:none" title="省级后方单位名称: <s:property value='#ls.c1'/>&#10;所在乡镇名称: <s:property value='#ls.c14'/>&#10;挂钩村名称: <s:property value='#ls.c15'/>">
        <td><s:property value="#sc.count"/></td>
        <td align="left">&nbsp;<s:property value="#ls.c1.length()>10?#ls.c1.substring(0,9)+'...':#ls.c1"/></td>
        <td><s:property value="#ls.c14.length()>2?#ls.c14.substring(0,1)+'...':#ls.c14"/></td>
        <td><s:property value="#ls.c15.length()>2?#ls.c15.substring(0,1)+'...':#ls.c15"/></td>
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
        <td></td>
        <td>
        	<a href="javascript:popBangfuEdit('edit','<s:property value="#ls.c0"/>','<s:property value="#ls.c2"/>','<s:property value="#ls.c3"/>','<s:property value="#ls.c5"/>','<s:property value="#ls.c6"/>','<s:property value="#ls.c8"/>','<s:property value="#ls.c9"/>','<s:property value="#ls.c10"/>','<s:property value="#ls.c12"/>','<s:property value="#ls.c13"/>','<s:property value="#ls.c1"/>','<s:property value="#ls.c14"/>','<s:property value="#ls.c15"/>')">修改</a>
        	<a href="javascript:deleteBangFu('<s:property value="#ls.c0"/>')">删除</a>
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
<!-- add jiangbus start -->
<div id="overlay-bangfus"></div>
<div id="win-bangfus" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="bstitle"><font color="#fff">修改财政奖补到户情况</font></span></h2>
<form name="bangFusForm" action="" method="post">
<input type="hidden" id="iidx" name="bftxt" value=""/>
<div class="member-list">
	<table width="490px" cellpadding="0" cellspacing="0">
		<tr height="20px"></tr>
		<tr>
			<td align="right">省级后方单位名称:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh1s" name="bftxt" class="back-input" maxlength="20"/>
			</td>
		</tr>
	</table>
</div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subJiangBusBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-closes" type="button" value="取消" class="button4"/>
</div>
</form>
</div>
<!-- add jiangbus end -->

<!-- add jiangbu start -->
<div id="overlay-bangfu"></div>
<div id="win-bangfu" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="btitle"><font color="#fff">修改财政奖补到户情况</font></span></h2>
<form name="bangFuForm" action="" method="post">
<input type="hidden" id="iid" name="bftxt" value=""/>
<input type="hidden" id="hh1" name="bftxt" value=""/>
<div class="member-list">
	<table width="490px" cellpadding="0" cellspacing="0">
		<tr>
			<td align="right">所在乡镇名称:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh2" name="bftxt" class="back-input" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<td align="right">挂钩村名称:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh3" name="bftxt" class="back-input" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<td align="right">到村项目资金(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh4" name="bftxt" class="back-input" maxlength="3" onblur="checkHoufMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">到村项目个数(个):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh5" name="bftxt" class="back-input" maxlength="5" onblur="checkHoufItem(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">后方单位自筹资金(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh6" name="bftxt" class="back-input" maxlength="3" onblur="checkHoufMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">协调资金(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh7" name="bftxt" class="back-input" maxlength="3" onblur="checkHoufMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">完成项目数(个):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh8" name="bftxt" class="back-input" maxlength="5" onblur="checkHoufItem(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">在建项目数(个):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh9" name="bftxt" class="back-input" maxlength="5" onblur="checkHoufItem(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">帮扶实物折价(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh10" name="bftxt" class="back-input" maxlength="3" onblur="checkHoufMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">单位领导:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh11" name="bftxt" class="back-input" maxlength="3" onblur="checkHoufItem(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">中层及以下人员:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh12" name="bftxt" class="back-input" maxlength="3" onblur="checkHoufItem(this)"/>
			</td>
		</tr>
	</table>
</div>
<div id="houfErrTip" class="hourf-errtip"></div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subJiangBuBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-close" type="button" value="取消" class="button4"/>
</div>
<input type="hidden" name="bftxt" value="<s:property value='rid'/>"/>
<input type="hidden" name="navbm" value="<s:property value='navbm'/>"/>
<input type="hidden" name="title" value="<s:property value='title'/>"/>
<input type="hidden" name="sdt" value="<s:property value='sdt'/>"/>
<input type="hidden" name="edt" value="<s:property value='edt'/>"/>
<input type="hidden" name="crid" value="<s:property value='crid'/>"/>
<input type="hidden" name="rflag" value="<s:property value='rflag'/>"/>
<input type="hidden" name="deptName" value="<s:property value='deptName'/>"/>
</form>
</div>
<!-- add jiangbu end -->
</body>
</html>