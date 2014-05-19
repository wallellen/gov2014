<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<script type="text/javascript">
	function saveReturnFamily(){
		document.personForm.action="govBrowerAction_saveFamilyEx.do";
		document.personForm.submit();
	}
</script>
<s:if test="%{#session.vts.map.hname!=''}">
<h3 id="base-title">[<s:property value="#session.vts.curHM"/>&nbsp;<s:property value="#session.vts.map.hname"/>]家庭基本信息</h3>
</s:if>
<s:else>
<h3 id="base-title">家庭基本信息</h3>
</s:else>
<form name="personForm" action="${pageContext.request.contextPath }/system/govBrowerAction_saveFamily.do" method="post">
<div id="base-info">
	<ul class="info1">
		<li>组名：<input type="text" name="zhu" style="width:55px; height:20px; line-height:20px; border:1px solid #D8D8D8;" value="<s:property value="#session.vts.map.zhu"/>" maxlength="10" onfocus="this.className='input_onzhu'" onblur="this.className='input_offzhu'"/></li>
		<li>姓名：<input type="text" name="hname" value="<s:property value="#session.vts.map.hname"/>" maxlength="10" onfocus="this.className='input_on'" onblur="this.className='input_off'"/></li>
        <li>身份证号码：<input type="text" name="idcno" value="<s:property value="#session.vts.map.idcno"/>" maxlength="18" onfocus="this.className='input_on'" onblur="this.className='input_off'" onkeyup="checkCardNo(this)"/></li>
        <li>联系电话：<input type="text" name="htel" value="<s:property value="#session.vts.map.telnum"/>" maxlength="15" onfocus="this.className='input_on'" onblur="this.className='input_off'" onkeyup="checkIntInput(this)"/></li>
	</ul>
    <ul class="info2">
     	<li>承包耕地面积(亩)：<input type="text" name="fields" value="<s:property value="#session.vts.map.fields"/>" maxlength="10" onfocus="this.className='input_on'" onblur="this.className='input_off'" onkeyup="checkFloatInput(this)"/></li>
        <li>住房面积(m<sup>2</sup>)：<input type="text" name="house" value="<s:property value="#session.vts.map.house"/>" maxlength="5" onfocus="this.className='input_on'" onblur="this.className='input_off'" onkeyup="checkFloatInput(this)"/></li>
        <li>农户属性：<s:select name="property" list="#application.vta.GetList('family')" listKey="id" listValue="str" value="%{#session.vts.map.property}" cssClass="sele"></s:select></li>
		<li>贫困原因：<s:select name="dcause" list="#application.vta.GetList('dcause')" listKey="id" listValue="str" value="%{#session.vts.map.dcause}" cssClass="sele"></s:select></li>
	</ul>
</div>
<div id="base-info2">
    <ul class="info3">
        <li class="input1">挂钩帮扶人：<input type="text" name="frname" value="<s:property value="#session.vts.map.frname"/>" maxlength="10" onfocus="this.className='input_on'" onblur="this.className='input_off'"/></li>
        <li class="input1">单位职务：<input type="text" name="frwork" value="<s:property value="#session.vts.map.frwork"/>" maxlength="10" onfocus="this.className='input_on'" onblur="this.className='input_off'"/></li>
        <li class="input1">帮扶人联系电话：<input type="text" name="frtel" value="<s:property value="#session.vts.map.frtel"/>" maxlength="15" onfocus="this.className='input_on'" onblur="this.className='input_off'" onkeyup="checkIntInput(this)"/></li>
        <li>
        	<s:if test="#session.vts.isedit==1">
			<input type="submit" value="保存" class="button4"/>
			</s:if>
			<s:if test="%{#session.vts.map.hname!=''}">
			<input type="button" value="保存返回" class="button4" onclick="saveReturnFamily()"/>
			</s:if>
			<input type="button" value="返回" class="button4" onclick="location.href='${pageContext.request.contextPath }/system/govBrowerAction_backup.do?viewBM=<s:property value="#session.vts.curBM"/>'"/>
        </li>
    </ul>
</div>
</form>