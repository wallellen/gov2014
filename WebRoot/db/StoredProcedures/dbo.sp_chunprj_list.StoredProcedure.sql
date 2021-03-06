USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_chunprj_list]    Script Date: 06/17/2014 09:13:20 ******/
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
*/
CREATE       proc [dbo].[sp_chunprj_list](
@xxm varchar(20),--查询的县编码
@rid int--报告编号
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
	if exists(select 1 from govdata where bm =@xxm) and len(@xxm) =9
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid from govdata where bm = @xxm
		--返回当前项目
		select a.pid,a.bm,b.oname,a.pname,a.pcontent,dbo.formatmoney(a.prt) prt,dbo.formatmoney(a.pr) pr,dbo.formatmoney(a.spr) spr,
			dbo.formatmoney(a.sspr) sspr,dbo.formatmoney(a.xpr) xpr,
			dbo.formatmoney(a.xxpr) xxpr,dbo.formatmoney(a.opr) opr,
			dbo.formatmoney(a.fpr) fpr,dbo.formatmoney(a.wpr) wpr,dbo.formatmoney(a.yfi) yfi,dbo.formatmoney(a.afi) afi,dbo.formatmoney(a.lyi) lyi,
			convert(varchar(20),a.o2015,23) o2015,a.sprp,a.pp,a.rdt from chunprj a left join 
			(select bm,oname from govdata where sid=@sid and ssid = @ssid and xid =@xid and xxid=@xxid and cid > 0) b 
				on a.bm = b.bm where a.sid=@sid and a.ssid = @ssid and a.xid = @xid and a.xxid=@xxid and rid =@rid order by a.rdt
		--返回该县乡镇列表,用于添加
		select bm,oname from govdata where sid=@sid and ssid = @ssid and xid =@xid and xxid=@xxid and cid > 0 order by bm
	end
set nocount off
end
GO
