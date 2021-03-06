USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_database_index]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
数据库维护--重建索引
*/
CREATE     proc [dbo].[sys_database_index](
@account varchar(64),--备份帐号
@param int--0:清空，1:创建,2:重新创建
)
as
begin
declare @str varchar(500)
   set nocount on
	if @param = 0
	begin
		--exec mp_drop_index 
		set @str = '['+@account+']执行索引清空操作'
		execute sys_addlog 1,"添加",@account,@str
	end
	else if @param=1
	begin
		--exec mp_create_index 
		set @str = '['+@account+']执行索引创建操作'
		execute sys_addlog 1,"添加",@account,@str
	end
	else if @param = 2
	begin
		--exec mp_drop_index 
		--exec mp_create_index 
		set @str = '['+@account+']执行索引重建操作'
		execute sys_addlog 1,"添加",@account,@str
	end
   set nocount off
end
GO
