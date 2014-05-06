<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style-b.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/datePicker/skin/WdatePicker.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/datePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function loadLockYear(){
		var lockp = document.getElementById("lockparam").value;
		var loyea = document.getElementById("loyear");
		if(lockp!=null && lockp==1){
			loyea.checked=true;
		}else{
			loyea.checked=false;
		}
	}
</script>
</head>
<body onload="loadLockYear()" style="background:#E0EEFB;">
	<div class="" style="width:867px; height:687px; border:0px solid red; margin-top:0px;">
		<div style="margin-top:20px; margin-left:180px; width:430px; height:300px; border:0px solid red; line-height:30px;">
			<div class="title-stats">系统全局参数</div>
			<div style="height:10px;"></div>
			<form name="paramForm" action="${pageContext.request.contextPath }/system/sysGLParamAction_setParam.do" method="post" onsubmit="alert('设置成功');">
			<input type="hidden" id="lockparam" value="<s:property value="#session.vts.map.lockyear"/>"/>
			<div style="height:40px;"></div>
			<div style="width:150px; height:80px; border:0px solid red; margin-left:145px;">
			<div>
				<s:checkbox name="lockyear" cssStyle="cbox-midd" id="loyear"/>
				<label class="lab-midd">锁定工作年</label></div>
			<div><label>工作年份:</label>
				<input type="text" name="workyear" value="<s:property value="#session.vts.map.workyear"/>" size="8" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy'})" class="Wdate" style="height:16px;"/>
			</div>
			</div>
			<hr/>
			<div style="margin-top:20px; text-align:center">
				<input type="submit" value="设置" class="button4"/>
			</div>
			</form>
		</div>
	</div>
</body>
</html>