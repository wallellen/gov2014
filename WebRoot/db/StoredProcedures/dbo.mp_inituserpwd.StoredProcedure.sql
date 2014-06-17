USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[mp_inituserpwd]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
管理员初始化帐号密码
exec sp_sysinitpwd '32','32'
*/
CREATE  proc [dbo].[mp_inituserpwd](
@account varchar(30),--操作帐号
@bm	varchar(30)--要初始化的部门帐号
)
as
begin
declare @len int
declare @edit int
	set @len = len(@account)
	if (@account = left(@bm,@len))
		if (exists(select 1 from govdata where bm=@bm))
			update govdata set pwd = '123456' where bm = @bm
end
GO
