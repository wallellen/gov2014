<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style-b.css" />
	<style type="text/css">
		#overlay-edit{position:absolute;top:0;left:0;width:100%;height:100%;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-edit{position:absolute;top:50%;left:50%;width:500px;height:240px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#overlay-manage{position:absolute;top:0;left:0;width:100%;height:100%;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-manage{position:absolute;top:50%;left:50%;width:500px;height:240px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#overlay-delfamily{position:absolute;top:0;left:0;width:100%;height:100%;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-delfamily{position:absolute;top:50%;left:50%;width:400px;height:160px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:2px;cursor:move;margin-top:2px;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
	</style>
</head>
<body style="background:#E0EEFB;">
<div style="display:none;" id="nav-hide">
	<s:property value="#session.vts.navPath" escape="false"/>
</div>
<div id="leftCon">
	<ul>
        <li>输入代码：<input type="text" id="dirBM" value="<s:property value="#session.vts.bmhm"/>" maxlength="18" onkeyup="checkIntInput(this)" onkeydown="javascript:if(event.keyCode==13) directAccess();" class="input-goto"/>&nbsp;<input type="button" id="btn-go" value="直接进入" onclick="directAccess();return false;" class="button4"/></li>
        <li>
        	<s:if test="#session.vts.isedit==1">
			<s:if test="#session.vts.curBM.length()==12">
        	<input type="button" onclick="addUserInfo()" value="添加农户" class="button41"/>
        	</s:if>
			</s:if>
        </li>
    </ul>
    <div class="content">
    	<form name="Form1" action="" method="post">
    		<input type="hidden" value="" name="viewBM" id="viewBM"/>
   		</form>
    	<table class="data_list" cellpadding="0" cellspacing="0">
        	<thead>
            	<tr class="tabtr1">
                <s:if test="#session.vts.curBM.length()<=9">
					<td height="20px" width="12%">地区编码</td>
					<td width="15%">地区名称</td>
					<td width="8%">农户总数</td>
					<td width="8%">人口总数</td>
					<td width="8%">低收入户</td>
					<td width="8%">扶贫户</td>
					<td width="8%">低保户</td>
					<td width="8%">五保户</td>
					<td width="8%">审查通过</td>
					<td width="14%" class="tabtd1">操作</td>
				</s:if>
				<s:else>
					<td height="20px" width="8%">农户编码</td>
					<td width="6%">组名</td>
					<td width="7%">姓名</td>
					<td width="4%">人口</td>
					<td width="4%">劳力</td>
					<td width="4%">耕地</td>
					<td width="4%">住房</td>
					<td width="10%">属性</td>
					<td width="10%">贫困原因</td>
					<td width="4%">审查</td>
					<td width="20%" class="tabtd1">操作</td>
				</s:else>
                </tr>
            </thead>
            <tbody id="splitpage">
            	<c:forEach items="${sessionScope.vts.list }" var="bo">
				<tr style="display:none;">
					<s:if test="#session.vts.curBM.length()<=9">
					<td height="20px" align="left">&nbsp;${bo.bm }</td>
					<td align="left" title="${bo.oname }">
						<c:choose>
							<c:when test="${fn:length(bo.oname)>6}">${fn:substring(bo.oname,0,6) }..</c:when>
							<c:otherwise>${bo.oname }</c:otherwise>
						</c:choose>
					</td>
					<td align="right">${bo.htn }&nbsp;</td>
					<td align="right">${bo.ptn }&nbsp;</td>
					<td align="right">${bo.m }&nbsp;</td>
					<td align="right">${bo.v1 }&nbsp;</td>
					<td align="right">${bo.v2 }&nbsp;</td>
					<td align="right">${bo.v3 }&nbsp;</td>
					<td align="right">${bo.cknum }&nbsp;</td>
					<td class="tabtd1">
						<a href="#" onclick="viewBMInfo('${bo.bm}')">进入</a>
						<s:if test="#session.vts.isedit==1">
						<a href="#" onclick="popEditName('${bo.oname }','${bo.htn }', '${bo.ptn }', '${bo.bm }')">修改</a>
						</s:if>
						<!-- 20140815添加 -->
						<s:if test="#session.vts.rbm.length()==6 && #session.vts.curBM.length()==9">
							<a href="${pageContext.request.contextPath }/system/govBrowerAction_checkCun.do?cunbm=${bo.bm }&cunname=${bo.oname }">审查</a>
						</s:if>
						<s:if test="#session.vts.roleID==1">
						<a href="#" onclick="popManager('${bo.bm }')">管理</a>
						</s:if>
					</td>
					</s:if>
					<s:else>
						<td align="left" height="20px">&nbsp;${bo.hm }</td>
						<td align="left" title="${bo.zhu }">
							<c:choose>
								<c:when test="${fn:length(bo.zhu)>3}">${fn:substring(bo.zhu,0,3) }..</c:when>
								<c:otherwise>${bo.zhu }</c:otherwise>
							</c:choose>
						</td>
						<td align="left" title="${bo.hname }">
							<c:choose>
								<c:when test="${fn:length(bo.hname)>3}">${fn:substring(bo.hname,0,3) }..</c:when>
								<c:otherwise>${bo.hname }</c:otherwise>
							</c:choose>
						</td>
						<td align="right">${bo.population }&nbsp;</td>
						<td align="right">${bo.labornum }&nbsp;</td>
						<td align="right">${bo.fields }&nbsp;</td>
						<td align="right">${bo.house }&nbsp;</td>
						<td align="left">&nbsp;${bo.property }</td>
						<td align="left">&nbsp;${bo.dcause }</td>
						<td align="center">
							<c:if test="${bo.ischeck eq 1}">
							√
							</c:if>
							<c:if test="${bo.ischeck eq 2}">
							乂
							</c:if>
						</td>
						<td class="tabtd1">
							<a href="${pageContext.request.contextPath }/system/govBrowerAction_viewReportFamily.do?viewBM=${bo.hm }">查看</a>
			 				<a id="printBt" href="${pageContext.request.contextPath }/system/govBrowerAction_printFamily.do?viewBM=${bo.hm }" target="printFrame">打印</a>
			 				<s:if test="#session.vts.isedit==1">
							<a href="${pageContext.request.contextPath }/system/govBrowerAction_detail.do?viewBM=${bo.hm }&rtf=home">编辑</a>
							<s:if test="#session.vts.rbm.length()==2">
							<a href="javascript:popDelFamily('${bo.hm }','${bo.hname }')">删除</a>
							</s:if>
			 				</s:if>
			 				<a href="${pageContext.request.contextPath }/system/govBrowerAction_checkFamily.do?hbm=${bo.hm}">审查</a>
						</td>
					</s:else>
				</tr>
				</c:forEach>
            </tbody>
        </table>
    </div>
    <!-- js splitpage -->
    <div class="split-page">
    	<input type="hidden" id="pageRows" value="27"/>
		<div id="changePage"></div>
    </div>
</div>
<div id="rightCon">
	<%@ include file="/WEB-INF/page/work/overView.jsp"%>
</div>
<!-- update name -->
<div id="overlay-edit"></div>
<div id="win-edit" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left"><span><font color="#fff">修改地区名称</font></span></h2>
<form name="areaForm" action="" method="post">
<input type="hidden" value="" name="insBm" id="insBm"/>
<div class="edit-list">
	<table width="450px" cellpadding="0" cellspacing="0">
		<tr height="20px">
			<td width="30%" align="right">原地区名称:&nbsp;&nbsp;</td>
			<td width="35%" align="left"><label id="oldArea"></label></td>
			<td width="35%" align="left"></td>
		</tr>
		<tr height="20px">
			<td width="30%" align="right">新地区名称:&nbsp;&nbsp;</td>
			<td width="35%" align="left"><input id="insName" name="insName" class="inpasstxt" type="text" maxlength="20" onblur="checkinsName()"/></td>
			<td width="35%" align="left"><span id="newAreaTips" class="ptips"></span></td>
		</tr>
		<s:if test="#session.vts.curBM.length()==9">
		<tr height="20px">
			<td width="30%" align="right">农户总数:&nbsp;&nbsp;</td>
			<td width="35%" align="left"><input id="insHtn" name="insHtn" class="inpasstxt" type="text" maxlength="8" onblur="checkinsHtn()"/></td>
			<td width="35%" align="left"><span id="newHtnTips" class="ptips"></span></td>
		</tr>
		<tr height="20px">
			<td width="30%" align="right">人口总数:&nbsp;&nbsp;</td>
			<td width="35%" align="left"><input id="insPtn" name="insPtn" class="inpasstxt" type="text" maxlength="8" onblur="checkinsPtn()"/></td>
			<td width="35%" align="left"><span id="newPtnTips" class="ptips"></span></td>
		</tr>
		</s:if>
	</table>
</div>
<div style="margin-top:5px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subAreaBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="close" type="button" value="取消" class="button4"/>
</div>
</form>
</div> 
<!-- update name end -->
<!-- manage -->
<div id="overlay-manage"></div>
<div id="win-manage" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left"><span><font color="#fff">管理</font></span></h2>
<form name="manageForm" action="" method="post">
<input type="hidden" id="operCode"/>
<div class="manage-list">
	<div style="margin-left:120px;"><input type="button" value="密码初始化(123456)" onclick="initPassword()" class="button8" style="background:url('${pageContext.request.contextPath }/images/vt_rec_bt8.png');"/></div>
	<div style="height:5px"></div>
	<hr/>
	<div style="margin-left:150px;"><label>请选择功能</label></div>
	<div style="margin-left:40px;">
		<input type="checkbox" id="isLogon" class="cbox-midd"/><label class="lab-midd">登录</label>&nbsp;&nbsp;
		<input type="checkbox" id="isEdit" class="cbox-midd"/><label class="lab-midd">编辑录入</label>&nbsp;&nbsp;
		<input type="checkbox" id="isAudit" class="cbox-midd"/><label class="lab-midd">审核、汇总</label>&nbsp;&nbsp;
	</div>
	<hr/>
	<div style="height:5px"></div>
</div>
<div style="margin-top:5px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subManageBt('0')"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="close-manage" type="button" value="取消" class="button4"/>
</div>
</form>
</div> 
<!-- manage end -->

<!-- delete family start  -->
<div id="overlay-delfamily"></div>
<div id="win-delfamily" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left"><span><font color="#fff">删除农户</font></span></h2>
<form name="delFamilyForm" action="" method="post">
<input type="hidden" id="delhm" name="hbm"/>
<div class="manage-list22">
	<table width="350px" cellpadding="0" cellspacing="0">
		<tr height="20px">
			<td width="45%" align="right">农户姓名:&nbsp;&nbsp;</td>
			<td width="55%" align="left"><label id="delname"></label></td>
		</tr>
		<tr height="20px">
			<td align="right">删除原因:&nbsp;&nbsp;</td>
			<td align="left">
			<s:select name="cause" list="#application.vta.GetList('delfamcause')" listKey="id" listValue="str" cssClass="sele"></s:select>	
			</td>
		</tr>
	</table>
</div>
<div style="margin-top:5px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subDelFamilyBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="close-delfamily" type="button" value="取消" class="button4"/>
</div>
</form>
</div> 
<!-- delete family end -->

<s:if test="#session.vts.hasStack()">
	<s:property value="#session.vts.popAllList()"/>
</s:if>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/browerview.js"></script>	
<script type="text/javascript">
	window.onload=function(){
		var v1 = parent.document.getElementById("navigate");
		v1.innerHTML=document.getElementById('nav-hide').innerHTML;
	}
</script>
</body>
</html>