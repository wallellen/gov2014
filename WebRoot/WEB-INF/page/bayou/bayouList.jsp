<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/global_cn.css?v=3" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style-b.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<style type="text/css">
		.Contentbox_shi{clear:both;margin-top:0px;border-top:none;height:640px; overflow-y:auto;text-align:center; line-height:22px;}
		.Contentbox_shi table{border-right:1px solid #3B9FFF; border-bottom:1px solid #3B9FFF; margin-top:2px;}
		.Contentbox_shi table td{border-top:1px solid #3B9FFF; border-left:1px solid #3B9FFF; empty-cells:show;}
		.Contentbox_shi .tabtr1 {
			background: url(../images/tab-head.jpg) repeat-x;
			height: 20px;
			font-weight: bold;
			color: #2284E1;
		}
	</style>
</head>
<body style="background:#E0EEFB;">
<form name="form1" action="${pageContext.request.contextPath }/system/bayou_addcun.do" method="post">
<input type="hidden" name="rflag" value="${rflag }"/>
<input type="hidden" name="retbtn" value="y"/>
<h3 class="jiangbu-title">经济薄弱村新“八有”考核&nbsp;${titlename }</h3>
</form>
<s:property value="#request.h" escape="false"/>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/bayou.js?v=1"></script>
</body>
</html>