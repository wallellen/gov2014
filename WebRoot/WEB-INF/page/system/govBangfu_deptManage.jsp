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
		
		#Tab{margin:0 auto;width:866px;}
		.Menubox{height:28px;border-bottom:1px solid #64B8E4;background:#E4F2FB;}
		.Menubox ul{list-style:none;margin:0px 2px;padding:0;position:absolute;}
		.Menubox ul li{float:left;width:158px;background:#64B8E4;line-height:27px;display:block;cursor:pointer;text-align:center;color:#fff;font-weight:bold;border-top:1px solid #64B8E4;border-left:1px solid #64B8E4;border-right:1px solid #64B8E4; margin-right:2px;}
		.Menubox ul li.hover{background:#fff;border-bottom:1px solid #fff;color:#147AB8;}
		.Contentbox{clear:both;margin-top:0px;border-top:none;height:181px;padding-top:8px;height:100%;}
		.Contentbox ul{list-style:none;margin:7px;padding:0;}
		.Contentbox ul li{line-height:24px; width:158px; float:left; margin-right:5px;}	
		
		.Menubox ul .box_return{float:left;width:158px;background:#E0EEFB;line-height:27px;display:block;text-align:center;color:#E0EEFB;font-weight:bold;border-top:0px solid #64B8E4;border-left:0px solid #64B8E4;border-right:0px solid #64B8E4; margin-left:190px;}
	</style>
	<script type="text/javascript">
		function deleteHoufang(f){
			document.getElementById("fuids").value=f;
			if(confirm('您确定要删除吗？')){
				document.Form1.action="govBangfuAction_deleteBangfuDept.do";
				document.Form1.submit();
			}
		}
	</script>
</head>
<body style="background:#E0EEFB;">
<form name="Form1" method="post">
	<input type="hidden" name="fuid" id="fuids"/>
	<input type="hidden" name="rflag" value="<s:property value='rflag'/>"/>
</form>
<h3 class="jiangbu-title">省级后方单位管理</h3>
<p class="jiangbu-title1"><span class="add_return"><input type="button" value="添加" onclick="popBangfuDeptEdit('add','','1','','')" class="button43"/></span><span class="add_return"><input type="button" value="返回" onclick="javascript:history.go(-<s:property value='rflag'/>)" class="button43"/></span></p>
<div id="jiangbu-data1">
	<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
		<thead>
			<tr>
				<td width="30%">记录编号</td>
				<td width="40%">单位名称</td>
				<td width="30%">操作</td>
			</tr>
		</thead>
		<tbody id="splitpage">
			<s:iterator value="#session.vts.list" var="ls" status="sc">
				<tr style="display:none">
					<td><s:property value="#ls.c0"/></td>
					<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#ls.c3"/></td>
					<td>
						<a href="javascript:popBangfuDeptEdit('edit','<s:property value="#ls.c0"/>','<s:property value="#ls.c1"/>','<s:property value="#ls.c2"/>','<s:property value="#ls.c3"/>')">编辑</a>
						<a href="javascript:deleteHoufang('<s:property value="#ls.c0"/>')">删除</a>
					</td>
				</tr>
			</s:iterator>
		</tbody>
	</table>
</div>
<div class="split-page">
	<input type="hidden" id="pageRows" value="27"/>
	<div id="changePage"></div>
</div>

<!-- add deptName start -->
<div id="overlay-bangfus"></div>
<div id="win-bangfus" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="bstitle"><font color="#fff">修改财政奖补到户情况</font></span></h2>
<form name="bangFuDeptForm" action="" method="post">
<input type="hidden" id="fuid" name="bftxt" value=""/>
<div class="member-list">
	<table width="490px" cellpadding="0" cellspacing="0">
		<tr height="20px"></tr>
		<tr>
			<td align="right">省级后方单位名称:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh1s" name="bftxt" class="back-input" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<td align="right">单位类别:&nbsp;&nbsp;</td>
			<td align="left">
				<s:select id="tid" name="bftxt" list="#application.vta.GetList('bfdept')" listKey="id" listValue="str" value="" cssClass="sele"></s:select>
			</td>
		</tr>
	</table>
</div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subBangfuDeptBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-closes" type="button" value="取消" class="button4"/>
</div>
<input type="hidden" name="rflag" value="<s:property value='rflag'/>"/>
</form>
</div>
<!-- add deptName end -->
</body>
</html>