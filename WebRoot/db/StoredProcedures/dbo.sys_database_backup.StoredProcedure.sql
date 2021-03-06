USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_database_backup]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
数据库维护--备份数据库操作
exec sys_database_backup 'admin',1,'d:\cccccc.bak'
*/
CREATE        proc [dbo].[sys_database_backup](
@account varchar(64),--备份帐号
@roleid int, --角色类型
@backupfilename varchar(200)--要备份的服务器磁盘及文件
)
as
begin
declare @sql_str nvarchar(500)
declare @str varchar(100)
   set nocount on
   set @sql_str ='backup database gov2014 to disk='''+@backupfilename+''''
   exec sp_executesql @sql_str
   set @str=convert(varchar,getdate(),120)
   exec sys_setparam 'sys_db','lastbackupdt',@str
	set @str = '['+@account+']执行备份数据库操作'
	execute sys_addlog 1,"添加",@account,@str
   set nocount off
end
GO
