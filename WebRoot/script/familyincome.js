/** add year **/
function popSaveYear(s,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12){
	var ytitle = document.getElementById("ytitle");
	ytitle.innerHTML="";
	//clear
	document.getElementById("yflag").value = '';
	document.getElementById("y-year").value = '';
	document.getElementById("y-inCrop").value = '';
	document.getElementById("y-inLovStock").value = '';
	document.getElementById("y-inWork").value = '';
	document.getElementById("y-inBla").value = '';
	document.getElementById("y-inSubside").value = '';
	document.getElementById("y-inOther").value = '';
	document.getElementById("y-grantAid").value = '';
	document.getElementById("y-share").value = '';
	document.getElementById("y-pettyLoan").value = '';
	document.getElementById("y-labTrain").value = '';
	document.getElementById("y-labJob").value = '';
	document.getElementById("yearhidden").innerHTML='';
	if(s=="edit"){
		ytitle.innerHTML="<font color='#fff'>修改家庭收入及帮扶情况</font>";
		document.getElementById("yearhidden").innerHTML='年份:&nbsp;&nbsp;';
		document.getElementById("y-year").style.display='block';
		document.getElementById("y-year").readOnly='true';
		document.getElementById("y-year").value = y1;
		document.getElementById("y-inCrop").value = y2;
		document.getElementById("y-inLovStock").value = y3;
		document.getElementById("y-inWork").value = y4;
		document.getElementById("y-inBla").value = y5;
		document.getElementById("y-inSubside").value = y6;
		document.getElementById("y-inOther").value = y7;
		document.getElementById("y-grantAid").value = y8;
		document.getElementById("y-share").value = y9;
		document.getElementById("y-pettyLoan").value = y10;
		document.getElementById("y-labTrain").value = y11;
		document.getElementById("y-labJob").value = y12;
		document.getElementById("yflag").value = "1";
	}else{
		ytitle.innerHTML="<font color='#fff'>添加家庭收入及帮扶情况</font>";
		document.getElementById("yflag").value = "0";
		document.getElementById("yearhidden").innerHTML='';
		document.getElementById("y-year").style.display='none';
		document.getElementById("y-inCrop").value = 0;
		document.getElementById("y-inLovStock").value = 0;
		document.getElementById("y-inWork").value = 0;
		document.getElementById("y-inBla").value = 0;
		document.getElementById("y-inSubside").value = 0;
		document.getElementById("y-inOther").value = 0;
		document.getElementById("y-grantAid").value = 0;
		document.getElementById("y-share").value = 0;
		document.getElementById("y-pettyLoan").value = 0;
		document.getElementById("y-labTrain").value = 0;
		document.getElementById("y-labJob").value = 0;
	}
	
	var oWin = document.getElementById("win-year");
	var oLay = document.getElementById("overlay-year");
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
function subYearBt(){
	document.yearForm.action="govBrowerAction_saveYear.do";
	document.yearForm.submit();
}
