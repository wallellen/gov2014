USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_sysright_update]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
系统修改各角色操作权限
exec sp_sysright_update 'admin','1,1,1,1,1','1,0,1'
*/
CREATE    proc [dbo].[sp_sysright_update](
@account varchar(30),--操作帐号
@rolestr varchar(60),--角色字符串，为空表示不针对角色，只针对具体的bm,1,1,1,1,1
@rightstr varchar(60),--权限字符串,示例:1,1,1,1
@opcoode int--0:禁止,1:允许
)
as
begin
declare @sql nvarchar(500)
declare @str varchar(200)
declare @itemnum int
declare @fns varchar(50)
declare @cn int
   set nocount on
	set @itemnum=dbo.get_itemcount(@rolestr,',')
	set @cn = 0
	while(@cn < @itemnum)
	begin
		set @fns = dbo.get_itemstr(@rightstr,2,',')
		set @str = dbo.get_itemstr(@rolestr,@cn+1,',')
		if @str= '1' 
		begin
			update govdata set edit=@opcoode where ol =@cn+1
		end
		set @cn = @cn +1
	end
   set nocount off
end
GO
