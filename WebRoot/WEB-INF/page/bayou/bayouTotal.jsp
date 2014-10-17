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
<h3 class="jiangbu-title">经济薄弱村新“八有”考核汇总</h3>
<div class="Contentbox_shi">
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr style="font-weight:bold;">
			<td width="12%">县名称</td>
			<td width="10%">省级财政<br/>资金(万元)</td>
			<td width="10%">市级财政<br/>资金(万元)</td>
			<td width="10%">县级财政<br/>资金(万元)</td>
			<td width="10%">帮扶单位<br/>资金(万元)</td>
			<td width="10%">其他<br/>资金(万元)</td>
			<td width="10%">实施项目<br/>个数</td>
			<td width="10%">2014年上报实现<br/>八有村个数</td>
			<td width="10%">实际实现<br/>八有村个数</td>
		</tr>
		<s:iterator value="#session.vts.list">
			<tr>
				<td>${OName }</td>
				<td>${v1 }</td>
				<td>${v2 }</td>
				<td>${v3 }</td>
				<td>${v4 }</td>
				<td>${v5 }</td>
				<td>${pi }</td>
				<td>${y1 }</td>
				<td>${y2 }</td>
			</tr>
		</s:iterator>
	</table>
</div>
</body>
</html>