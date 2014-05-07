<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
	<script type="text/javascript">
		window.onload=function(){
			var v1 = parent.document.getElementById("navigate");
			v1.innerHTML=document.getElementById('nav-hide').innerHTML;
		}
	</script>
</head>
<body style="background:#E0EEFB;">
<div style="display:none;" id="nav-hide">
	<s:property value="#session.vts.navPath" escape="false"/>
</div>
<h3 class="jiangbu-title">省级后方单位挂钩帮扶情况&nbsp;[<s:property value="#session.vts.rbn"/>]</h3>
<p class="jiangbu-title1"><span>
	<s:if test="#session.vts.rbm.length()==2">
	<input type="button" value="后方单位管理" onclick="location.href='${pageContext.request.contextPath }/system/govBangfuAction_deptManage.do'" class="button44"/>
	</s:if>
</span></p>
<div id="jiangbu-data1">
<table class="data_list" cellpadding="0" cellspacing="0" width="100%">
   	<thead>
    <tr>
        <td width="10%">编号</td>
        <td width="20%">标题</td>
        <td width="20%">开始日期</td>
        <td width="20%">结束日期</td>
        <td width="30%">操作</td>
    </tr>
    </thead>
    <tbody id="splitpage">
    <s:iterator value="#session.vts.list" var="ls" status="sc">
    <tr style="display:none">
        <td><s:property value="#ls.c0"/></td>
        <td><s:property value="#ls.c1"/></td>
        <td><s:property value="#ls.c2"/></td>
        <td><s:property value="#ls.c3"/></td>
        <td>
        	<s:if test="#session.vts.rbm.length()==2">
        	<a href="${pageContext.request.contextPath }/system/govBangfuAction_deptTotalView.do?rid=<s:property value="#ls.c0"/>&title=<s:property value="#ls.c1"/>&sdt=<s:property value="#ls.c2"/>&edt=<s:property value="#ls.c3"/>&byunit=按单位&deptName=<s:property value='#session.vts.rbn'/>">按后方单位汇总查看</a>
        	&nbsp;&nbsp;
        	<a href="${pageContext.request.contextPath }/system/govBangfuAction_xianTotalView.do?rid=<s:property value="#ls.c0"/>&title=<s:property value="#ls.c1"/>&sdt=<s:property value="#ls.c2"/>&edt=<s:property value="#ls.c3"/>&byxian=按地区&deptName=<s:property value='#session.vts.rbn'/>">按县汇总查看</a>
        	</s:if>
        	<s:else>
        	<a href="${pageContext.request.contextPath }/system/govBangfuAction_writeReport.do?rid=<s:property value="#ls.c0"/>&title=<s:property value="#ls.c1"/>&sdt=<s:property value="#ls.c2"/>&edt=<s:property value="#ls.c3"/>&deptName=<s:property value='#session.vts.rbn'/>">查看</a>
        	</s:else>
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
</body>
</html>