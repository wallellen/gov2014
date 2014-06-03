

function popSaveMember(m,s,c){
	var mtitle = document.getElementById("mtitle");
	mtitle.innerHTML="";
	
	//clear
	document.getElementById("d-uname").value='';
	document.getElementById("d-age").value='';
	document.getElementById("d-dcno").value='';
	document.getElementById("d-tbfd").value='';
	document.getElementById("mid").value='';
	
	hideErrTip();
	
	if(s=="edit"){
		mtitle.innerHTML="<font color='#fff'>修改家庭成员信息</font>";
		var uname = document.getElementById("una"+c);
		document.getElementById("d-uname").value = uname.innerHTML;
		//sec
		var usex = document.getElementById("sex"+c).innerHTML;
		usex = usex.substring(0,1)-1;
		var sexRadio = document.getElementsByName("sex");
		sexRadio[usex].checked = "checked"; 
		//age									
		var uage = document.getElementById("age"+c);
		document.getElementById("d-age").value = uage.innerHTML;
		//school
		var uschool = document.getElementById("sch"+c).innerHTML;
		uschool = uschool.substring(0,1)-1;
		var schoolRadio = document.getElementsByName("school");
		schoolRadio[uschool].checked = "checked";
		//education
		var ueducation = document.getElementById("edu"+c).innerHTML;
		ueducation = ueducation.substring(0,1);
		ops = document.getElementById("d-education").options;
		for(var i=0;i<ops.length; i++){  
	        tempValue = ops[i].value; 
	        if(tempValue == ueducation){  
	            ops[i].selected = true;  
	        }  
	    }
		//health
		var uhealth = document.getElementById("hea"+c).innerHTML;
		uhealth = uhealth.substring(0,1);
		ops = document.getElementById("d-health").options;
		for(var i=0;i<ops.length; i++){  
	        tempValue = ops[i].value; 
	        if(tempValue == uhealth){  
	            ops[i].selected = true;  
	        }  
	    }
	    //dcno
		var udcno = document.getElementById("dcn"+c);
		document.getElementById("d-dcno").value = udcno.innerHTML;
		//labors
		var ulabors = document.getElementById("lab"+c).innerHTML;
		ulabors = ulabors.substring(0,1);
		ops = document.getElementById("d-labors").options;
		for(var i=0;i<ops.length; i++){  
	        tempValue = ops[i].value; 
	        if(tempValue == ulabors){  
	            ops[i].selected = true;  
	        }  
	    }
		//work
		var uwork = document.getElementById("wor"+c).innerHTML;
		uwork = uwork.substring(0,1);
		ops = document.getElementById("d-works").options;
		for(var i=0;i<ops.length; i++){  
	        tempValue = ops[i].value; 
	        if(tempValue == uwork){  
	            ops[i].selected = true;  
	        }  
	    }
		//bla
		var ubla = document.getElementById("bla"+c).innerHTML;
		ubla = ubla.substring(0,1)-1;
		var blaRadio = document.getElementsByName("bla");
		blaRadio[ubla].checked = "checked";
		//dbfd
		var utbf = document.getElementById("tbf"+c);
		document.getElementById("d-tbfd").value = utbf.innerHTML;
		//mid
		document.getElementById("mid").value=m;
	}else{
		mtitle.innerHTML="<font color='#fff'>添加家庭成员</font>";
		document.getElementById("mid").value=m;
		//default select
		//sex
		var sexRadio = document.getElementsByName("sex");
		sexRadio[0].checked = "checked";
		
		var schoolRadio = document.getElementsByName("school");
		schoolRadio[0].checked = "checked";
		
		var ops = document.getElementById("d-education").options;
		for(var i=0;i<ops.length; i++){   
	        ops[0].selected = true;  
	    }   
		ops = document.getElementById("d-health").options;
		for(var i=0;i<ops.length; i++){   
	        ops[0].selected = true;  
	    }  
		ops = document.getElementById("d-labors").options;
		for(var i=0;i<ops.length; i++){   
	        ops[0].selected = true;  
	    }  
		ops = document.getElementById("d-works").options;
		for(var i=0;i<ops.length; i++){   
	        ops[0].selected = true;  
	    }  
		var blaRadio = document.getElementsByName("bla");
		blaRadio[0].checked = "checked";
		
		
		
	}
	
	var oWin = document.getElementById("win-member");
	var oLay = document.getElementById("overlay-member");
	var oClose = document.getElementById("close"); 
	var oH2 = oWin.getElementsByTagName("h2")[0]; 
	var bDrag = false; 
	var disX = disY = 0; 
	oLay.style.display = "block"; 
	oWin.style.display = "block" 
		oClose.onclick = function(){ 
		oLay.style.display = "none"; 
		oWin.style.display = "none" 
	}; 
	oClose.onmousedown = function(event){ 
		(event || window.event).cancelBubble = true; 
	}; 
	oH2.onmousedown = function(event){ 
		var event = event || window.event; 
		bDrag = true; 
		disX = event.clientX - oWin.offsetLeft; 
		disY = event.clientY - oWin.offsetTop; 
		this.setCapture && this.setCapture(); 
		return false 
	}; 
	document.onmousemove = function(event){ 
		if (!bDrag) return; 
		var event = event || window.event; 
		var iL = event.clientX - disX; 
		var iT = event.clientY - disY;
		var maxL = document.documentElement.clientWidth - oWin.offsetWidth; 
		var maxT = document.documentElement.clientHeight - oWin.offsetHeight; 
		iL = iL < 0 ? 0 : iL; 
		iL = iL > maxL ? maxL : iL; 
		iT = iT < 0 ? 0 : iT; 
		iT = iT > maxT ? maxT : iT; 

		oWin.style.marginTop = oWin.style.marginLeft = 0; 
		oWin.style.left = iL + "px"; 
		oWin.style.top = iT + "px"; 
		return false 
	}; 
	document.onmouseup = window.onblur = oH2.onlosecapture = function(){ 
		bDrag = false; 
		oH2.releaseCapture && oH2.releaseCapture(); 
	}; 
}
function subMemberBt(){
	document.memberForm.action="govBrowerAction_saveMember.do";
	if(checkName() && checkAge()){
		document.memberForm.submit();
	}
}

function showErrTip(top,c)
{
	var errTip=document.getElementById("errTip");
	errTip.style.marginTop=top+"px";
	errTip.style.display="";
	errTip.innerHTML = c;
}
function hideErrTip()
{
	var errTip=document.getElementById("errTip");
	errTip.style.display="none";
}

function checkName(){
	var duname = $("#d-uname").val();
	var m = /^[\u4e00-\u9faf]+$/;
	if(duname=="")
	{
		showErrTip(-10,"姓名必须输入");
		memberForm.duname.focus(); 
		return false;
	}
	else if(!m.test(duname) || duname.length<2)
	{
		showErrTip(-10,"姓名不可以少于2个字");
		memberForm.duname.focus(); 
		return false;
	}
	else{
		hideErrTip();
		return true;
	}
}
//check age
function checkAge(){
	var dage = $("#d-age").val();
	if(dage==""){
		showErrTip(52,"出生年份不能为空");
		memberForm.dage.focus(); 
		return false;
	}else if(dage<1900 || dage>2020){
		showErrTip(52,"出生年份范围1900-2020");
		memberForm.dage.focus(); 
		return false;
	}else{
		return true;
	}
}

//check member
function checkDcno()
{
	var dcno = $("#d-dcno").val();
	if(dcno.length ==0 || (dcno.length==20 && dcno.match(/^[0-9a-zA-Z]+$/)))
	{
		hideErrTip();
	}
	else
	{
		showErrTip(172,"残疾证号可以为空或20位字母与数字的组合");
	}
}

//check dibao
function checkDibao(){
	var tb = $("#d-tbfd").val();
	if(tb.match(/^[0-9]+$/) && tb>=0)
	{
		hideErrTip();
	}
	else
	{
		showErrTip(295,"低保金只能是大于0的数字");
	}
	var blaRadio = document.getElementsByName("bla");
	if(blaRadio[0].checked){
		if(tb.length==0 || tb==0 || !tb.match(/^[0-9]+$/)){
			showErrTip(295,"低保金只能是大于0的数字");
		}
		else
		{
			hideErrTip();
		}
	}
}

//PersonIDCard
function checkIDCard()
{
	var num = document.getElementById("idcno").value;
	var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
    //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X。  
	if(num.length>0 && !reg.test(num))   
    {
         alert('输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X。');
         personForm.idcno.focus(); 
         return false;
    } 
	else
	{
		return true;
	}
}

//tel
function checkTelphone()
{
	var tel = $("#htel").val();
	if(tel.length ==0 || ((tel.length==11 || tel.length==12) && dcno.match(/^[0-9]+$/)))
	{
		return true;
	}
	else
	{
		alert("请输入合法的电话号码");
		personForm.htel.focus(); 
        return false;
	}
}

//size


//house
function checkHouse(){
	var house = $("#house").val();
	if(isNaN(house))
	{        
		alert("非法数字");
		return false;
    }
	if(house<10 || house>300)
	{
		alert("请输入合理的面积");
		return false;
	}
}


function checkBanfPerson(){
	var banf = $("#frname").val();
	var m = /^[\u4e00-\u9faf]+$/;
	if(banf.length>0 && (!m.test(banf) || banf.length<2))
	{
		alert("挂钩帮扶人只能是汉字，且不能少于2个字符");
		memberForm.frname.focus(); 
		return false;
	}
}

function checkBanfWork(){
	var banfw = $("#frwork").val();
	var m = /^[\u4e00-\u9faf]+$/;
	if(banfw.length>0 && (!m.test(banfw) || banfw.length<2))
	{
		alert("单位职务只能是汉字，且不能少于2个字符");
		memberForm.frwork.focus(); 
		return false;
	}
	else
	{
		return true;
	}
	return false;
}

//guagouTel
function checkBanfTelphone()
{
	var tel = $("#frtel").val();
	if(tel.length ==0 || ((tel.length==11 || tel.length==12) && tel.match(/^[0-9]+$/)))
	{
		return true;
	}
	else
	{
		alert("请输入合法的电话号码");
		personForm.htel.focus(); 
        return false;
	}
}

//
function checkPersonForm()
{
	if(checkIDCard() && checkTelphone() && checkHouse() && checkBanfPerson() && checkBanfWork()){
		return true;
	}
	return false;
}






