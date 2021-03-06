USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_report_delete]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
删除指定报告项目
select * from reportlist 
exec sp_report_list 'chunprj_items',1
*/
CREATE  proc [dbo].[sp_report_delete](
@subtag varchar(30),
@rid int
)
as
begin
 set nocount on
	delete reportlist where subtag = @subtag and rid = @rid
set nocount off
end
GO
