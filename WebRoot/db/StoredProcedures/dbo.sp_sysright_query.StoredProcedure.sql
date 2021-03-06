USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_sysright_query]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
添加家庭信息
exec sp_sysright_query "32","3208"
select top  10 * from family
*/
CREATE   proc [dbo].[sp_sysright_query](
@account varchar(30),--操作帐号
@bm	varchar(30)--要查询的编码号
)
as
begin
declare @len int
declare @edit int
	set @len = len(@account)
	--select case when exists(select 1 from govdata where bm=@bm) then '1' else '0' end
	if (@account = left(@bm,@len))
		if (exists(select 1 from govdata where bm=@bm))
			select isnull(edit,0) edit from govdata where bm =@bm
		else
			select 0 edit
	else
		select 0 edit  
end
GO
