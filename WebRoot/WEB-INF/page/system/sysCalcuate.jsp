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
		function checkCal(){
			var recal = document.getElementById("recal").value;
			var radio = document.getElementsByName("cal");
			for(var i=0; i<radio.length; i++){
				if(recal==i){
					radio[i].checked=true;
				}
			}
		}
		function checkYearParam(){
			var calYear = document.getElementById("calYear");
			var param = document.getElementById("param").value;
			if(calYear.checked==true){
				if(param==""){
					alert("年份不能为空 ");
					return false;
				}else{
					return true;
				}
			}
		}
	</script>
</head>
<body style="background:#E0EEFB;" onload="checkCal()">
	<div style="width:867px; height:687px; border:0px solid red; margin-top:0px;">
		<div style="margin-top:40px; margin-left:180px; width:400px; height:300px; border:0px solid red; line-height:30px;">
			<div class="title-stats">优化计算</div>
			<form name="paramForm" action="${pageContext.request.contextPath }/system/sysReCalcAction_recal.do" method="post" onsubmit="return checkYearParam()">
			<input type="hidden" id="recal" value="<s:property value="cal"/>"/>
			<div style="height:40px;"></div>
			<div style="width:300px; height:180px; border:0px solid red; margin-left:125px;">
				<div>
					<input type="radio" name="cal" value="0" class="lab-rad"/><label class="lab-midd">重算家庭人口及劳动力</label>
				<div>
					<input type="radio" name="cal" id="calYear" value="1" class="lab-rad"/><label class="lab-midd">重算年总收入及人均收入</label>&nbsp;&nbsp;
					年份:<input type="text" name="param" id="param" value="<s:property value="#session.vts.map.param"/>" size="8" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy'})" class="Wdate" style="height:16px;"/>
				</div>
				<div>
					<input type="radio" name="cal" value="2" class="lab-rad"/><label class="lab-midd">整理部门级别</label>
				</div>
			</div>
			<div style="height:30px;"></div>
			<hr/>
			<div style="margin-top:20px; margin-left:10px; text-align:center">
				<input type="submit" value="执行" class="button4"/>
			</div>
			</form>
		</div>
	</div>
</body>
</html>