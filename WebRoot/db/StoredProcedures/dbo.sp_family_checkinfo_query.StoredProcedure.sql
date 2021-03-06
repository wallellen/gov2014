USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_family_checkinfo_query]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
查询指定家庭审查信息
*/

CREATE proc [dbo].[sp_family_checkinfo_query](
@hm varchar(30)--户码
)                  
as
begin
	set nocount on
	if exists(select 1 from familycheckinfo where hm = @hm)
	begin
		select code,info from familycheckinfo where hm = @hm
	end
   set nocount off
end
GO
