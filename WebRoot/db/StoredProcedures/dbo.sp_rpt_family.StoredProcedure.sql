USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_rpt_family]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
农户信息报告输出
exec sp_rpt_family '320111001020001'
*/
CREATE          proc [dbo].[sp_rpt_family](
@hm varchar(20)
)
as
begin
declare @curyear int
	set nocount on
	select @curyear = year(getdate())
	select (select oname from govdata where bm = left(@hm,6)) x,
		(select oname from  govdata where bm = left(@hm,9)) xx,
		(select oname from govdata where bm = left(@hm,12)) c,isnull(zhu,'') z,@curyear-3 y1,@curyear-2 y2,@curyear-1 y3,@curyear y4,@curyear+1 y5, left(@hm,6) xm,
		substring(@hm,7,3) xxm,substring(@hm,10,3) cm,substring(@hm,13,3) hm,
		population,labornum,fields,house,property,telnum,dcause,idcno,frname,frtel,frwork
		from family where hm = @hm
	select uname,dbo.fn_sex(sex) sex,(@curyear-byear+1) age,dbo.fn_yes(school) school,/*dbo.fn_education(education)*/ education,
		/*dbo.fn_healthy(hearth)*/ hearth,dcno,/*dbo.fn_labor(labors) */labors,/*dbo.fn_work(works)*/ works,dbo.fn_yes(bla) bla, tbfd 
		from familymember where hm = @hm
	select * into #t from familyyear where hm=@hm
	--select '指标名称' ids,'单位' unit,'0代码' code ,'2012' v1,'2013' v2,'2014' v3,'2015' v4,'2016' v5 union
	select c.ids,c.unit,c.id code,isnull(b.v1,0) v1,isnull(b.v2,0) v2,isnull(b.v3,0) v3,isnull(b.v4,0) v4,isnull(b.v5,0) v5 from
	(	select 1 id,'全年家庭纯收入' ids,'元' unit union
		select 2 id,'种植业纯收入' ids,'元' unit union
		select 3 id,'养殖业纯收入' ids,'元' unit	union
		select 4 id,'务工收入' ids,'元' unit union
		select 5 id,'低保、五保、残疾补助金及养老金收入' ids,'元' unit union
		select 6 id,'补贴性收入' ids,'元' unit union
		select 7 id,'其他收入' ids,'元' unit union
		select 8 id,'家庭人均纯收入' ids,'元' unit union
		select 9 id,'无偿帮扶资金' ids,'元'unit union
		select 10 id,'得到股份' ids,'元' unit union
		select 11 id,'小额贷款和互助资金' ids,'元' unit union
		select 12 id,'劳动力转移培训' ids,'人' unit union
		select 13 id,'劳动力转移就业人数' ids,'人' unit) c left join 
	(select id,
			max(case year when @curyear-3 then val else 0 end) as v1,
			max(case year when @curyear-2 then val else 0 end) as v2,
			max(case year when @curyear-1 then val else 0 end) as v3,	
			max(case year when @curyear then val else 0 end) as v4,
			max(case year when @curyear+1 then val else 0 end) as v5 from
	(select 1 id,year,str(intotal) val from #t union
		select 2 id,year,str(incrop) val from #t union
		select 3 id,year,str(inlivstock) val from #t union
		select 4 id,year,str(inwork) val from #t union
		select 5 id,year,str(inbla) val from #t union
		select 6 id,year,str(insubside) val from #t union
		select 7 id,year,str(inother) val from #t union
		select 8 id,year,str(inpersonal) val from #t union
		select 9 id,year,str(grantaid) val from #t union
		select 10 id,year,str(share) val from #t union
		select 11 id,year,str(pettyloan) val from #t union
		select 12 id,year,str(labtrain) val from #t union
		select 13 id,year,str(labjob) val from #t) a  group by id ) b on c.id=b.id
		order by code
	drop table #t
	set nocount off
		
end
GO
