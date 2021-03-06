USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_chunprj_items]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
查询指定编码的指定年份的扶贫情况
select top 10 * from govdata
select top 10 * from family
select * from FamilyJiangBu
select * from family
select * from xiangkeyprj
exec sp_chunprj_list '320803103'
select * from family where hm like '320703001200%'
exec sp_chunprj_items '320803103'
*/
CREATE  proc [dbo].[sp_chunprj_items](
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
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid from govdata where bm = @bm
		--返回当前项目
		select 1 rid,'2014年春季' title,'2014-01-01' startdt,'2014-03-31' enddt union
		select 2 rid,'2014年夏季' title,'2014-04-01' startdt,'2014-06-30' enddt union
		select 3 rid,'2014年秋季' title,'2014-07-01' startdt,'2014-09-30' enddt
		
	end
set nocount off
end
GO
