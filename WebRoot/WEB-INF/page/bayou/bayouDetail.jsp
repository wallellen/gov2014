<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/global_cn.css?v=2" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style-b.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/script/jquery-1.5.1.min.js"></script>
	<script type="text/javascript">
		function printBayouInfo(areabm,rflag){
			document.getElementById("printBtn").href='bayou_printBayou.do?areabm='+areabm;
		}
		function returnBayouList(rflag){
			document.getElementById("returnBtn").href="javascript:history.go(-"+rflag+");";
		}
	</script>
	<style type="text/css">
		.bottomborder{border-bottom:1px solid #000;}
	</style>
</head>
<body style="background:#E0EEFB;">
<div id="leftCon1">
	<form name="form1" action="${pageContext.request.contextPath }/system/bayou_saveBayou.do" method="post">
	<input type="hidden" name="areabm" value="${areabm }"/>
	<input type="hidden" name="cunname" value="${cunname }"/>
	<input type="hidden" name="bytxt" value="${areabm }"/>
	<input type="hidden" name="bytxt" value="2014"/>
	<div class="view-family-report">
    <h1>经济薄弱村新“八有”考核表</h1>
    <p class="view-print">
    	<a onclick="saveBayou()" style="cursor:pointer;">保存</a>
	    <a id="printBtn" onclick="printBayouInfo('${areabm }','${rflag }')" target="printFrame" style="cursor:pointer;">打印</a>
		<a id="returnBtn" onclick="returnBayouList('${rflag }')" style="cursor:pointer;">返回</a>
    </p>
    <div id="view-bayou-tit">
       	<p class="view-sp1">
       		<span><u><s:property value="#session.vts.map.shiname"/></u>&nbsp;市</span>
           	<span><u><s:property value="#session.vts.map.shiname"/></u>&nbsp;县(市、区)</span>
            <span><u><s:property value="#session.vts.map.xianname"/></u>&nbsp;乡(镇)</span>
            <span><u><s:property value="#session.vts.map.cunname"/></u>&nbsp;村</span>
		</p>
		<p class="view-sp2">
			<span>201<u>&nbsp;4&nbsp;</u>年度</span>
            <span>片区村<input type="text" id="pianqu" name="bytxt" value="${byMap.pq }" class="input_w20" maxlength="1" tabindex="9"/>(1、是&nbsp;&nbsp;2、否)</span>
        </p>
        <p class="view-sp2">
			<span>挂钩帮扶单位：<input type="text" name="bytxt" value="${byMap.fu }" class="input_w75" tabindex="10"/></span>
            <span>驻村人：<input type="text" name="bytxt" value="${byMap.fr }" class="input_w75" tabindex="11"/></span>
            <span>村支书：<input type="text" name="bytxt" value="${byMap.cm }" class="input_w75" tabindex="12"/></span>
            <span>电话：<input type="text" id="telnum" name="bytxt" value="${byMap.ct }" class="input_w75" tabindex="13"/></span>
        </p>
        <p class="view-sp2">
			<span>上年度村集体经济收入：<input type="text" id="jtjj" name="bytxt" value="${byMap.sr }" class="input_w60" tabindex="20"/>万元</span>
            <span>主要来源：<input type="text" name="bytxt" value="${byMap.ly }" class="input_w75" tabindex="21"/></span>
        </p>
    </div>
    
	<table width="100%" cellpadding="0" cellspacing="0" style="text-align:left">
			<tr>
				<td>新“八有”</td>		
				<td>指标</td>
				<td>考评内容</td>
				<td>分值</td>
				<td>得分</td>
			</tr>
			<tr>
				<td>有群众拥护<br/>的“双强”<br/>班子</td>
				<td>党员和村民代表<br/>对村“两委”班<br/>子工作的满意度</td>
				<td>“双强”指村“两委”班子思想政治素质强、科学发展能<br/>力强。参加测评的党员和村民代表满意度票数与总票数<br/>之比，80%以上得满分，每少5%减1分，低于50%不<br/>得分</td>
				<td>10</td>
				<td><input type="text" id="defen1" name="bytxt" value="${byMap.f1 }" class="input_w20" maxlength="2" tabindex="30"/></td>
			</tr>
			<tr>
				<td>有科学合理<br/>的发展规划</td>
				<td>村级发屏和建设<br/>规划达标率</td>
				<td>有经县、乡政府确认的发展规划或村庄建设规<br/>划，按规划要求执行得满分，执行不到位的酌情减分，<br/>没有规划不得分</td>
				<td>10</td>
				<td><input type="text" id="defen2" name="bytxt" value="${byMap.f2 }" class="input_w20" maxlength="2" tabindex="31"/></td>
			</tr>
			<tr>
				<td>有高产高效<br/>的农业设施</td>
				<td>设施农业面积比<br/>重</td>
				<td>村有温室、各类棚架、喷滴灌、遮阳网、防虫网等设<br/>施进行种植的实际建设面积占全村耕地面积的比重。<br/>10%以上得满分，每少1%扣1分</td>
				<td>10</td>
				<td><input type="text" id="defen3" name="bytxt" value="${byMap.f3 }" class="input_w20" maxlength="2" tabindex="32"/></td>
			</tr>
			<tr>
				<td>有特色鲜明<br/>的主导产业</td>
				<td>特色产业带动低<br/>收入农户比重</td>
				<td>特色产业带动低收入农户数与村低收入农户总数之<br/>比，50%以上得满分，每减少5%减1分</td>
				<td>10</td>
				<td><input type="text" id="defen4" name="bytxt" value="${byMap.f4 }" class="input_w20" maxlength="2" tabindex="33"/></td>
			</tr>
			<tr>
				<td rowspan="2">有持续稳定<br/>的集体收入</td>
				<td>集体经营性收入</td>
				<td>2015年所有经济薄弱村的集体经营性收入要达到15<br/>万元以上。各年度考核时每少1万元扣2分</td>
				<td rowspan="2">30</td>
				<td rowspan="2"><input type="text" id="defen5" name="bytxt" value="${byMap.f5 }" class="input_w20" maxlength="2" tabindex="48"/></td>
			</tr>
			<tr>
				<td>已入账收益<input type="text" id="rzsy" name="bytxt" value="${byMap.m1 }" class="input_w45" maxlength="12" tabindex="40"/>万<br/>元；已签协议还未<br/>
					实现收益<input type="text" id="sxsy" name="bytxt" value="${byMap.m2 }" class="input_w45" maxlength="12" tabindex="41"/>万<br/>元
				</td>
				<td>
					实施项目数<input type="text" id="ssxm" name="bytxt" value="${byMap.pi }" class="input_w20" maxlength="12" tabindex="42"/>个。项目资金来源：<br/>
					1.省财政资金<input type="text" id="xmzj1" name="bytxt" value="${byMap.v1 }" class="input_w45" maxlength="12" tabindex="43"/>万元 
					4.帮扶单位资金<input type="text" id="xmzj4" name="bytxt" value="${byMap.v4 }" class="input_w45" maxlength="12" tabindex="46"/>万元 <br/>
					2.市财政资金<input type="text" id="xmzj2" name="bytxt" value="${byMap.v2 }" class="input_w45" maxlength="12" tabindex="44"/>万元
					5.其他资金<input type="text" id="xmzj5" name="bytxt" value="${byMap.v5 }" class="input_w45" maxlength="12" tabindex="47"/>万元 <br/>
					3.县财政资金<input type="text" id="xmzj3" name="bytxt" value="${byMap.v3 }" class="input_w45" maxlength="12" tabindex="45"/>万元 
					合计<u>&nbsp;<label id="xmzjt">${byMap.mt }</label>&nbsp;</u>万元<br/>
				</td>
			</tr>
			<tr>
				<td>有先进适用<br/>的信息网络</td>
				<td>因特网入户率</td>
				<td>掼通过宽带、有线电视、电话拨号、移动上网（含手<br/>机上网），能够接入因特网的农户占本村农户总数的<br/>比重。70%以上得满分，每少10%扣2分</td>
				<td>10</td>
				<td><input type="text" id="defen6" name="bytxt" value="${byMap.f6 }" class="input_w20" maxlength="2" tabindex="50"/></td>
			</tr>
			<tr>
				<td>有健康向上<br/>的文明新风</td>
				<td>村规民约制定率</td>
				<td>民制定并公布醒目，没有不得分</td>
				<td>10</td>
				<td><input type="text" id="defen7" name="bytxt" value="${byMap.f7 }" class="input_w20" maxlength="2" tabindex="51"/></td>
			</tr>
			<tr>
				<td>有村容整洁<br/>的居住环境</td>
				<td>垃圾有人清运</td>
				<td>村内垃圾池干净整洁并有专人负责清运得满分</td>
				<td>10</td>
				<td><input type="text" id="defen8" name="bytxt" value="${byMap.f8 }" class="input_w20" maxlength="2" tabindex="52"/></td>
			</tr>
			<tr>
				<td class="bottomborder">合计</td>
				<td class="bottomborder"></td>
				<td class="bottomborder"></td>
				<td class="bottomborder"></td>
				<td class="bottomborder"><label id="defent">${byMap.ft }</label></td>
			</tr>
	    </table>
	    <div style="height:26px; line-height:26px; color:#F00; text-align:left;" id="errTip1"></div>
    </div>
    </form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath }/script/bayou.js?v=8"></script>
</body>
</html>