USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[mp_calc_year]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
家庭年收入及扶贫情况总收入及人均收入计算
select top 10 * from family
select top 10  * from familyyear where inpersonal >0
select top 10  * from familyyear where inTotal is null 
select max(intotal) from familyyear 
select max(inCrop+InLivStock+inWork+inBla+inSubside+inOther) from familyyear where year = 2012
select * from familyyear where inCrop+InLivStock+inWork+inBla+inSubside+inOther > 1000000
exec mp_calc_year 'aaa',2012
select count(1) from familyyear 
3333333
*/
CREATE    proc [dbo].[mp_calc_year](
@account varchar(30),--操作帐号
@param int --计算指定年
)
as
begin
declare @str nvarchar(200)
   set nocount on
	update familyyear set inTotal =inCrop+InLivStock+inWork+inBla+inSubside+inOther where year = @param
	--select 1
	update familyyear set inPersonal =(case when b.population >1 then a.inTotal/b.population else a.inTotal end) from 
		familyyear a  left join family b on a.hm = b.hm where year = @param
	--select top 10 * from familyyear
	--update familyyear set inTotal = a.inTotal,inPersonal=(case when b.population >1 then a.inTotal/b.population else a.inTotal end)  from 
		--(select hm,(inCrop+InLivStock+inWork+inBla+inSubside+inOther) inTotal from familyyear where year  = @param) a left join family b on a.hm =b.hm
   set nocount off
end
GO
