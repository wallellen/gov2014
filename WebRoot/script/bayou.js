function showBanfErrTip(top,c)
{
	var errTip=document.getElementById("errTip1");
	errTip.style.textIndent=top+"px";
	errTip.style.display="";
	errTip.innerHTML = c;
}
function hideBanfErrTip()
{
	var errTip=document.getElementById("errTip1");
	errTip.innerHTML = '';
}


$(function(){
	$("#defen1").bind("blur",checkDefen1);
	$("#defen2").bind("blur",checkDefen2);
	$("#defen3").bind("blur",checkDefen3);
	$("#defen4").bind("blur",checkDefen4);
	$("#defen5").bind("blur",checkDefen5);
	$("#defen6").bind("blur",checkDefen6);
	$("#defen7").bind("blur",checkDefen7);
	$("#defen8").bind("blur",checkDefen8);
	//
	$("#xmzj1").bind("blur",checkXmzj1);
	$("#xmzj2").bind("blur",checkXmzj2);
	$("#xmzj3").bind("blur",checkXmzj3);
	$("#xmzj4").bind("blur",checkXmzj4);
	$("#xmzj5").bind("blur",checkXmzj5);
	//实施项目数
	$("#ssxm").bind("blur",checkSsxm);
	//收益
	$("#rzsy").bind("blur",checkRzsy);
	$("#sxsy").bind("blur",checkSxsy);
	//村集体经济
	$("#jtjj").bind("blur",checkJtjj);
	$("#telnum").bind("blur",checkTelnum);
});


/************** check 得分 start **************/
function checkDefen1()
{
	var f1=$("#defen1").val();
	var reg =  /^[0-9]*[0-9][0-9]*$/; //正整数
	if(!f1)
	{
		showBanfErrTip(520,"得分不能为空");
		return false;
	}
	if(reg.test(f1))
	{
		hideBanfErrTip();
		defen_sum();
		return true;
	}
	else
	{
		showBanfErrTip(520,"请输入合理的得分");
		return false;
	}
}

function checkDefen2()
{
	var f2=$("#defen2").val();
	var reg =  /^[0-9]*[0-9][0-9]*$/; //正整数
	if(!f2)
	{
		showBanfErrTip(520,"得分不能为空");
		return false;
	}
	if(reg.test(f2))
	{
		hideBanfErrTip();
		defen_sum();
		return true;
	}
	else
	{
		showBanfErrTip(520,"请输入合理的得分");
		return false;
	}
}

function checkDefen3()
{
	var f3=$("#defen3").val();
	var reg =  /^[0-9]*[0-9][0-9]*$/; //正整数
	if(!f3)
	{
		showBanfErrTip(520,"得分不能为空");
		return false;
	}
	if(reg.test(f3))
	{
		hideBanfErrTip();
		defen_sum();
		return true;
	}
	else
	{
		showBanfErrTip(520,"请输入合理的得分");
		return false;
	}
}

function checkDefen4()
{
	var f4=$("#defen4").val();
	var reg =  /^[0-9]*[0-9][0-9]*$/; //正整数
	if(!f4)
	{
		showBanfErrTip(520,"得分不能为空");
		return false;
	}
	if(reg.test(f4))
	{
		hideBanfErrTip();
		defen_sum();
		return true;
	}
	else
	{
		showBanfErrTip(520,"请输入合理的得分");
		return false;
	}
}

function checkDefen5()
{
	var f5=$("#defen5").val();
	var reg =  /^[0-9]*[0-9][0-9]*$/; //正整数
	if(!f5)
	{
		showBanfErrTip(520,"得分不能为空");
		return false;
	}
	if(reg.test(f5))
	{
		hideBanfErrTip();
		defen_sum();
		return true;
	}
	else
	{
		showBanfErrTip(520,"请输入合理的得分");
		return false;
	}
}

function checkDefen6()
{
	var f6=$("#defen6").val();
	var reg =  /^[0-9]*[0-9][0-9]*$/; //正整数
	if(!f6)
	{
		showBanfErrTip(520,"得分不能为空");
		return false;
	}
	if(reg.test(f6))
	{
		hideBanfErrTip();
		defen_sum();
		return true;
	}
	else
	{
		showBanfErrTip(520,"请输入合理的得分");
		return false;
	}
}

function checkDefen7()
{
	var f7=$("#defen7").val();
	var reg =  /^[0-9]*[0-9][0-9]*$/; //正整数
	if(!f7)
	{
		showBanfErrTip(520,"得分不能为空");
		return false;
	}
	if(reg.test(f7))
	{
		hideBanfErrTip();
		defen_sum();
		return true;
	}
	else
	{
		showBanfErrTip(520,"请输入合理的得分");
		return false;
	}
}

function checkDefen8()
{
	var f8=$("#defen8").val();
	var reg =  /^[0-9]*[0-9][0-9]*$/; //正整数
	if(!f8)
	{
		showBanfErrTip(520,"得分不能为空");
		return false;
	}
	if(reg.test(f8))
	{
		hideBanfErrTip();
		defen_sum();
		return true;
	}
	else
	{
		showBanfErrTip(520,"请输入合理的得分");
		return false;
	}
}

function defen_sum()
{
	var ft;
	var f1=$("#defen1").val();
	var f2=$("#defen2").val();
	var f3=$("#defen3").val();
	var f4=$("#defen4").val();
	var f5=$("#defen5").val();
	var f6=$("#defen6").val();
	var f7=$("#defen7").val();
	var f8=$("#defen8").val();
	
	if(f1>=0 && f2>=0 && f3>=0 && f4>=0 && f5>=0 && f6>=0 && f7>=0 && f8>=0)
	{
		ft = parseInt(f1)+parseInt(f2)+parseInt(f3)+parseInt(f4)+parseInt(f5)+parseInt(f6)+parseInt(f7)+parseInt(f8);
	}
	$("#defent")[0].innerHTML=ft.toFixed(0);
}

/************** check 得分 end **************/

/************** check 项目资金 start **************/
function checkXmzj1()
{
	var zj1=$("#xmzj1").val();
	var reg =  /^[0-9]+([.]{1}[0-9]{1,2})?$/; //正整数
	if(!zj1)
	{
		showBanfErrTip(240,"省财政资金不能为空");
		return false;
	}
	if(reg.test(zj1))
	{
		hideBanfErrTip();
		xmzj_sum();
		return true;
	}
	else
	{
		showBanfErrTip(240,"请输入合法的省财政资金,非负整数或小数[小数最多精确到小数点后两位]！");
		return false;
	}
}

function checkXmzj2()
{
	var zj2=$("#xmzj2").val();
	var reg =  /^[0-9]+([.]{1}[0-9]{1,2})?$/; //正整数
	if(!zj2)
	{
		showBanfErrTip(240,"市财政资金不能为空");
		return false;
	}
	if(reg.test(zj2))
	{
		hideBanfErrTip();
		xmzj_sum();
		return true;
	}
	else
	{
		showBanfErrTip(240,"请输入合法的市财政资金,非负整数或小数[小数最多精确到小数点后两位]！");
		return false;
	}
}

function checkXmzj3()
{
	var zj3=$("#xmzj3").val();
	var reg =  /^[0-9]+([.]{1}[0-9]{1,2})?$/; //正整数
	if(!zj3)
	{
		showBanfErrTip(240,"县财政资金不能为空");
		return false;
	}
	if(reg.test(zj3))
	{
		hideBanfErrTip();
		xmzj_sum();
		return true;
	}
	else
	{
		showBanfErrTip(240,"请输入合法的县财政资金,非负整数或小数[小数最多精确到小数点后两位]！");
		return false;
	}
}

function checkXmzj4()
{
	var zj4=$("#xmzj4").val();
	var reg =  /^[0-9]+([.]{1}[0-9]{1,2})?$/; //正整数
	if(!zj4)
	{
		showBanfErrTip(240,"帮扶单位资金不能为空");
		return false;
	}
	if(reg.test(zj4))
	{
		hideBanfErrTip();
		xmzj_sum();
		return true;
	}
	else
	{
		showBanfErrTip(240,"请输入合法的帮扶单位资金,非负整数或小数[小数最多精确到小数点后两位]！");
		return false;
	}
}

function checkXmzj5()
{
	var zj5=$("#xmzj5").val();
	var reg =  /^[0-9]+([.]{1}[0-9]{1,2})?$/; //正整数
	if(!zj5)
	{
		showBanfErrTip(240,"其他资金不能为空");
		return false;
	}
	if(reg.test(zj5))
	{
		hideBanfErrTip();
		xmzj_sum();
		return true;
	}
	else
	{
		showBanfErrTip(240,"请输入合法的其他资金,非负整数或小数[小数最多精确到小数点后两位]！");
		return false;
	}
}

function xmzj_sum()
{
	var zjt;
	var zj1=$("#xmzj1").val();
	var zj2=$("#xmzj2").val();
	var zj3=$("#xmzj3").val();
	var zj4=$("#xmzj4").val();
	var zj5=$("#xmzj5").val();
	
	if(zj1>=0 && zj2>=0 && zj3>=0 && zj4>=0 && zj5>=0)
	{
		zjt = parseFloat(zj1)+parseFloat(zj2)+parseFloat(zj3)+parseFloat(zj4)+parseFloat(zj5);
	}
	$("#xmzjt")[0].innerHTML=zjt.toFixed(2);
}
/************** check 项目资金 end **************/

/************** check 实施项目数 start **************/
function checkSsxm()
{
	var ss=$("#ssxm").val();
	var reg =  /^[0-9]*[0-9][0-9]*$/; //正整数
	if(!ss)
	{
		showBanfErrTip(240,"实施项目数不能为空");
		return false;
	}
	if(reg.test(ss))
	{
		hideBanfErrTip();
		return true;
	}
	else
	{
		showBanfErrTip(240,"请输入合理的实施项目数");
		return false;
	}
}
/************** check 实施项目数 end **************/

/************** check 入账收益，实现收益 start **************/
function checkRzsy()
{
	var rz=$("#rzsy").val();
	var reg =  /^[0-9]+([.]{1}[0-9]{1,2})?$/; //正整数
	if(!rz)
	{
		showBanfErrTip(80,"已入账收益不能为空");
		return false;
	}
	if(reg.test(rz))
	{
		hideBanfErrTip();
		return true;
	}
	else
	{
		showBanfErrTip(80,"请输入合法的已入账收益,非负整数或小数[小数最多精确到小数点后两位]！");
		return false;
	}
}

function checkSxsy()
{
	var sx=$("#sxsy").val();
	var reg =  /^[0-9]+([.]{1}[0-9]{1,2})?$/; //正整数
	if(!sx)
	{
		showBanfErrTip(80,"未实现收益不能为空");
		return false;
	}
	if(reg.test(sx))
	{
		hideBanfErrTip();
		return true;
	}
	else
	{
		showBanfErrTip(80,"请输入合法的未实现收益,非负整数或小数[小数最多精确到小数点后两位]！");
		return false;
	}
}
/************** check 入账收益，实现收益 end **************/

/************** check 村集体经济 start **************/
function checkJtjj()
{
	var jt=$("#jtjj").val();
	var reg =  /^[0-9]+([.]{1}[0-9]{1,2})?$/; //正整数
	if(!jt)
	{
		showBanfErrTip(5,"村集体经济收入不能为空");
		return false;
	}
	if(reg.test(jt))
	{
		hideBanfErrTip();
		return true;
	}
	else
	{
		showBanfErrTip(5,"请输入合法的村集体经济收入,非负整数或小数[小数最多精确到小数点后两位]！");
		return false;
	}
}
/************** check 村集体经济 end **************/

/************** check 电话 end **************/
function checkTelnum()
{
	var tel=$("#telnum").val();
	var reg =  /^([0-9]|[-])+$/g; //电话
	if(tel && reg.test(tel))
	{
		hideBanfErrTip();
		return true;
	}
	else
	{
		showBanfErrTip(5,"请输入有效的电话号码");
		return false;
	}
}
/************** check 电话 end **************/

function saveBayou()
{
	if(!checkTelnum(document.all.telnum)) return;
	if(!checkJtjj(document.all.jtjj)) return;
	if(!checkRzsy(document.all.rzsy)) return;
	if(!checkSxsy(document.all.sxsy)) return;
	if(!checkSsxm(document.all.ssxm)) return;
	if(!checkXmzj1(document.all.xmzj1)) return;
	if(!checkXmzj2(document.all.xmzj2)) return;
	if(!checkXmzj3(document.all.xmzj3)) return;
	if(!checkXmzj4(document.all.xmzj4)) return;
	if(!checkXmzj5(document.all.xmzj5)) return;
	
	if(!checkDefen1(document.all.defen1)) return;
	if(!checkDefen2(document.all.defen2)) return;
	if(!checkDefen3(document.all.defen3)) return;
	if(!checkDefen4(document.all.defen4)) return;
	if(!checkDefen5(document.all.defen5)) return;
	if(!checkDefen6(document.all.defen6)) return;
	if(!checkDefen7(document.all.defen7)) return;
	if(!checkDefen8(document.all.defen8)) return;
	
	document.form1.submit();
}