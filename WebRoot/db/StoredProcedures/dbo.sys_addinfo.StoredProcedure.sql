USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_addinfo]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*添加系统操作日志
    @msgtype:消息类型
*/
-- execute sys_addinfo 1,"登录",'aaa','bbb'
create  proc [dbo].[sys_addinfo](
    @msgbody varchar(250))--消息内容
as
begin
declare @maxid int
   select @maxid =isnull(max(logid),0)+1 from sys_log
   insert into sys_log(logid,occdt,msgtype,opcode,sender,detail,lookit) 
      values(@maxid,getdate(),1,'info','default',@msgbody,0);
  -- commit;
end
GO
