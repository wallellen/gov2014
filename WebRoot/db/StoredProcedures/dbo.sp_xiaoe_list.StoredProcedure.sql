USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_xiaoe_list]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
小额贷款省县查看
select * from reportlist 
exec sp_xiaoe_list '320826',2013,1,0
exec sp_report_list 'xianxiaoe_item',0
select * from reportlist  where subtag = 'xianxiaoe_item'
查询模式,0:县查询,@year有效,@month 无效
		  1:省月份查询,@month 为所查询的月份
        2:省年度查询，即当年到今的最后一条记录
*/

CREATE                proc [dbo].[sp_xiaoe_list](
@bm varchar(20),--查询的县编码
@year int,--年份
@month int,--月份
@mode int
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @l int
declare @lh int
declare @lv money
declare @sql nvarchar(500)
declare @maxmonth int--当前最大月份
declare @t table(ssid int,xid int,lh int,lv money,tsh int,tsv money,trh int,trv money,th int,tv money,nh int,nv money,eh int,ev money)
declare @u table (ssid int,xid int,tsh int,tsv money,th int,tv money,lsh int,lsv money)
 set nocount on
	if exists(select 1 from govdata where bm =@bm)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@l=ol from govdata where bm = @bm
		if @mode = 0 and @l =3
		begin
			select a.month,b.lh,dbo.formatMoney(b.lv) lv,b.tsh,dbo.formatMoney(b.tsv) tsv,b.trh,dbo.formatMoney(b.trv) trv,b.th,dbo.formatMoney(b.tv) tv,
				b.nh,dbo.formatMoney(b.nv) nv,b.eh,dbo.formatMoney(b.ev) ev from (select rid/100 year,rid%100 month
			 from reportlist where subtag ='xianxiaoe_item' and rid/100 = @year) a left join
			(select * from xianxiaoe where sid =@sid and ssid = @ssid and xid = @xid) b on a.year = b.year and a.month = b.month
			if @year = 2013 
				set @month = 0
			else
				select @month =isnull(max(month),0)+1 from xianxiaoe where sid =@sid and ssid = @ssid and xid=@xid and year =@year 
			exec sp_xiaoe_calc @bm,@year,@month,null,@lh OUTPUT,@lv OUTPUT
			select @month month,dbo.formatMoney(@lh) lh,dbo.formatMoney(@lv) lv
		end
		else if @mode =1 and @l = 1--省级帐号查询具体月份
		begin
			insert into @t(ssid,xid,lh,lv,tsh,tsv,trh,trv,th,tv,nh,nv,eh,ev) 
				select ssid,xid,sum(lh),sum(lv),sum(tsh),sum(tsv),sum(trh),sum(trv),sum(th),sum(tv),sum(nh),sum(nv),sum(eh),sum(ev) from 
				xianxiaoe where sid=@sid and year = @year and month = @month group by ssid,xid
			insert into @t(ssid,xid,lh,lv,tsh,tsv,trh,trv,th,tv,nh,nv,eh,ev) 
				select ssid,0,sum(lh),sum(lv),sum(tsh),
					sum(tsv),sum(trh),sum(trv),
					sum(th),sum(tv),sum(nh),sum(nv),sum(eh),sum(ev) from 
				@t group by ssid
			insert into @t(ssid,xid,lh,lv,tsh,tsv,trh,trv,th,tv,nh,nv,eh,ev) 
				select 0,0,sum(lh),sum(lv),sum(tsh),
					sum(tsv),sum(trh),sum(trv),
					sum(th),sum(tv),sum(nh),sum(nv),sum(eh),sum(ev) from 
				@t where xid=0
			select a.oname,a.xid,a.bm,isnull(b.lh,0) lh,dbo.formatMoney(isnull(b.lv,0)) lv,isnull(b.tsh,0) tsh,dbo.formatMoney(isnull(b.tsv,0)) tsv,
				isnull(b.trh,0) trh,dbo.formatMoney(isnull(b.trv,0)) trv,isnull(b.th,0) th,dbo.formatMoney(isnull(b.tv,0)) tv,isnull(b.nh,0) nh,
				dbo.formatMoney(isnull(b.nv,0)) nv,
				isnull(b.eh,0) eh,
				dbo.formatMoney(isnull(b.ev,0)) ev from (select 0 ssid,0 xid,'' bm,'全省汇总' oname,0 oid union 
					select ssid,xid,bm,oname,(case ssid when 3 then 1 
															when 8 then 2 
															when 9 then 3
															when 7 then 4
															when 13 then 5
															when 4 then 6
															when 11 then 7
															when 6 then 8
															when 12 then 9 end) * 100+xid oid from govdata where ol in(2,3) and xet = 1 )a 
				left join  @t b  on a.ssid=b.ssid and a.xid=b.xid order by a.oid
		end
		else if @mode =1 and @l = 2--市级帐号查询具体月份
		begin
			insert into @t(ssid,xid,lh,lv,tsh,tsv,trh,trv,th,tv,nh,nv,eh,ev) 
				select ssid,xid,sum(lh),sum(lv),sum(tsh),sum(tsv),sum(trh),sum(trv),sum(th),sum(tv),sum(nh),sum(nv),sum(eh),sum(ev) from 
				xianxiaoe where sid=@sid and ssid=@ssid and  year = @year and month = @month group by ssid,xid
			insert into @t(ssid,xid,lh,lv,tsh,tsv,trh,trv,th,tv,nh,nv,eh,ev) 
				select ssid,0,sum(lh),sum(lv),sum(tsh),
					sum(tsv),sum(trh),sum(trv),
					sum(th),sum(tv),sum(nh),sum(nv),sum(eh),sum(ev) from 
				@t group by ssid
			select a.oname,a.xid,a.bm,isnull(b.lh,0) lh,dbo.formatMoney(isnull(b.lv,0)) lv,isnull(b.tsh,0) tsh,dbo.formatMoney(isnull(b.tsv,0)) tsv,
				isnull(b.trh,0) trh,dbo.formatMoney(isnull(b.trv,0)) trv,isnull(b.th,0) th,dbo.formatMoney(isnull(b.tv,0)) tv,isnull(b.nh,0) nh,
				dbo.formatMoney(isnull(b.nv,0)) nv,
				isnull(b.eh,0) eh,
				dbo.formatMoney(isnull(b.ev,0)) ev from (select ssid,xid,bm,oname from govdata where sid=@sid and ssid=@ssid and ol in(2,3) and xet = 1)a 
				left join  @t b  on a.ssid=b.ssid and a.xid=b.xid
		end
		else if @mode = 2 and @l=1--省级帐号查询全年的情况
		begin
			insert into @u(ssid,xid,tsh,tsv,th,tv,lsh,lsv ) 
				select a.ssid,a.xid,a.tsh,a.tsv,b.th,b.tv,c.tsh lsh,c.tsv lsv from 
					(select ssid,xid,sum(tsh) tsh,sum(tsv) tsv from xianxiaoe where sid=@sid and year = @year group by ssid,xid ) a  inner join 
					(select ssid,xid,th,tv,nh,nv,eh,ev from v_xxe_lm where sid = @sid and year=@year ) b
					 on a.ssid  = b.ssid and a.xid=b.xid inner join 
					(select ssid,xid,sum(tsh) tsh,sum(tsv) tsv from xianxiaoe where sid=@sid and year = @year-1 group by ssid,xid) c
					   on a.ssid=c.ssid and a.xid =c.xid
			insert into @u(ssid,xid,tsh,tsv,th,tv,lsh,lsv) 
				select ssid,0,sum(tsh),sum(tsv),sum(th),
					sum(tv),sum(lsh),sum(lsv) from @u group by ssid
			insert into @u(ssid,xid,tsh,tsv,th,tv,lsh,lsv) 
				select 0,0,sum(tsh),sum(tsv),sum(th),
					sum(tv),sum(lsh),sum(lsv) from @u where xid=0
			select a.oname,a.xid,a.bm,isnull(b.tsh,0) tsh,dbo.formatMoney(isnull(b.tsv,0)) tsv,
				isnull(b.th,0) th,dbo.formatMoney(isnull(b.tv,0)) tv,
				isnull(b.lsh,0) lsh,dbo.formatMoney(isnull(b.lsv,0)) lsv,
				dbo.formatMoney(case when lsv >0 then (tsv*100)/lsv else 0 end)+'%' perc from 
					(select 0 ssid,0 xid,'' bm,'全省汇总' oname,0 oid union select ssid,xid,bm,oname,(case ssid when 3 then 1 
																																				when 8 then 2 
																																				when 9 then 3
																																				when 7 then 4
																																				when 13 then 5
																																				when 4 then 6
																																				when 11 then 7
																																				when 6 then 8
																																				when 12 then 9 end) * 100+xid oid from govdata 
					where ol in(2,3) and xet = 1) a 
				left join  @u b  on a.ssid=b.ssid and a.xid=b.xid order by a.oid
		end
		else if @mode = 2 and @l=2--市级帐号查询全年的情况
		begin
			insert into @u(ssid,xid,tsh,tsv,th,tv,lsh,lsv ) 
				select a.ssid,a.xid,a.tsh,a.tsv,b.th,b.tv,c.tsh lsh,c.tsv lsv from 
					(select ssid,xid,sum(tsh) tsh,sum(tsv) tsv from xianxiaoe where sid=@sid and ssid=@ssid and year = @year group by ssid,xid ) a  inner join 
					(select ssid,xid,th,tv,nh,nv,eh,ev from v_xxe_lm where sid = @sid and ssid=@ssid and year=@year ) b
					 on a.ssid  = b.ssid and a.xid=b.xid inner join 
					(select ssid,xid,sum(tsh) tsh,sum(tsv) tsv from xianxiaoe where sid=@sid and ssid=@ssid and year = @year-1 group by ssid,xid) c
					   on a.ssid=c.ssid and a.xid =c.xid
			insert into @u(ssid,xid,tsh,tsv,th,tv,lsh,lsv) 
				select ssid,0,sum(tsh),sum(tsv),sum(th),
					sum(tv),sum(lsh),sum(lsv) from @u group by ssid
			select a.oname,a.xid,a.bm,isnull(b.tsh,0) tsh,dbo.formatMoney(isnull(b.tsv,0)) tsv,
				isnull(b.th,0) th,dbo.formatMoney(isnull(b.tv,0)) tv,
				isnull(b.lsh,0) lsh,dbo.formatMoney(isnull(b.lsv,0)) lsv,
				dbo.formatMoney(case when lsv >0 then (tsv*100)/lsv else 0 end)+'%' perc from (select ssid,xid,bm,oname from govdata 
					where sid=@sid and ssid=@ssid and ol in(2,3) and xet = 1) a 
				left join  @u b  on a.ssid=b.ssid and a.xid=b.xid	
		end
		else if @mode = 3
		begin
			select rid%100 month,title,fdt,tdt,edit from reportlist where subtag = 'xianxiaoe_item' and rid/100 =@year and display =1
		end
	end
set nocount off
--年，月份,发出户数，发出金额,收回户数，回收金额,上月结余户数，上月结余金额，结余户数，结余金额，未到期户数,未到期金额，逾期户数，逾期金额
end
GO
