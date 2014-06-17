USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_param_query]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*添加系统操作日志
    @msgtype:消息类型
*/
-- execute sys_addlog 1,"登录",'aaa','bbb'
CREATE  proc [dbo].[sys_param_query]
as
begin
   select isnull(dbo.sys_getparam('system','lockyear'),1) lockyear,isnull(dbo.sys_getparam('system','workyear'),year(getdate())) workyear

end
GO
