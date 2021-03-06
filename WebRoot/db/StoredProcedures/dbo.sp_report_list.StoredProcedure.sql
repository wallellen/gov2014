USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_report_list]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
查询报告项目列表
select * from reportlist 
exec sp_report_list 'chunprj_items',1
subtag:
chunprj_items:村级项目
hourfang_items:后方单位
jiangbu_items:奖补到户
keyprj_items:关键项目
year_items:家庭年收入
*/
CREATE   proc [dbo].[sp_report_list](
@subtag varchar(30),
@showall int
)
as
begin
 set nocount on
	if @showall = 1
		select  rid,title,fdt,tdt,edit,display from reportlist where subtag = @subtag
	else 
		select  rid,title,fdt,tdt,edit from reportlist where subtag = @subtag and display = 1
set nocount off
end
GO
