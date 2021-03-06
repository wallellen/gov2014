<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<style type="text/css">
		h2{font-size:12px;height:18px;text-align:right;background:#3F89EC;border-bottom:3px solid #F7F7F7;padding:5px;cursor:move;} 
		h2 span{border:0px solid #f90;padding:0 2px;} 
		#overlay-bangfu{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-bangfu{position:absolute;top:30%;left:45%;width:500px;height:490px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-bangfu .back-input{height:20px; width:140px;}
		#overlay-bangfus{position:absolute;top:0;left:0;width:100%;height:670px;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;} 
		#win-bangfus{position:absolute;top:30%;left:45%;width:500px;height:190px;background:#EAECEA;border:4px solid #F7F7F7;margin:-102px 0 0 -202px;display:none;}
		#win-bangfus .back-input{height:20px; width:140px;}
		#Tab{margin:0 auto;width:866px;}
		.Menubox{height:28px;border-bottom:1px solid #64B8E4;background:#E4F2FB;}
		.Menubox ul{list-style:none;margin:0px 2px;padding:0;position:absolute;}
		.Menubox ul li{float:left;background:#64B8E4;line-height:27px;display:block;cursor:pointer;text-align:center;color:#fff;font-weight:bold;border-top:1px solid #64B8E4;border-left:1px solid #64B8E4;border-right:1px solid #64B8E4; margin-right:2px;padding: 0 5px 0 5px;}
		.Menubox ul li.hover{background:#fff;border-bottom:1px solid #fff;color:#147AB8;}
		.Contentbox{clear:both;margin-top:0px;border-top:none;height:181px;padding-top:8px;height:100%;}
		.Contentbox ul{list-style:none;margin:7px;padding:0;}
		.Contentbox ul li{line-height:24px; width:158px; float:left; margin-right:5px;}	
		.hourf-errtip{
			width:265px; 
			height:18px;
			line-height:18px;
			color:#F00;
		}
		.Menubox ul .box_return{float:left;width:128px;background:#E0EEFB;line-height:27px;display:block;text-align:center;color:#E0EEFB;font-weight:bold;border-top:0px solid #64B8E4;border-left:0px solid #64B8E4;border-right:0px solid #64B8E4; margin-left:50px;}
	</style>
</head>
<body style="background:#E0EEFB;">
<h3 class="jiangbu-title">省级后方单位</h3>
<div id="jiangbu-data">
	<div id="Tab">
	  	<div class="Menubox">
	    	<ul>
		      	<s:iterator value="#application.vta.GetList('bfdept')" var="ls" status="sc">
					<li id="menu<s:property value="#sc.count"/>" onmouseover="setTab('menu',<s:property value="#sc.count"/>,6)"><s:property value="#ls.str"/></li>	      	
		      	</s:iterator>
		      	<li class="box_return"><input type="button" value="返回" onclick="javascript:history.go(-1)" class="button43"/></li>
	    	</ul>
	    	<script type="text/javascript">
				document.getElementById("menu1").className='hover';
			</script>
	  	</div>
	  	<div class="Contentbox"> 
	    	<div id="con_menu_1" class="hover">
	      		<ul>
				<c:forEach items="${bfList }" var="ls">
				<li><a href="javascript:popBangfuEdit('add','${ls.c0 }','','','','','','','','','1')" title="${ls.c1 }">${ls.c1 }</a></li>
				</c:forEach>
	    		</ul>
	    	</div>
	    	<div id="con_menu_2" style="display:none">
	      		<ul>
				<c:forEach items="${bf2List }" var="ls2">
				<li><a href="javascript:popBangfuEdit('add','${ls2.c0 }','','','','','','','','','2')" title="${ls2.c1 }">${ls2.c1 }</a></li>
				</c:forEach>
	    		</ul>
	    	</div>
	    	<div id="con_menu_3"style="display:none">
		      	<ul>
				<c:forEach items="${bf3List }" var="ls3">
				<li><a href="javascript:popBangfuEdit('add','${ls3.c0 }','','','','','','','','','3')" title="${ls3.c1 }">
					<c:set var="c1len" value="${fn:length(ls3.c1) }"></c:set>
		        	<c:choose>
		        		<c:when test="${c1len gt 13 }">
		        			${fn:substring(ls3.c1,0,12) }..
		        		</c:when>
		        		<c:otherwise>${ls3.c1 }</c:otherwise>
		        	</c:choose>
				</a></li>
				</c:forEach>
	    		</ul>
	    	</div>
	    	<div id="con_menu_4"style="display:none">
		      	<ul>
				<c:forEach items="${bf4List }" var="ls4">
				<li><a href="javascript:popBangfuEdit('add','${ls4.c0 }','','','','','','','','','4')" title="${ls4.c1 }">
					<c:set var="c2len" value="${fn:length(ls4.c1) }"></c:set>
		        	<c:choose>
		        		<c:when test="${c2len gt 13 }">
		        			${fn:substring(ls4.c1,0,12) }..
		        		</c:when>
		        		<c:otherwise>${ls4.c1 }</c:otherwise>
		        	</c:choose>	
				</a></li>
				</c:forEach>
	    		</ul>
	    	</div>
	    	<div id="con_menu_5"style="display:none">
		      	<ul>
				<c:forEach items="${bf5List }" var="ls5">
				<li><a href="javascript:popBangfuEdit('add','${ls5.c0 }','','','','','','','','','4')" title="${ls5.c1 }">
					<c:set var="c3len" value="${fn:length(ls5.c1) }"></c:set>
		        	<c:choose>
		        		<c:when test="${c3len gt 13 }">
		        			${fn:substring(ls5.c1,0,12) }..
		        		</c:when>
		        		<c:otherwise>${ls5.c1 }</c:otherwise>
		        	</c:choose>	
				</a></li>
				</c:forEach>
	    		</ul>
	    	</div>
	    	<div id="con_menu_6"style="display:none">
		      	<ul>
				<c:forEach items="${bf6List }" var="ls6">
				<li><a href="javascript:popBangfuEdit('add','${ls6.c0 }','','','','','','','','','4')" title="${ls6.c1 }">
					<c:set var="c4len" value="${fn:length(ls6.c1) }"></c:set>
		        	<c:choose>
		        		<c:when test="${c4len gt 13 }">
		        			${fn:substring(ls6.c1,0,12) }..
		        		</c:when>
		        		<c:otherwise>${ls6.c1 }</c:otherwise>
		        	</c:choose>
				</a></li>
				</c:forEach>
	    		</ul>
	    	</div>
	  	</div>
	</div>
</div>

<!-- add jiangbus start -->
<div id="overlay-bangfus"></div>
<div id="win-bangfus" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="bstitle"><font color="#fff">修改财政奖补到户情况</font></span></h2>
<form name="bangFusForm" action="" method="post">
<input type="hidden" id="iidx" name="bftxt" value=""/>
<div class="member-list">
	<table width="490px" cellpadding="0" cellspacing="0">
		<tr height="20px"></tr>
		<tr>
			<td align="right">省级后方单位名称:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh1s" name="bftxt" class="back-input" maxlength="20"/>
			</td>
		</tr>
	</table>
</div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subJiangBusBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-closes" type="button" value="取消" class="button4"/>
</div>
</form>
</div>
<!-- add jiangbus end -->

<!-- add jiangbu start -->
<div id="overlay-bangfu"></div>
<div id="win-bangfu" style="line-height: 30px">
<h2 style="line-height:20px; text-align:left; margin-top:2px;"><span id="btitle"><font color="#fff">修改财政奖补到户情况</font></span></h2>
<form name="bangFuForm" action="" method="post">
<input type="hidden" id="iid" name="bftxt" value=""/>
<input type="hidden" id="hh1" name="bftxt" value=""/>
<div class="member-list">
	<table width="490px" cellpadding="0" cellspacing="0">
		<tr>
			<td align="right">所在乡镇名称:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh2" name="bftxt" class="back-input" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<td align="right">挂钩村名称:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh3" name="bftxt" class="back-input" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<td align="right">到村项目资金(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh4" name="bftxt" class="back-input" maxlength="3" onblur="checkHoufMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">到村项目个数(个):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh5" name="bftxt" class="back-input" maxlength="5" onblur="checkHoufItem(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">后方单位自筹资金(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh6" name="bftxt" class="back-input" maxlength="3" onblur="checkHoufMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">协调资金(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh7" name="bftxt" class="back-input" maxlength="3" onblur="checkHoufMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">完成项目数(个):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh8" name="bftxt" class="back-input" maxlength="5" onblur="checkHoufItem(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">在建项目数(个):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh9" name="bftxt" class="back-input" maxlength="5" onblur="checkHoufItem(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">帮扶实物折价(万元):&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh10" name="bftxt" class="back-input" maxlength="3" onblur="checkHoufMoney(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">单位领导:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh11" name="bftxt" class="back-input" maxlength="3" onblur="checkHoufItem(this)"/>
			</td>
		</tr>
		<tr>
			<td align="right">中层及以下人员:&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" id="hh12" name="bftxt" class="back-input" maxlength="3" onblur="checkHoufItem(this)"/>
			</td>
		</tr>
	</table>
</div>
<div id="houfErrTip" class="hourf-errtip"></div>
<div style="margin-top:20px; margin-left:150px;">
	<input type="button" value="确定" class="button4" onclick="subJiangBuBt()"/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="y-close" type="button" value="取消" class="button4"/>
</div>
<input type="hidden" name="bftxt" value="<s:property value='rid'/>"/>
<input type="hidden" name="navbm" value="<s:property value='navbm'/>"/>
<input type="hidden" name="title" value="<s:property value='title'/>"/>
<input type="hidden" name="sdt" value="<s:property value='sdt'/>"/>
<input type="hidden" name="edt" value="<s:property value='edt'/>"/>
<input type="hidden" name="crid" value="<s:property value='crid'/>"/>
<input type="hidden" name="rflag" value="<s:property value='rflag'/>"/>
<input type="hidden" name="deptName" value="<s:property value='deptName'/>"/>
</form>
</div>
<!-- add jiangbu end -->
<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/splitpage.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/bangfu.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/changeColor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/voicet-common-1.0.js"></script>
<script type="text/javascript">
	function setTab(name,cursel,n){
		for(i=1;i<=n;i++){
			var menu=document.getElementById(name+i);
			var con=document.getElementById("con_"+name+"_"+i);
			menu.className=i==cursel?"hover":"";
			con.style.display=i==cursel?"block":"none";
		}
	}
</script>
</body>
</html>