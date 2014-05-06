function popSaveMember(m,s,c){
	var mtitle = document.getElementById("mtitle");
	mtitle.innerHTML="";
	//clear
	document.getElementById("d-uname").value='';
	document.getElementById("nameTips").innerHTML='';
	document.getElementById("d-age").value='';
	document.getElementById("ageTips").value='';
	document.getElementById("d-dcno").value='';
	document.getElementById("d-tbfd").value='';
	document.getElementById("mid").value='';
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
//check member
function checkName(){
	var duname = $("#d-uname").val();
	if(duname==""){
		$("#nameTips").html("姓名不能为空");
		memberForm.duname.focus(); 
		return false;
	}else{
		$("#nameTips").html("");
		return true;
	}
}
//check age
function checkAge(){
	var dage = $("#d-age").val();
	if(dage==""){
		$("#ageTips").html("出生年份不能为空");
		memberForm.dage.focus(); 
		return false;
	}else if(dage<1900 || dage>2020){
		$("#ageTips").html("出生年份范围1900-2020");
		memberForm.dage.focus(); 
		return false;
	}else{
		$("#ageTips").html("");
		return true;
	}
}
