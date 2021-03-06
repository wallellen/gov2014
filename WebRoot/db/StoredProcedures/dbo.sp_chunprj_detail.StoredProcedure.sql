USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_chunprj_detail]    Script Date: 06/17/2014 09:13:20 ******/
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
select * from chunprj
exec sp_chunprj_detail '320803',1
select * from family where hm like '320703001200%'
*/
CREATE        proc [dbo].[sp_chunprj_detail](
@bm varchar(20),--查询的县编码
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
declare @sql nvarchar(1000)
 set nocount on
	if exists(select 1 from govdata where bm =@bm and cjt = 1)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@l=ol from govdata where bm = @bm
		if @l<4
		set @sql='select b.bm,b.oname,a.rn,dbo.formatmoney(a.prt) prt,dbo.formatmoney(a.pr) pr,dbo.formatmoney(a.spr) spr,dbo.formatmoney(a.sspr) sspr,dbo.formatmoney(a.xpr) xpr,'
		+'dbo.formatmoney(a.xxpr) xxpr,dbo.formatmoney(a.opr) opr,dbo.formatmoney(a.fpr) fpr,dbo.formatmoney(a.wpr) wpr from (select '
		+case @l when 1 then 'ssid id,' 
					when 2 then 'xid id,'
					when 3 then 'xxid id,'
		end
		+'count(1) rn,sum(prt) prt,sum(pr) pr,sum(spr) spr,sum(sspr) sspr,sum(xpr) xpr,sum(xxpr) xxpr,sum(opr) opr,sum(fpr) fpr,sum(wpr) wpr from chunprj'
	   +' where sid ='+ltrim(str(@sid))+' and rid='+ltrim(str(@rid))
		+case @l when 1 then 'group by ssid'
					when 2 then ' and ssid ='+ltrim(str(@ssid))+' group by xid'
					when 3 then ' and ssid ='+ltrim(str(@ssid))+' and xid='+ltrim(str(@xid))+' group by xxid'
		end
		+' ) a right join (select '
		+case @l when 1 then 'ssid id,'
					when 2 then 'xid id,'
					when 3 then 'xxid id,'
		end
		+'bm,oname from govdata where cjt =1 and sid='+ltrim(str(@sid))
		+case @l when 1 then ' and ssid>0 and xid =0'
					when 2 then ' and ssid='+ltrim(str(@ssid))+' and xid >0 and xxid =0'
					when 3 then ' and ssid='+ltrim(str(@ssid))+' and xid ='+ltrim(str(@xid))+' and xxid >0 and cid=0'
		end
		+') b on a.id=b.id'
		else if @l=4
			set @sql='select a.pid,a.bm,b.oname,a.pname,a.pcontent,dbo.formatmoney(a.prt) prt,dbo.formatmoney(a.pr) pr,dbo.formatmoney(a.spr) spr,'
			+'dbo.formatmoney(a.sspr) sspr,dbo.formatmoney(a.xpr) xpr,'
			+'dbo.formatmoney(a.xxpr) xxpr,dbo.formatmoney(a.opr) opr,'
			+'dbo.formatmoney(a.fpr) fpr,dbo.formatmoney(a.wpr) wpr,dbo.formatmoney(a.yfi) yfi,dbo.formatmoney(a.afi) afi,dbo.formatmoney(a.lyi) lyi,'
			+'convert(varchar(20),a.o2015,23) o2015,a.sprp,a.pp,a.rdt from chunprj a left join '
			+'(select bm,oname from govdata where sid='+ltrim(str(@sid))+' and ssid = '+ltrim(str(@ssid))+' and xid ='+ltrim(str(@xid))
			+' and xxid='+ltrim(str(@xxid))+' and cid > 0) b '
			+'	on a.bm = b.bm where a.sid='+ltrim(str(@sid))+' and a.ssid = '+ltrim(str(@ssid))+' and a.xid = '+ltrim(str(@xid))
			+' and a.xxid='+ltrim(str(@xxid))+' and rid ='+ltrim(str(@rid))+' order by a.rdt'
		exec (@sql)
		if @l = 4 --   针对乡级显示村用于添加项目
			select bm,oname from govdata where sid=@sid and ssid = @ssid and xid =@xid and xxid=@xxid and cid > 0 and cjt = 1 order by bm
	end
set nocount off
end
GO
