/** add year **/
function popIncomeYear(s,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12){
	var ytitle = document.getElementById("ytitle");
	ytitle.innerHTML="";
	//clear
	document.getElementById("i1").value = '';
	document.getElementById("i2").value = '';
	document.getElementById("i3").value = '';
	document.getElementById("i4").value = '';
	document.getElementById("i5").value = '';
	document.getElementById("i6").value = '';
	document.getElementById("i7").value = '';
	document.getElementById("i8").value = '';
	document.getElementById("i9").value = '';
	document.getElementById("i10").value = '';
	document.getElementById("i11").value = '';
	document.getElementById("i12").value = '';
	document.getElementById("i13").value = '';
	if(s=="edit"){
		ytitle.innerHTML="<font color='#fff'>修改家庭收入及帮扶情况</font>";
		document.getElementById("i1").value = 1;
		document.getElementById("i2").value = i1;
		document.getElementById("i3").value = i2;
		document.getElementById("i4").value = i3;
		document.getElementById("i5").value = i4;
		document.getElementById("i6").value = i5;
		document.getElementById("i7").value = i6;
		document.getElementById("i8").value = i7;
		document.getElementById("i9").value = i8;
		document.getElementById("i10").value = i9;
		document.getElementById("i11").value = i10;
		document.getElementById("i12").value = i11;
		document.getElementById("i13").value = i12;
	}else{
		ytitle.innerHTML="<font color='#fff'>添加家庭收入及帮扶情况</font>";
		document.getElementById("i1").value = 0;
		document.getElementById("i2").value = i1;
		document.getElementById("i3").value = 0;
		document.getElementById("i4").value = 0;
		document.getElementById("i5").value = 0;
		document.getElementById("i6").value = 0;
		document.getElementById("i7").value = 0;
		document.getElementById("i8").value = 0;
		document.getElementById("i9").value = 0;
		document.getElementById("i10").value = 0;
		document.getElementById("i11").value = 0;
		document.getElementById("i12").value = 0;
		document.getElementById("i13").value = 0;
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
	document.incomeForm.action="govIncomeAction_saveIncome.do";
	document.incomeForm.submit();
}
