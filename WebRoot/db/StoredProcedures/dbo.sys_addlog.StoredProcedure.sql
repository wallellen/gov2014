USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_addlog]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*添加系统操作日志
execute sys_addlog 1,"登录",'aaa','bbb'
*/

CREATE proc [dbo].[sys_addlog](
@msgtype int,		--消息类型
@opcode varchar(32),--操作代码
@sender varchar(32),--事件来源
@msgbody varchar(250))	--消息内容
as
begin
declare @maxid int
   select @maxid =isnull(max(logid),0)+1 from sys_log
   insert into sys_log(logid,occdt,msgtype,opcode,sender,detail,lookit) 
      values(@maxid,getdate(),@msgtype,@opcode,@sender,@msgbody,0);
end
GO
