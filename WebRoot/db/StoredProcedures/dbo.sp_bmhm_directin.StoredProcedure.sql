USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_bmhm_directin]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
确定指定编码及户码能否直接进入
exec sp_bmhm_directin '32','32','3208'
*/
CREATE  proc [dbo].[sp_bmhm_directin](
@account varchar(60),
@rootbm varchar(20),
@bmhm varchar(20)--当前编码
)
as
begin
declare @ln int
 set nocount on
	set @ln = len(@rootbm)
	if (left(@bmhm,@ln)= @rootbm)		
	begin
		if exists(select 1 from govdata where bm = @bmhm)
			select 'bm' result
		else if exists(select 1 from family where hm = @bmhm )
			select 'hm' result
	end
	else
		select 'none' result
/*-----------------返回结果
						none:不能进入
						bm:为组织编码
                  hm:为农户编码
*/
set nocount off
end
GO
