USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_log_query_page]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--exec sp_syslog_query_page 'admin',1,'2013-05-10','2013-05-10',null,null,1,20

/*系统日志--条件查询*/
CREATE       proc [dbo].[sys_log_query_page](
@account varchar(16),          --查询帐号
@roleid int,                   --角色类型,1:为全部部门信息查询,2:只查询该帐号下所分配的部门列表
@startdate varchar(16),        --查询开始日期
@enddate varchar(16),           --查询结束日期
@msgtype int=null,             --查询消息类型
@sender varchar(64)=null,            --查询消息来源
@pageCurrent int=1,               --当前页,为0时,则不做分页处理
@PageSize int=15              --每页行数
) as
begin
declare @startdt varchar(32)
declare @enddt varchar(32)
declare @msgbody varchar(100)
--
declare @sql_str nvarchar(2000)
   set @startdt = @startdate +' 00:00:00' 
   set @enddt= @enddate+' 23:59:59'
   if @roleid = 1 --系统管理员
   begin
      if @pagesize <=3 or @pagesize is null
      set @pagesize =3
      if @pageCurrent is null set @pageCurrent =1
      set @sql_str = 'select logid,sender,msgtype,convert(varchar(19),occdt,120) occdt,detail content from sys_log '
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
      if @pagecurrent = 0 
      begin
         set @sql_str =@sql_str +' order by logid desc'
         exec sp_executesql @sql_str
      end
      else
         exec showpages @sql_str,@PageSize,@pageCurrent,'logid,sender,msgtype,occdt,content','logid desc'
                  --(sender = @sender or @sender is null) order by occdt desc
      end
end
GO
