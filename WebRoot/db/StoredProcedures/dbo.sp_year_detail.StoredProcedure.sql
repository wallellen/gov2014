USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_year_detail]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
农户信息报告输出
exec sp_year_detail '320826103201007'
*/
CREATE   proc [dbo].[sp_year_detail](
@hm varchar(20)
)
as
begin
	set nocount on
	select year,/*hm,*/intotal,incrop,inlivstock,inwork,inbla,insubside,inother,inpersonal,grantaid,share,pettyloan,labtrain,labjob 
		from familyyear where hm = @hm order by year
	set nocount off
end
GO
