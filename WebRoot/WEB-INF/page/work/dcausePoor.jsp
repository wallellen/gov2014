<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
</head>
<body style="background:#E0EEFB;">
<div id="leftCon">
	<ul>
    	<li><input type="button" onClick="location.href='${pageContext.request.contextPath }/system/govBrowerAction_returnList.do?viewBM=<s:property value="#session.vts.curBM"/>'" value="列表显示" class="button41"/></li>
        <li><input type="button" onClick="location.href='${pageContext.request.contextPath }/system/govBrowerAction_overView.do?page=property&viewBM=<s:property value="#session.vts.curBM"/>'" value="农户属性" class="button41"/></li>
        <!--  
        <li><input type="button" onClick="location.href='${pageContext.request.contextPath }/system/govBrowerAction_viewPoverty.do'" value="扶贫情况" class="button41"/></li>
        -->
        <li><input type="button" onClick="location.href='${pageContext.request.contextPath }/system/govBrowerAction_overView.do?page=dcause&viewBM=<s:property value="#session.vts.curBM"/>'" value="贫困原因" class="button41"/></li>
    </ul>
    <span class="farmer-title">贫困原因统计</span>
    <table class="tab-farmer" cellpadding="0" cellspacing="0">
    	<tr>
        	<td>贫困原因</td>
            <td>户数</td>
        </tr>
        <s:iterator value="#session.vts.list2" var="ls2">
		<tr>
			<td align="center" width="95px"><s:property value="#ls2.dcause"/></td>
			<td align="center" width="90px"><s:property value="#ls2.m"/></td>
		</tr>
		</s:iterator>
   	</table>
</div>
<div id="rightCon">
	<%@ include file="/WEB-INF/page/work/overView.jsp"%>
</div>
</body>
</html>