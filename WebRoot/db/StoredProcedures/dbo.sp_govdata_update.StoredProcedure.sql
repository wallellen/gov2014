USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_govdata_update]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
组织结构的名称更新
*/
CREATE      proc [dbo].[sp_govdata_update](
@account varchar(30),
@bm varchar(30),
@oname varchar(100),
@htn int,--农户总数,
@ptn int--人口总数
)                  
as
begin
declare @len int
declare @str nvarchar(200)
   set nocount on
	set @len = len(@account)
	if(left(@bm,@len)=@account and len(@oname)>0)
	begin
		update govdata set oname = @oname,htn=@htn,ptn=@ptn where bm=@bm
		set @str = 'account['+@account+']更新部门['+@bm+']信息'
      execute sys_addlog 1,"更新",@account,@str
	end
   set nocount off
end
GO
