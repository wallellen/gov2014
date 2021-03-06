USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_log_query_page_t]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--exec sp_syslog_query_page_t 'admin',1,'2013-06-04','2013-06-04',null,null,20

/*系统日志--条件查询*/
CREATE          proc [dbo].[sys_log_query_page_t](
@account varchar(16),          --查询帐号
@roleid int,                   --角色类型,1:为全部部门信息查询,2:只查询该帐号下所分配的部门列表
@startdate varchar(16),        --查询开始日期
@enddate varchar(16),           --查询结束日期
@msgtype int=null,             --查询消息类型
@sender varchar(64)=null,            --查询消息来源
@PageSize int=15,              --每页行数
@TotalPages int=null out           --总页数
) as
begin
declare @startdt varchar(32)
declare @enddt varchar(32)
declare @msgbody varchar(100)
--
declare @totalRownnum int
declare @sql_str nvarchar(2000)
   set @startdt = @startdate +' 00:00:00' 
   set @enddt= @enddate+' 23:59:59'
   if @roleid = 1 --系统管理员
   begin
      if @pagesize <=3 or @pagesize is null
      set @pagesize =3
      --if @pageCurrent is null set @pageCurrent =1
      set @sql_str = 'select @a=count(1) from sys_log '
                     +
                     'where (occdt between '''+@startdt+''' and '''+@enddt+''')'
                     +
                     case when @msgtype is null then ''
                     else ' and msgtype = '+convert(varchar(16),@msgtype)
                     end
                     +
                     case when @sender is null then ''
                     else
                        'and sender = '''+@sender+''''
                     end
      --select @sql_str
      exec sp_executesql @sql_str,N'@a int output',@totalRownnum output
      set @TotalPages = ceiling(@totalRownnum/(@pagesize+0.0))
   --select @TotalPages
end
end
GO
