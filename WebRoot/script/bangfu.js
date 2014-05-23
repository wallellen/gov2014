function popBangfuDeptEdit(s,f1,f2,f3,f4){
	//title
	var bts = document.getElementById("bstitle");
	bts.innerHTML="";
	//clear
	document.getElementById("hh1s").value='';
	//
	if(s=="edit"){
		bts.innerHTML="<font color='#fff'>修改后方单位帮扶信息</font>";
		document.getElementById("hh1s").value=f4;
		
	}else{
		bts.innerHTML="<font color='#fff'>添加后方单位帮扶信息</font>";
		document.getElementById("hh1s").value='单位1';
	}
	//批次号
	document.getElementById("fuid").value=f1;
	//类别号
	document.getElementById("tid").value=f2;
	var oWin = document.getElementById("win-bangfus");
	var oLay = document.getElementById("overlay-bangfus");
	var oClose = document.getElementById("y-closes"); 
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
function subBangfuDeptBt(){
	document.bangFuDeptForm.action="govBangfuAction_saveBangfuDept.do";
	//var tPage = document.getElementById("t_page").innerHTML;
	//parent.document.getElementById("globalCurPage").value=tPage;
	document.bangFuDeptForm.submit();
}


// JavaScript Document
function popBangfuEdit(s,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10){
	//title
	var bt = document.getElementById("btitle");
	bt.innerHTML="";
	//clear
	document.getElementById("hh1").value='';
	document.getElementById("hh2").value='';
	document.getElementById("hh3").value='';
	document.getElementById("hh4").value='';
	document.getElementById("hh5").value='';
	document.getElementById("hh6").value='';
	document.getElementById("hh7").value='';
	document.getElementById("hh8").value='';
	document.getElementById("hh9").value='';
	document.getElementById("hh10").value='';
	document.getElementById("hh11").value='';
	document.getElementById("hh12").value='';
	//
	if(s=="edit"){
		bt.innerHTML="<font color='#fff'>修改后方单位帮扶信息</font>";
		document.getElementById("hh1").value=f1;
		document.getElementById("hh2").value='';
		document.getElementById("hh3").value='';
		document.getElementById("hh4").value=f2;
		document.getElementById("hh5").value=f3;
		document.getElementById("hh6").value=f4;
		document.getElementById("hh7").value=f5;
		document.getElementById("hh8").value=f6;
		document.getElementById("hh9").value=f7;
		document.getElementById("hh10").value=f8;
		document.getElementById("hh11").value=f9;
		document.getElementById("hh12").value=f10;
	}else{
		bt.innerHTML="<font color='#fff'>添加后方单位帮扶信息</font>";
		document.getElementById("hh1").value=f1;
		document.getElementById("hh2").value='';
		document.getElementById("hh3").value='';
		document.getElementById("hh4").value=0;
		document.getElementById("hh5").value=0;
		document.getElementById("hh6").value=0;
		document.getElementById("hh7").value=0;
		document.getElementById("hh8").value=0;
		document.getElementById("hh9").value=0;
		document.getElementById("hh10").value=0;
		document.getElementById("hh11").value=0;
		document.getElementById("hh12").value=0;
	}
	//批次号
	document.getElementById("iid").value=f1;
	var oWin = document.getElementById("win-bangfu");
	var oLay = document.getElementById("overlay-bangfu");
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
function subJiangBuBt(){
	document.bangFuForm.action="govBangfuAction_saveBangfu.do";
	document.bangFuForm.submit();
}



	