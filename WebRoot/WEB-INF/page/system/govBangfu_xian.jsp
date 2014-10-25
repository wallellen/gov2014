<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<style type="text/css">
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:5px;cursor:move;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
		#overlay-bangfu{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-bangfu{position:absolute;top:30%;left:45%;width:500px;height:490px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-bangfu .back-input{height:20px; width:140px;}
		#overlay-bangfus{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-bangfus{position:absolute;top:30%;left:45%;width:500px;height:190px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-bangfus .back-input{height:20px; width:140px;}
	</style>
</head>
<body style="background:#E0EEFB;">
<h3 class="jiangbu-title">省级后方单位挂钩帮扶情况&nbsp;[<s:property value="deptName"/>]</h3>
<p class="jiangbu-title1"><span><s:property value="title"/>&nbsp;(<s:property value="sdt"/>~<s:property value="edt"/>)</span></p>
<div id="jiangbu-data1">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
   	<tr>
   		<td rowspan="3" width="4%">序号</td>
        <td rowspan="3" width="16%">县名称</td>
        <td colspan="4">挂钩帮扶村情况</td>
       	<td colspan="10">挂钩帮扶全县情况</td>
        <td rowspan="3" width="4%">备注</td>
        <td rowspan="3" width="8%">
        	<p>
        	<input type="button" value="导出" onclick="location.href='${pageContext.request.contextPath }/system/govBangfuAction_exportWithXian.do?rid=<s:property value="rid"/>&xm=<s:property value="xm"/>&title=<s:property value="title"/>&byxian=<s:property value="byxian"/>'" class="button43"/>
        	</p>
        	<p>&nbsp;</p>
        	<p>
        	<input type="button" value="返回" onclick="javascript:history.go(-1)" class="button43"/>
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
    <c:forEach items="${bfList }" var="ls" varStatus="status">
    <tr style="display:none" title="县名称: ${ls.c1 }">
        <td>${ls.c0 }</td>
        <td align="left">
        	<c:set var="c1len" value="${fn:length(ls.c1) }"></c:set>
        	<c:choose>
        		<c:when test="${c1len gt 10 }">
        			${fn:substring(ls.c1,0,9) }..
        		</c:when>
        		<c:otherwise>${ls.c1 }</c:otherwise>
        	</c:choose>
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
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
        <td></td>
        <td>
        	<a href="${pageContext.request.contextPath }/system/govBangfuAction_viewXianDetail.do?rid=${rid }&xm=${ls.c0 }&xianName=${ls.c1 }&title=${title }&sdt=${sdt }&edt=${edt }&byxian=${byxian }">查看详细</a>
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
		<!--  
		<tr>
			<td align="right">省级后方单位名称:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh1" name="bftxt" class="back-input" maxlength="20"/>
			</td>
		</tr>
		-->
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
				<input type="text" id="hh4" name="bftxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">到村项目个数(个):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh5" name="bftxt" class="back-input" maxlength="5" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">后方单位自筹资金(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh6" name="bftxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">协调资金(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh7" name="bftxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">完成项目数(个):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh8" name="bftxt" class="back-input" maxlength="5" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">在建项目数(个):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh9" name="bftxt" class="back-input" maxlength="5" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">3.帮扶实物折价(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh10" name="bftxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">单位领导:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh11" name="bftxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">中层及以下人员:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh12" name="bftxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
		</tr>
	</table>
</div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subJiangBuBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-close" type="button" value="取消" class="button4"/>
</div>
</form>
</div>
<!-- add jiangbu end -->
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/bangfu.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
</body>
</html>