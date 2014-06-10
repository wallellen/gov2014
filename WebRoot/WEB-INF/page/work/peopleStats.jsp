<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style-b.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
	<script type="text/javascript">
		//初始化统计类别 
		function initPeople(){
			var s = document.getElementById("aids").value-1;
			document.getElementsByName("aid")[s].checked=true;
			var ids = document.getElementsByName("aid")[s];
			onChange();
		}
		//radio改变事件 
		function onChange(){
			var radio =document.getElementsByName("aid");
			for( var i=0; i<radio.length; i++){
				if(radio[i].checked){
					switch(i){
					case 0:
						checkParam(0);
						break;
					case 1:
						checkParam(0);
						break;
					case 2:
						checkParam(0);
						break;
					case 3:
						checkParam(0);
						break;
					case 4:
						checkParam(0);
						break;
					case 5:
						checkParam(0);
						break;
					case 6:
						checkParam(0);
						break;
					case 7:
						checkParam(1);
						break;
					case 8:
						checkParam(1);
						break;
					}
				}
			}
		}
		function checkParam(x) {
			if(x!=1){
				document.getElementById("peocon1").style.display='none';
			}else{
				document.getElementById("peocon1").style.display='';
			}
		}
		function checkTjstr(){
			var tj = document.getElementById("tjstr1").value;
			var patrn=/^(\d+,)*\d+$/; 
			if (!patrn.exec(tj)){ 
				alert("格式不正确,不能连接输入逗号,且不能以逗号开头或结尾");
				return false;
			}
			return true; 
		}
	</script>
</head>
<body onload="initPeople()" style="background:#E0EEFB;">
<div style="float:left">
<!-- 统计条件 -->
<div style="height:154px; border:0px solid blue; line-height:18px;">
<form name="farmerForm" action="${pageContext.request.contextPath }/system/govPeopleStatsAction_home.do" method="post" onsubmit="return checkTjstr()">
<input type="hidden" id="aids" value="<s:property value="#session.vts.map.aidPeople"/>"/>
<div style="height:140px; width:666px; margin-top:10px; border:0px solid red;">
	<div style="width:640px;" class="title-stats">统计低收入人口数&nbsp;[<s:property value="#session.vts.map.name"/>]</div>
	<fieldset style="border:1px solid #3B9FFF;">
	<legend>统计类别</legend>
	<div style="height:24px;">
		<div style="float:left; width:120px;">
			<input type="radio" name="aid" value="1" onclick="onChange()" class="lab-rad"/><label class="lab-rad">性别</label>
		</div>
		<div style="float:left; width:120px;">
			<input type="radio" name="aid" value="2" onclick="onChange()" class="lab-rad"/><label class="lab-rad">在校生</label>
		</div>
		<div style="float:left; width:120px;">
			<input type="radio" name="aid" value="3" onclick="onChange()" class="lab-rad"/><label class="lab-rad">文化程度</label>
		</div>
		<div style="float:left; width:140px;">
			<input type="radio" name="aid" value="4" onclick="onChange()" class="lab-rad"/><label class="lab-rad">身体状况</label>
		</div>
		<div style="float:left; width:120px;">
			<input type="radio" name="aid" value="5" onclick="onChange()" class="lab-rad"/><label class="lab-rad">劳动力状况</label>
		</div>
	</div>
	<div style="height:24px;">
		<div style="float:left; width:120px;">
			<input type="radio" name="aid" value="6" onclick="onChange()" class="lab-rad"/><label class="lab-rad">打工状况</label>
		</div>
		<div style="float:left; width:120px;">
			<input type="radio" name="aid" value="7" onclick="onChange()" class="lab-rad"/><label class="lab-rad">低保人口</label>
		</div>
		<div style="float:left; width:120px;">
			<input type="radio" name="aid" id="aid8" value="8" onclick="onChange()" class="lab-rad"/><label class="lab-rad">年龄</label>
		</div>
		<div style="float:left; width:140px;">
			<input type="radio" name="aid" id="aid9" value="9" onclick="onChange()" class="lab-rad"/><label class="lab-rad">领取低保金、残疾金</label>
		</div>
	</div>
	</fieldset>
	<div style="height:24px; margin-top:5px;">
		<div style="float:left; width:160px;">&nbsp;</div>
		<div style="float:left; width:380px; padding-left:10px; padding-top:5px; border:0px solid red">
			<div id="peocon1">
			<label id="condition">分组条件设置</label>
			<input type="text" id="tjstr1" name="tjstr" class="inptxt" value="<s:property value="#session.vts.map.tjstrPeople"/>" onfocus="this.className='input_on'" onblur="this.className='input_off'"/>
			<p>分组条件设置的编辑格式：用半角的逗号分隔，如：10,100,1000</p>
			</div>
		</div>
		<div style="float:right; width:80px; padding-top:5px;">
			<input type="submit" value="立即统计" class="button4"/>
		</div>
	</div>
</div>
</form>
</div>
<s:if test="#session.vts.list5!=null && #session.vts.list5.size()>0">
<div class="table-c" style="width:666px; height:484px; line-height:20px; border:0px solid red;">
<table class="data_list" width="100%" bordercolor="gray" border="0" cellpadding="0" cellspacing="0">
	<thead>
	<tr height="40px" style="font-weight: bold; color: #2284E1;" background="${pageContext.request.contextPath }/images/tablehead2.jpg">
		<td width="20%">地区名称</td>
		<td width="10%"><s:property value="#session.vts.map.c2"/></td>
		<td width="10%"><s:property value="#session.vts.map.c3"/></td>
		<td width="10%"><s:property value="#session.vts.map.c4"/></td>
		<td width="10%"><s:property value="#session.vts.map.c5"/></td>
		<td width="10%"><s:property value="#session.vts.map.c6"/></td>
		<td width="10%"><s:property value="#session.vts.map.c7"/></td>
		<td width="10%"><s:property value="#session.vts.map.c8"/></td>
		<td width="10%"><s:property value="#session.vts.map.c9"/></td>
	</tr>
	</thead>
	<tbody id="splitpage">
	<s:iterator value="#session.vts.list5" var="ls5">
	<tr style="display:none;">
		<td><s:property value="#ls5.c0"/></td>
		<td><s:property value="#ls5.c2"/></td>
		<td><s:property value="#ls5.c3"/></td>
		<td><s:property value="#ls5.c4"/></td>
		<td><s:property value="#ls5.c5"/></td>
		<td><s:property value="#ls5.c6"/></td>
		<td><s:property value="#ls5.c7"/></td>
		<td><s:property value="#ls5.c8"/></td>
		<td><s:property value="#ls5.c9"/></td>
	</tr>
	</s:iterator>
	</tbody>
</table>
</div>
<!-- js分页div -->
<div class="split-page">
	<!-- 每页行数 -->
	<input type="hidden" id="pageRows" value="21"/>
	<div id="changePage"></div>
</div>
</s:if>
</div>

<div id="rightCon">
<%@ include file="/WEB-INF/page/work/overView.jsp"%> 
</div>
</body>
</html>