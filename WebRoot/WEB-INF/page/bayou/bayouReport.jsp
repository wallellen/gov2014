<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/global_cn.css?v=2" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/style/style-b.css" />
	<script type="text/javascript">
		function findPrint3(){
			window.setTimeout(printView, 1);
		}
		function printView(){
			// 获得打印窗口焦点
			parent.printFrame.focus();
			window.print();
			return false;
		}
	</script>
	<style type="text/css">
		.bottomborder{border-bottom:1px solid #000;}
	</style>
</head>
<body onload="findPrint3()" style="background:#E0EEFB;">
<div id="leftCon1">
	<div class="view-family-report">
    <h1>经济薄弱村新“八有”考核表</h1>
    <p class="view-print"></p>
    <div id="view-bayou-tit">
       	<p class="view-sp1">
       		<span><u><s:property value="#session.vts.map.shiname"/></u>&nbsp;市</span>
           	<span><u><s:property value="#session.vts.map.shiname"/></u>&nbsp;县(市、区)</span>
            <span><u><s:property value="#session.vts.map.xianname"/></u>&nbsp;乡(镇)</span>
            <span><u><s:property value="#session.vts.map.cunname"/></u>&nbsp;村</span>
		</p>
		<p class="view-sp2">
			<span>201<u>&nbsp;4&nbsp;</u>年度</span>
            <span>片区村<u>&nbsp;1&nbsp;</u>(1、是&nbsp;&nbsp;2、否)</span>
        </p>
        <p class="view-sp2">
			<span>挂钩帮扶单位：<u>&nbsp;${byMap.fu }&nbsp;</u></span>
            <span>驻村人：<u>&nbsp;${byMap.fr }&nbsp;</u></span>
            <span>村支书：<u>&nbsp;${byMap.cm }&nbsp;</u></span>
            <span>电话：<u>&nbsp;${byMap.ct }&nbsp;</u></span>
        </p>
        <p class="view-sp2">
			<span>村集体经济收入：<u>&nbsp;${byMap.sr }&nbsp;</u>万元</span>
            <span>主要来源：<u>&nbsp;${byMap.ly }&nbsp;</u></span>
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
				<td>${byMap.f1 }</td>
			</tr>
			<tr>
				<td>有科学合理<br/>的发展规划</td>
				<td>村级发屏和建设<br/>规划达标率</td>
				<td>有经县、乡政府确认的发展规划或村庄建设规<br/>划，按规划要求执行得满分，执行不到位的酌情减分，<br/>没有规划不得分</td>
				<td>10</td>
				<td>${byMap.f2 }</td>
			</tr>
			<tr>
				<td>有高产高效<br/>的农业设施</td>
				<td>设施农业面积比<br/>重</td>
				<td>村有温室、各类棚架、喷滴灌、遮阳网、防虫网等设<br/>施进行种植的实际建设面积占全村耕地面积的比重。<br/>10%以上得满分，每少1%扣1分</td>
				<td>10</td>
				<td>${byMap.f3 }</td>
			</tr>
			<tr>
				<td>有特色鲜明<br/>的主导产业</td>
				<td>特色产业带动低<br/>收入农户比重</td>
				<td>特色产业带动低收入农户数与村低收入农户总数之<br/>比，50%以上得满分，每减少5%减1分</td>
				<td>10</td>
				<td>${byMap.f4 }</td>
			</tr>
			<tr>
				<td rowspan="2">有持续稳定<br/>的集体收入</td>
				<td>集体经营性收入</td>
				<td>2015年所有经济薄弱村的集体经营性收入要达到15<br/>万元以上。各年度考核时每少1万元扣2分</td>
				<td rowspan="2">30</td>
				<td rowspan="2">${byMap.f5 }</td>
			</tr>
			<tr>
				<td>已入账收益<u>&nbsp;${byMap.m1 }&nbsp;</u>万<br/>元；已签协议还未<br/>
					实现收益<u>&nbsp;${byMap.m2 }&nbsp;</u>万<br/>元
				</td>
				<td>
					实施项目数<u>&nbsp;${byMap.pi }&nbsp;</u>个。项目资金来源：<br/>
					1.省财政资金<u>&nbsp;${byMap.v1 }&nbsp;</u>万元 
					4.帮扶单位资金<u>&nbsp;${byMap.v4 }&nbsp;</u>万元 <br/>
					2.市财政资金<u>&nbsp;${byMap.v2 }&nbsp;</u>万元
					5.其他资金<u>&nbsp;${byMap.v5 }&nbsp;</u>万元 <br/>
					3.县财政资金<u>&nbsp;${byMap.v3 }&nbsp;</u>万元 
					合计<u>&nbsp;${byMap.mt }&nbsp;</u>万元<br/>
				</td>
			</tr>
			<tr>
				<td>有先进适用<br/>的信息网络</td>
				<td>因特网入户率</td>
				<td>掼通过宽带、有线电视、电话拨号、移动上网（含手<br/>机上网），能够接入因特网的农户占本村农户总数的<br/>比重。70%以上得满分，每少10%扣2分</td>
				<td>10</td>
				<td>${byMap.f6 }</td>
			</tr>
			<tr>
				<td>有健康向上<br/>的文明新风</td>
				<td>村规民约制定率</td>
				<td>民制定并公布醒目，没有不得分</td>
				<td>10</td>
				<td>${byMap.f7 }</td>
			</tr>
			<tr>
				<td>有村容整洁<br/>的居住环境</td>
				<td>垃圾有人清运</td>
				<td>村内垃圾池干净整洁并有专人负责清运得满分</td>
				<td>10</td>
				<td>${byMap.f8 }</td>
			</tr>
			<tr>
				<td class="bottomborder">合计</td>
				<td class="bottomborder"></td>
				<td class="bottomborder"></td>
				<td class="bottomborder"></td>
				<td class="bottomborder">${byMap.ft }</td>
			</tr>
	    </table>
    </div>
</div>
</body>
</html>