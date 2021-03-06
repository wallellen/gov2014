USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sys_param_set]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
设置系统的参数
    @msgtype:消息类型
*/

CREATE  proc [dbo].[sys_param_set](
@lockyear int,--是否锁定
@workyear int--工作年
)
as
begin
declare @str varchar(100)
	set @str=ltrim(str(@workyear))
	exec sys_setparam 'system','workyear',@str
	set @str=ltrim(str(@lockyear))
	exec sys_setparam 'system','lockyear',@str

end
GO
