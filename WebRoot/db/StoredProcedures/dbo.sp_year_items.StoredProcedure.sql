USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_year_items]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
查询指定编码的指定年份的扶贫情况
exec sp_year_items '320803'
*/
CREATE proc [dbo].[sp_year_items](
@bm varchar(20)--查询的县编码
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @l int
declare @sql nvarchar(500)
 set nocount on
	if exists(select 1 from govdata where bm =@bm)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid from govdata where bm = @bm
		--返回当前项目
		select 2011 year,'2011年家庭收入及扶贫情况' title,'2011-01-01' startdt,'2011-12-31' enddt,0 edit union
		select 2012 year,'2012年家庭收入及扶贫情况' title,'2012-01-01' startdt,'2012-12-31' enddt,0 edit union
		select 2013 year,'2013年家庭收入及扶贫情况' title,'2013-01-01' startdt,'2013-12-31' enddt,0 edit union
		select 2014 year,'2014年家庭收入及扶贫情况' title,'2014-01-01' startdt,'2014-12-31' enddt,1 edit
	end
set nocount off
end
GO
