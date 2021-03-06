USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_database_query]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--select dbo.sys_getparam('sys_db','lastbackupdt')


/*
exec sys_database_query 'admin',1,null,null,null,null,null
数据库维护页面--信息查询
*/
CREATE              proc [dbo].[sys_database_query](
@account varchar(64),--备份帐号
@roleid int, --角色类型
@serverinfo varchar(100) out,
@databasename varchar(60) out,
@lastbackupdt varchar(32) out,
@lasttrunkdt varchar(32) out,
@defbackupfilename varchar(200) out
)
as
begin
   set @serverinfo='SQL SERVER 2000'
   set @databasename = 'gov2014'
   set @lastbackupdt=dbo.sys_getparam('sys_db','lastbackupdt')
   set @lasttrunkdt=dbo.sys_getparam('sys_db','lasttrunkdt')
   set @defbackupfilename='d:\db_backup2014_'+convert(varchar,getdate(),112)+'.bak'
   select rtrim(name) name,rtrim(filename) filename,size from sysfiles
end
GO
