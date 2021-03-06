USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[mp_repair]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
家庭年收入及扶贫情况总收入及人均收入计算
select top 10 * from govdata where ol = 4 and len(oname )>7
select top 10  * from family where len(hname)>10 
exec mp_repair 4,'南通市'
*/
CREATE   proc [dbo].[mp_repair](
@ol int, --级别
@pre varchar(100)
)
as
begin
	set nocount on
	if @ol <=5
	update govdata set oname = replace(oname,@pre,'') where ol  =@ol and oname like @pre+'%'
	else
	update family set hname = rtrim(ltrim(replace(hname,@pre,''))) where hname like @pre+'%'
   set nocount off
end
GO
