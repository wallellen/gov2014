USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_jiangbu_items]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
查询指定村编码的将补到户情况
exec sp_jiangbu_list '320703001200',1
*/
CREATE     proc [dbo].[sp_jiangbu_items](
@bm varchar(20)
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @sql nvarchar(500)
 set nocount on
	if exists(select 1 from govdata where bm =@bm)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid from govdata where bm = @bm
		select 1 rid,'2014年上半年' title,'2014-01-01' startdt,'2014-06-30' enddt,1 edit
	end
set nocount off
end
GO
