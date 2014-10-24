<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style-b.css" />
</head>
<body style="background:#E0EEFB;">
<div id="dbCon">
	<div class="db-info">
		<p>当前共有  <s:property value="#application.numSessions==null || #application.numSessions<0?1:#application.numSessions"/> 人在线 </p>
    	<p>数据库版本：${sessionScope.vts.map.serverinfo }</p>
        <p>数据库名称：${sessionScope.vts.map.databasename }</p>
        <p>数据库文件列表：</p>
        <table cellpadding="0" cellspacing="0">
        	<tr class="tabtr1">
            	<td>逻辑名</td>
                <td>磁盘文件名</td>
                <td>大小</td>
            </tr>
            <c:forEach items="${dbList }" var="datafile">
			<tr align="center" style="font-size: 12px; height: 20px">
				<td align="left">&nbsp;${datafile.name }</td>
				<td align="left">&nbsp;${datafile.filename }</td>
				<td align="center">${datafile.sizex }</td>
			</tr>
			</c:forEach>
        </table>
        <p>上次清理时间：${sessionScope.vts.map.lasttrunkdt }&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onclick="emptylog()" value="清空日志" class="button4"/></p>
        <p>备份路径(数据库服务器所在的本地路径)：</p>
        <p><input type="text" id="defbackupfilename" name="defbackupfilename" value="${sessionScope.vts.map.defbackupfilename }" class="inptxt3" onfocus="this.className='input_on3'" onblur="this.className='input_off3'"/></p>
        <p>上次备份时间：${sessionScope.vts.map.lastbackupdt }&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onclick="backup('${sessionScope.vts.map.defbackupfilename }')" value="立即备份" class="button4"/></p>
        <ul class="db-index">
        	<li><input type="radio" name="dbindex" value="0" checked class="lab-rad"/><label class="lab-midd">清空索引</label></li>
			<li><input type="radio" name="dbindex" value="1" class="lab-rad"/><label class="lab-midd">创建索引</label></li>
			<li><input type="radio" name="dbindex" value="2" class="lab-rad"/><label class="lab-midd">重建索引</label></li>
			<li><input type="button" value="执行" onclick="indexManage()" class="button4"/></li>
        </ul>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/dbconfig.js"></script>	
</body>
</html>