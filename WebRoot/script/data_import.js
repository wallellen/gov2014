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