<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/datePicker/skin/WdatePicker.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/datePicker/WdatePicker.js"></script>
</head>
<body style="background:#E0EEFB;">
<div id="leftCon">
	<ul>
    	<li><input type="button" onClick="location.href='${pageContext.request.contextPath }/system/govBrowerAction_returnList.do?viewBM=<s:property value="#session.vts.curBM"/>'" value="列表显示" class="button41"/></li>
        <li><input type="button" onClick="location.href='${pageContext.request.contextPath }/system/govBrowerAction_overView.do?page=property&viewBM=<s:property value="#session.vts.curBM"/>'" value="农户属性" class="button41"/></li>
        <li><input type="button" onClick="location.href='${pageContext.request.contextPath }/system/govBrowerAction_viewPoverty.do'" value="扶贫情况" class="button41"/></li>
        <li><input type="button" onClick="location.href='${pageContext.request.contextPath }/system/govBrowerAction_overView.do?page=dcause&viewBM=<s:property value="#session.vts.curBM"/>'" value="贫困原因" class="button41"/></li>
    </ul>
    <div class="situationWrap">
    	<form name="povertyForm" action="${pageContext.request.contextPath }/system/govBrowerAction_viewPoverty.do" method="post">
    	<div class="situ-left">
        	<span class="farmer-title">扶贫情况</span>
            <table class="tab-farmer1" cellpadding="0" cellspacing="0">
                <tr>
                    <td>分项名称</td>
                    <td>户数</td>
                    <td>元或人数</td>
                </tr>
                <s:iterator value="#session.vts.list5" var="ls5">
				<tr>
					<td align="center"><s:property value="#ls5.c0"/></td>
					<td align="center"><s:property value="#ls5.c1"/></td>
					<td align="center"><s:property value="#ls5.c2"/></td>
				</tr>
				</s:iterator>
            </table>
        </div>
        <div class="situ-right">
        	<p>查看年份</p>
            <p>
            	<s:if test="#session.vts.yearlock==1">
            	<input type="text" id="proYear" name="proYear" value="<s:property value="#session.vts.map.proYear"/>" size="8" readOnly="readOnly" class="inputyear"/>
            	</s:if>
            	<s:else>
            	<input type="text" id="proYear" name="proYear" value="<s:property value="#session.vts.map.proYear"/>" size="8" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy'})" class="Wdate inputyear"/>
            	</s:else>
            </p>
            <p><input type="submit" value="查看" class="button4"/></p>
        </div>
        </form>
    </div>
</div>
<div id="rightCon">
	<%@ include file="/WEB-INF/page/work/overView.jsp"%>
</div>
</body>
</html>