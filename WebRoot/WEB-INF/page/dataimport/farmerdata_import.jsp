<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/global_cn.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/data_import.js"></script>
</head>
<body style="background:#E0EEFB;">
	<h3 class="jiangbu-title">低收入农户资料维护</h3>
	<div style="margin:0 auto; width:490px; height:300px; padding-top:10px;">
		<p>
			<label style="font-size:14px">农户数据模版Excel文件,点击<a href="${pageContext.request.contextPath }/down/低收入农户家庭信息导入模板.xls">下载</a></label>
		</p>
		<form name="farmerForm" action="" method="post" enctype="multipart/form-data"> 
		<p>&nbsp;</p> 
		<p>县码：<input type="text" id="xm" name="xm" class="input_w60" maxlength="6" onblur="checkXianma(this,'farmer')"/>
		<label id="xmTip"></label>
        	&nbsp;&nbsp;<input type="button" value="清除县数据" class="btn_w70" onclick="emptyFarmerData()">
        	<label class="color_r">(清除指定县的农户资料)</label>
		</p>
		<p>&nbsp;</p> 
       	<p>
			<label style="font-size:14px">选择农户数据Excel文件：</label>
		</p>
		<p>&nbsp;</p>
       	<div class="upload1">
			<input type="text" class="ipt_text" id="file_text" />
			<input type="button" class="btn" value="浏 览" />
			<input type="file" name="excel" class="upload_file1" size="26" onchange="document.getElementById('file_text').value=this.value" />
		</div>
		<p>&nbsp;</p> 
        <p>
        	<input type="button" value="批量导入" class="button4" onclick="checkFile('farmer')">
        </p>
        <p>&nbsp;</p> 
        <p>${importinfo }</p>
      </form>
	</div>
</body>
</html>