USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_database_truncatelog]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*s数据库维护页面--清空日志，收缩数据库
exec sys_database_truncatelog 'admin',1
*/
CREATE       proc [dbo].[sys_database_truncatelog](
@account varchar(64),--备份帐号
@roleid int --角色类型
)
as
begin
--declare @sql_str nvarchar(2000)
   declare @str varchar(100)
   set nocount on
   backup log  gov2014 with no_log--清空日志
   DBCC SHRINKDATABASE (farmer2014)--收缩数据库
   set @str=convert(varchar,getdate(),120)
   exec sys_setparam 'sys_db','lasttrunkdt',@str
   set nocount off
end
GO
