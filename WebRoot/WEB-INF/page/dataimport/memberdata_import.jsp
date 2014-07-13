<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/data_import.js"></script>
	<style type="text/css">
		.upload1{position:relative;width:260px;height:30px;}
		.ipt_text{width:174px;height:24px;line-height:24px;padding:2px;border:1px solid #aaa;}
		.ver_text{width:114px;height:24px;line-height:24px;padding:2px;border:1px solid #aaa;}
		.btn{width:70px;height:30px;line-height:30px;border:1px solid #aaa;}
		.upload_file1{position:absolute;left:0;top:0;width:260px;height:30px;line-height:30px;opacity:0;filter:alpha(opacity:0);}
	</style>
</head>
<body style="background:#E0EEFB;">
	<h3 class="jiangbu-title">家庭成员数据导入</h3>
	<div style="margin:0 auto; width:400px; height:300px; padding-top:10px;">
		<p>
			<label style="font-size:14px">家庭成员数据模版Excel文件,点击<a href="${pageContext.request.contextPath }/down/家庭成员数据导入模板.xls">下载</a></label>
		</p>
		<p>&nbsp;</p> 
		<form action="${pageContext.request.contextPath }/system/memberDataAction_importData.do" method="post" enctype="multipart/form-data">  
       	<p>
			<label style="font-size:14px">选择家庭成员数据Excel文件：</label>
		</p>
		<p>&nbsp;</p>
       	<div class="upload1">
			<input type="text" class="ipt_text" id="file_text" />
			<input type="button" class="btn" value="浏 览" />
			<input type="file" name="excel" class="upload_file1" size="26" onchange="document.getElementById('file_text').value=this.value" />
		</div>
		<p>&nbsp;</p> 
        <p>
        	<input type="submit" value="批量导入" class="button4" onclick="return checkFile()">
        </p>
        <p>&nbsp;</p> 
        <p>${importinfo }</p>
      </form>
	</div>
</body>
</html>