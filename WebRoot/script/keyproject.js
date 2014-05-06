// JavaScript Document
function popKeyProjectEdit(s,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12){
	//title
	var kt = document.getElementById("ktitle");
	kt.innerHTML="";
	//clear
	document.getElementById("kp1").value='';
	document.getElementById("kp2").value='';
	document.getElementById("kp3").value='';
	document.getElementById("kp4").value='';
	document.getElementById("kp5").value='';
	document.getElementById("kp6").value='';
	document.getElementById("kp7").value='';
	document.getElementById("kp8").value='';
	document.getElementById("kp9").value='';
	document.getElementById("kp10").value='';
	
	if(s=="edit"){
		kt.innerHTML="<font color='#fff'>修改关键项目信息</font>";
		document.getElementById("kxxm").value=p1;	//要更新或插入的项目所在乡的编码
		document.getElementById("kpid").value=p2;	//项目编号,如果是新建,则项目编号为空
		document.getElementById("kp1").value=p3;
		document.getElementById("kp2").value=p4;
		document.getElementById("kp3").value=p5;
		document.getElementById("kp4").value=p6;
		document.getElementById("kp5").value=p7;
		document.getElementById("kp6").value=p8;
		document.getElementById("kp7").value=p9;
		document.getElementById("kp8").value=p10;
		document.getElementById("kp9").value=p11;
		document.getElementById("kp10").value=p12;
	}else{
		kt.innerHTML="<font color='#fff'>添加关键项目信息</font>";
		document.getElementById("kxxm").value=p1;	//要更新或插入的项目所在乡的编码
		document.getElementById("kpid").value=p2;	//项目编号,如果是新建,则项目编号为空
		document.getElementById("kp1").value='项目1';
		document.getElementById("kp2").value='乡镇名称';
		document.getElementById("kp3").value=0;
		document.getElementById("kp4").value=0;
		document.getElementById("kp5").value=0;
		document.getElementById("kp6").value=0;
		document.getElementById("kp7").value=0;
		document.getElementById("kp8").value=0;
		document.getElementById("kp9").value=0;
		document.getElementById("kp10").value=0;
	}
	
	var oWin = document.getElementById("win-keyproject");
	var oLay = document.getElementById("overlay-keyproject");
	var oClose = document.getElementById("y-close"); 
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
function subKeyProjectBt(){
	document.keyProjectForm.action="govKeyProjectAction_saveKeyProject.do";
	document.keyProjectForm.submit();
}
	