<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style-b.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript">
		function roleManage(f){
			var rc = document.getElementsByName("rolechk");
			var s='';
			for(var i=0;i<rc.length;i++){
				if(rc[i].checked){
					s+='1,';
				}else{
					s+='0,';
				}
			}
			s+=f;
			var url = "system/govConfigAction_edit.do";
			var datajson = {"rolestr":s};
			$.ajax({
		        type: "POST",
		        url: url,
		        dataType: "json",
		        data: datajson,
		        success: function(){alert("设置成功 ");},
		        error: function () {
		            alert("设置失败");
		        }
		    });
		}
	</script>
</head>
<body style="background:#E0EEFB;">
<div style="width: 867px; height: 687px; border: 0px solid red; margin-top:0px;">
	<div class="title-stats" style="margin-top:20px;">角色权限分配</div>
	<div style="margin-top:50px; margin-left:240px; width:450px; height:400px;">
		<div style="margin-left:140px;">请选择操作对象</div>
		<div style="height:20px"></div>
		<div style="margin-left:32px;">
			<input type="checkbox" name="rolechk" class="cbox-midd"/><label class="lab-midd">省管理员</label>&nbsp;&nbsp;
			<input type="checkbox" name="rolechk" class="cbox-midd"/><label class="lab-midd">市管理员</label>&nbsp;&nbsp;
			<input type="checkbox" name="rolechk" class="cbox-midd"/><label class="lab-midd">县管理员</label>&nbsp;&nbsp;
			<input type="checkbox" name="rolechk" class="cbox-midd"/><label class="lab-midd">乡管理员</label>&nbsp;&nbsp;
			<input type="checkbox" name="rolechk" class="cbox-midd"/><label class="lab-midd">村管理员</label>
		</div>
		<hr/>
		
		<div style="height:40px"></div>
		<div style="margin-left:140px;">请选择功能</div>
		<div style="height:20px;"></div>
		<div style="margin-left:90px;">
			<input type="checkbox" name="rolechk" class="cbox-midd"/><label class="lab-midd">登录</label>&nbsp;&nbsp;
			<input type="checkbox" name="rolechk" class="cbox-midd"/><label class="lab-midd">编辑录入</label>&nbsp;&nbsp;
			<input type="checkbox" name="rolechk" class="cbox-midd"/><label class="lab-midd">审核、汇总</label>
		</div>
		<hr/>
		<div style="height:20px"></div>
		<div style="margin-left:90px;">
			<input type="button" value="允许" class="button4" onclick="roleManage('1')"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="禁止" class="button4" onclick="roleManage('0')"/>
		</div>
	</div>
</div>
</body>
</html>