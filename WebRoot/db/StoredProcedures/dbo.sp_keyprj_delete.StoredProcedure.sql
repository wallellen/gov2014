USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_keyprj_delete]    Script Date: 06/17/2014 09:13:20 ******/
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
exec sp_keyprj_list '320803'
exec sp_keyprj_update '320803103',null,'AAA',1,2,3,4,5,6,7,8
select * from family where hm like '320703001200%'
*/
CREATE     proc [dbo].[sp_keyprj_delete](
@xxm varchar(20),--要更新或插入的项目所在乡的编码
@rid int,--报告编号
@pid int --项目编号,如果是新建,则项目编号为空
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
 set nocount on
	if exists(select 1 from govdata where bm =@xxm) and len(@xxm) =6
	begin
		select @sid=sid,@ssid=ssid,@xid=xid from govdata where bm = @xxm
		delete xiangkeyprj where sid=@sid and ssid = @ssid and xid = @xid and  rid = @rid and pid = @pid
	end
set nocount off
end
GO
