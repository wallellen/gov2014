<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/datePicker/skin/WdatePicker.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/villageproject.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/validate.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
	<style type="text/css">
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:5px;cursor:move;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
		#overlay-villageproject{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-villageproject{position:absolute;top:30%;left:45%;width:500px;height:530px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-villageproject .back-input{height:20px; width:140px;}
	</style>
	<script type="text/javascript">
		function deleteVillageProject(c0,c1){
			document.getElementById("cmIds").value=c1;
			document.getElementById("pidIds").value=c0;
			if(confirm('您确定要删除吗？')){
				document.Form1.action="govVillageProjectAction_deleteVillInfo.do";
				document.Form1.submit();
			}
		}
	</script>
</head>
<body style="background:#E0EEFB;">
<form name="Form1" id="Form1">
	<input type="hidden" name="cm" id="cmIds"/>
	<input type="hidden" name="pid" id="pidIds"/>
	<input type="hidden" name="crid" value="<s:property value='crid'/>"/>
	<input type="hidden" name="navbm" value="<s:property value='navbm'/>"/>
	<input type="hidden" name="title" value="<s:property value='title'/>"/>
	<input type="hidden" name="sdt" value="<s:property value='sdt'/>"/>
	<input type="hidden" name="edt" value="<s:property value='edt'/>"/>
	<input type="hidden" name="rflag" value="<s:property value='rflag'/>"/>
</form>
<h3 class="jiangbu-title">省级财政支持村级集体经济发展项目实施进度</h3><div class="jiangbu-unit">单位：万元</div>
<p class="jiangbu-title1"><span class="j_return"></span><span><s:property value="title"/>&nbsp;(<s:property value="sdt"/>~<s:property value="edt"/>)</span></p>
<s:if test="#session.vts.rbm.length()==2">
<div id="village-data1">
</s:if>
<s:else>
<div id="village-data">
</s:else>
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
   	<tr>
     	<td rowspan="3" width="4%">序号</td>
        <td rowspan="3" width="10%">村名</td>
        <td rowspan="3" width="14%">项目名称</td>
        <td rowspan="3" width="4%">总投资</td>
        <td colspan="8">其中</td>
    	<td rowspan="3" width="4%">项目建成后预计年效益</td>
        <td rowspan="3" width="4%">项目为村集体增加经营性收入额</td>
        <td rowspan="3" width="4%">上年村集体经营性收入</td>
        <td rowspan="3" width="6%">达到省定2015年集体收入目标时间</td>
        <td rowspan="3" width="4%">省级财政投入资金拔付进度</td>
        <td rowspan="3" width="4%">项目实施进度</td>
        <td rowspan="3" width="8%">
        	<s:if test="#session.vts.rbm.length()<6">
        	<p>
        	<input type="button" value="导出" onclick="location.href='${pageContext.request.contextPath }/system/govVillageProjectAction_exportVillageProjectDetail.do?crid=<s:property value="crid"/>&navbm=<s:property value="navbm"/>&title=<s:property value="title"/>'" class="button43"/>
        	</p>
        	</s:if>
        	<p>&nbsp;</p>
        	<p>
			<input type="button" value="返回" onclick="javascript:history.go(-<s:property value='rflag'/>)" class="button43"/>
			</p>
		</td>
    </tr>
    <tr>
    	<td rowspan="2" width="4%">财政补助</td>
        <td colspan="4">其中</td>
        <td rowspan="2" width="4%">其他投入</td>
        <td colspan="2">其中</td>
    </tr>
    <tr>
        <td width="4%">省级财政投入</td>
        <td width="4%">市级财政投入</td>
        <td width="4%">县级财政投入</td>
        <td width="4%">乡镇财政投入</td>
        <td width="4%">扶贫资金投入</td>
        <td width="4%">社会捐赠投入</td>
    </tr>
    </thead>
    <tbody id="splitpage">
    <s:iterator value="#session.vts.list" var="ls" status="sc">
    <tr style="display:none" title="村名: <s:property value='#ls.c2'/>&#10;村编码: <s:property value='#ls.c1'/>&#10;项目名称: <s:property value='#ls.c3'/>&#10;项目描述: <s:property value='#ls.c4'/>">
		<td><label id="#sc.count"></label><s:property value="#sc.count"/></td>
		<td><s:property value="#ls.c2.length()>6?#ls.c2.substring(0,5)+'...':#ls.c2"/></td>
		<td><s:property value="#ls.c3.length()>11?#ls.c3.substring(0,10)+'...':#ls.c3"/></td>
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
        <td><s:property value="#ls.c15"/></td>
        <td><s:property value="#ls.c16"/></td>
        <td><s:property value="#ls.c17.substring(0,7)"/></td>
        <td><s:property value="#ls.c18"/></td>
        <td><s:property value="#ls.c19"/></td>
        <td>
        	<s:if test="#session.vts.rbm.length()>2">
        	<a href="javascript:popVillageProjectEdit('edit','<s:property value="#ls.c1"/>','<s:property value="#ls.c0"/>','<s:property value="#ls.c3"/>','<s:property value="#ls.c4"/>','<s:property value="#ls.c7"/>','<s:property value="#ls.c8"/>','<s:property value="#ls.c9"/>','<s:property value="#ls.c10"/>','<s:property value="#ls.c12"/>','<s:property value="#ls.c13"/>','<s:property value="#ls.c14"/>','<s:property value="#ls.c15"/>','<s:property value="#ls.c16"/>','<s:property value="#ls.c17"/>','<s:property value="#ls.c18"/>','<s:property value="#ls.c19"/>','<s:property value="#ls.c2"/>')">修改</a>
        	<a href="javascript:deleteVillageProject('<s:property value="#ls.c0"/>','<s:property value="#ls.c1"/>')">删除</a>
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
<s:if test="#session.vts.rbm.length()>2">
<div id="village-add">
	<fieldset>
	<legend>请点击村名称,添加新项目</legend>
	<ul>
		<s:iterator value="#session.vts.list2" var="ls2">
			<li><a href="javascript:popVillageProjectEdit('add','<s:property value="#ls2.c0"/>','','','','','','','','','','','','','','','','<s:property value="#ls2.c1"/>')"><s:property value="#ls2.c1"/></a></li>
		</s:iterator>
    </ul>
    </fieldset>
</div>
</s:if>
<!-- add key project start -->
<div id="overlay-villageproject"></div>
<div id="win-villageproject" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="vtitle"><font color="#fff">修改关键项目情况</font></span></h2>
<form name="villageProjectForm" action="" method="post">
<div class="member-list">
	<table width="450px" cellpadding="0" cellspacing="0">
		<tr>
			<td align="right">项目名称:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp1" name="vptxt" class="back-input" maxlength="20"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">项目描述:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp2" name="vptxt" class="back-input" maxlength="20"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">省级财政投入(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp3" name="vptxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">市级财政投入(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp4" name="vptxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">县级财政投入(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp5" name="vptxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">乡镇财政投入(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp6" name="vptxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">扶贫资金投入(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp7" name="vptxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">社会捐赠投入(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp8" name="vptxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">项目建成后预计年效益(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp9" name="vptxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">项目为集体增加经营性收入(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp10" name="vptxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">上年村集体经营性收入(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp11" name="vptxt" class="back-input" maxlength="3" onkeyup="checkFloatInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">2015目标时间:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp12" name="vptxt" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" class="Wdate back-input" maxlength="8"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">省级财政投入资金拨付进度(%):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp13" name="vptxt" class="back-input" maxlength="3" onkeyup="checkPercentInput(this)"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td align="right">项目实施进度(%):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="vp14" name="vptxt" class="back-input" maxlength="3" onkeyup="checkPercentInput(this)"/>
			</td>
			<td></td>
		</tr>
		
	</table>
</div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subVillageProjectBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-close" type="button" value="取消" class="button4"/>
</div>
<input type="hidden" id="vcm" name="vptxt" value=""/>
<input type="hidden" id="vpid" name="vptxt" value=""/>
<input type="hidden" name="navbm" value="<s:property value='navbm'/>"/>
<input type="hidden" name="title" value="<s:property value='title'/>"/>
<input type="hidden" name="sdt" value="<s:property value='sdt'/>"/>
<input type="hidden" name="edt" value="<s:property value='edt'/>"/>
<input type="hidden" name="crid" value="<s:property value='crid'/>"/>
<input type="hidden" name="rflag" value="<s:property value='rflag'/>"/>
</form>
</div>
</body>
</html>