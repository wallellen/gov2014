function checkXianma(obj)
{
	var xm = obj.value;
	var reg = /^[0-9]*$/;
	var xmt = document.getElementById("xmTip");
	if(xm=="" || xm.length!=6 || !reg.test(xm))
	{
		xmTip.innerHTML="请输入6位数字的县码";
		xmt.className="xm_tip_err";
	}
	else
	{
		xmTip.innerHTML="";
		xmt.className="xm_tip_ok";
	}
	var url = "farmerDataAction_checkXM.do";
	var datajson = {"xm":xm};
	$.ajax({
		type: "POST",
		url: url,
		dataType: "json",
		data: datajson,
		success: function(){
			//alert("成功 ！");
	  	},
	  	error: function () {
	  		//alert("失败 ！");
	  	}
    });
}


function checkFile(){
	var obj=document.getElementById('file_text');
	if(obj.value=='')
    {
		alert('请选择要上传的文件');
        return false;
    }
    //var stuff=obj.value.match(/^(.*)(.)(.{1,8})$/)[3]; //这个文件类型正则很有用：）
    var stuff=obj.value.substring(obj.value.lastIndexOf(".")+1);
    if(stuff=='xls' || stuff=='xlsx')
    {
		return true;
    }
    else
	{
    	alert('文件类型不正确，请选择.xls文件');
       	return false;
	}
    return true;
}

//清空农户信息
function emptyFarmerData()
{
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
}

//清空成员信息
function emptyMemberData()
{
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

//清空指定年，县信息
function emptyYearData()
{
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