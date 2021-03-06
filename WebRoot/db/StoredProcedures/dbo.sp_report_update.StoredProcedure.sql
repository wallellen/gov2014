USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_report_update]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
报告项目修改
select * from reportlist 
exec sp_report_list 'chunprj_items',1
exec sp_report_update 'chunprj_items',1,'2014年春季','2014-01-01','2014-03-31',0,1
*/
CREATE     proc [dbo].[sp_report_update](
@subtag varchar(30),
@rid int,
@title varchar(100),
@fdt varchar(30),
@tdt varchar(30),
@edit int,
@display int
)
as
begin
 set nocount on
	if @rid is null or @rid = 0
		select @rid =isnull(max(rid),0)+1 from reportlist where subtag = @subtag
	if exists(select 1 from reportlist where subtag = @subtag and rid=@rid )
		update reportlist set title=@title,fdt=@fdt,tdt=@tdt,display=@display,edit=@edit where subtag = @subtag and rid=@rid
	else
		insert into reportlist(subtag,rid,title,fdt,tdt,display,edit) values (@subtag,@rid,@title,@fdt,@tdt,@edit,@display)
set nocount off
end
GO
