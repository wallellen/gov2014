USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_keyprj_detail]    Script Date: 06/17/2014 09:13:20 ******/
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
exec sp_keyprj_detail '320803',1
select * from family where hm like '320703001200%'
*/
CREATE      proc [dbo].[sp_keyprj_detail](
@bm varchar(20),--查询的县编码
@rid int --修改乡镇关键项目实施情况，加报告ID
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @l int
declare @sql nvarchar(1000)
 set nocount on
	if exists(select 1 from govdata where bm =@bm)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@l=ol from govdata where bm = @bm
		--返回当前项目
		if @l <3
		set @sql = 'select b.bm,b.oname,a.rn,dbo.formatmoney(a.prt) prt,dbo.formatmoney(a.spr) spr,dbo.formatmoney(a.sspr) sspr,dbo.formatmoney(a.opr) opr,dbo.formatmoney(a.pyt) pyt,dbo.formatmoney(a.spy) spy from (select '
		+case @l when 1 then'ssid id,'
					when 2 then 'xid id,'
		end
		+'count(1) rn,sum(prt) prt,sum(spr) spr,sum(sspr) sspr,sum(opr) opr,sum(pyt) pyt,sum(spy) spy'
		+' from xiangkeyprj where rid ='+ltrim(str(@rid))+' and sid='+ltrim(str(@sid))
		+case @l when 1 then ' group by ssid'
					when 2 then ' and ssid='+ltrim(str(@ssid))+' group by xid'
		end
		+') a join (select '
		+case @l when 1 then 'ssid id,'
					when 2 then 'xid id,'
		end
		+'bm,oname from govdata where sid='+ltrim(str(@sid))
		+case @l when 1 then ' and ssid>0 and xid=0'
					when 2 then ' and ssid='+ltrim(str(@ssid)) + ' and xid>0 and xxid = 0'
		end
		+') b on a.id = b.id'
		else if @l = 3 --县级帐号显示明细
			set @sql = 'select pid,bm,own oname,itemname,dbo.formatmoney(prt) prt,dbo.formatmoney(spr) spr,dbo.formatmoney(sspr) sspr,dbo.formatmoney(opr) opr,'
			+'dbo.formatmoney(pyt) pyt,dbo.formatmoney(spy) spy,yt,yp,np,rdt from xiangkeyprj '
			+'where sid='+ltrim(str(@sid))+' and ssid = '+ltrim(str(@ssid))+' and xid = '+ltrim(str(@xid))+' and rid = '+ltrim(str(@rid))+' order by rdt'
		exec (@sql)
	end
set nocount off
end
GO
