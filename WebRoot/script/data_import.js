function checkXianma(obj,s)
{
	var xm = obj.value;
	var reg = /^[0-9]*$/;
	var xmt = document.getElementById("xmTip");
	if(xm=="" || xm.length!=6 || !reg.test(xm))
	{
		xmTip.innerHTML="请输入6位数字的县码";
		xmt.className="xm_tip_err";
		return false;
	}
	else
	{
		var url;
		if(s=="farmer")
		{
			url = "farmerDataAction_checkXM.do";
		}
		else if(s=="member")
		{
			url = "memberDataAction_checkXM.do";
		}
		else if(s=="year")
		{
			url = "yearDataAction_checkXM.do";
		}
		var datajson = {"xm":xm};
		$.ajax({
			type: "POST",
			url: url,
			dataType: "json",
			data: datajson,
			success: responseCheck,
		  	error: function () {
		  	}
	    });
		return true;
	}
}
var responseCheck = function(data, textStatus, jqXHR)
{
	var xmt = document.getElementById("xmTip");
	if(data.status=="ok")
	{
		xmt.className="xm_tip_ok";
	}
	else
	{
		xmt.className="xm_tip_err";
	}
	xmTip.innerHTML=data.xname;
}

function checkFile(s){
	var obj=document.getElementById('file_text');
    //var stuff=obj.value.match(/^(.*)(.)(.{1,8})$/)[3]; //这个文件类型正则很有用：）
    var stuff=obj.value.substring(obj.value.lastIndexOf(".")+1);
	if(obj.value=='')
    {
		alert('请选择要上传的文件');
        return false;
    }
    if(stuff=='xls' || stuff=='xlsx')
    {
    	if(!checkXianma(document.all.xm)) return;
    	if(s=="farmer")
    	{
    		document.farmerForm.action="farmerDataAction_importData.do";
        	document.farmerForm.submit();
    	}
    	else if(s=="member")
    	{
    		document.memberForm.action="memberDataAction_importData.do";
        	document.memberForm.submit();
    	}
    	else if(s=="year")
    	{
    		document.yearForm.action="yearDataAction_importData.do";
        	document.yearForm.submit();
    	}
    	return true;
    }
    else
	{
    	alert('文件类型不正确，请选择.xls文件');
       	return false;
	}
    
}

//清空农户信息
function emptyFarmerData()
{
	if(!checkXianma(document.all.xm)) return;
	if(confirm("确定要清空吗？")){
		var xm = $("#xm").val();
		var url = "farmerDataAction_emptyFarmer.do";
		var datajson = {"xm":xm};
		$.ajax({
			type: "POST",
			url: url,
			dataType: "json",
			data: datajson,
			success: function(){
				alert("成功 ！");
		  	},
		  	error: function () {
		  		//alert("失败 ！");
		  	}
	    });
	};
}

//清空成员信息
function emptyMemberData()
{
	if(!checkXianma(document.all.xm)) return;
	if(confirm("确定要清空吗？")){
		var xm = $("#xm").val();
		var url = "memberDataAction_emptyMember.do";
		var datajson = {"xm":xm};
		$.ajax({
			type: "POST",
			url: url,
			dataType: "json",
			data: datajson,
			success: function(){
				alert("成功 ！");
		  	},
		  	error: function () {
		  		//alert("失败 ！");
		  	}
	    });
	}
}

//清空指定年，县信息
function emptyYearData()
{
	if(!checkXianma(document.all.xm)) return;
	if(confirm("确定要清空吗？")){
		var xm = $("#xm").val();
		var year = $("#year").val();
		var url = "yearDataAction_emptyYear.do";
		var datajson = {"xm":xm,"year":year};
		$.ajax({
			type: "POST",
			url: url,
			dataType: "json",
			data: datajson,
			success: function(){
				alert("成功 ！");
		  	},
		  	error: function () {
		  		//alert("失败 ！");
		  	}
	    });
	}
}