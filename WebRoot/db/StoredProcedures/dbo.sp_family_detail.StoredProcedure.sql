USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_family_detail]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
农户信息报告输出
exec sp_family_detail '320826103201007'
*/

CREATE      proc [dbo].[sp_family_detail](
@hm varchar(20)
)
as
begin
declare @curmans int--总人口
declare @inTotal float
declare @inPersonal float
declare @curYear int
declare @labnum int --劳动力人口
	set nocount on
	select @curYear=isnull(max(year),2000) from familyyear where hm = @hm
	select @curMans =isnull(count(1),0) from familymember where hm =@hm
	select @labnum =isnull(count(1),0) from familymember where hm =@hm and labors = 1
	if @curMans >0 
		set @inPersonal = @inTotal/@curMans
	else
		set @inPersonal = @inTotal
	select @inTotal = isnull(incrop+inlivstock+inwork+inbla+insubside+inother,0) from familyyear where hm = @hm and year = @curyear
	--
	select hm,hname,zhu,
		@curmans population,@labnum labornum,fields,house,property,telnum,dcause,idcno,frname,frtel,frwork,
		@curYear lastyear,@intotal intotal,@inPersonal inpersonal
		from family where hm = @hm
	
	select mid,uname,dbo.fn_sex(sex) sex,byear year,dbo.fn_yes(school) school,dbo.fn_education(education) education,
		dbo.fn_healthy(hearth) health,dcno,dbo.fn_labor(labors) labors,dbo.fn_work(works) works,dbo.fn_yes(bla) bla,tbfd 
		from familymember where hm = @hm
	/*select hm,year,intotal,incrop,inlivstock,inwork,inbla,insubside,inother,inpersonal,grantaid,share,pettyloan,labtrain,labjob from familyyear
		 where hm = @hm order by year*/
		select a.year,b.intotal,b.incrop,b.inlivstock,b.inwork,b.inbla,b.insubside,b.inother,b.inpersonal,b.grantaid,b.share,
			b.pettyloan,labtrain,b.labjob,a.edit from ((select rid year,edit from reportlist where subtag  = 'year_items' and display = 1) a left join
		(select * from familyyear where hm = @hm) b on a.year = b.year)
	set nocount off
		
end
GO
