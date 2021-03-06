USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[mp_calc_family]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
家庭信息人口及劳动力重新计算
*/
CREATE  proc [dbo].[mp_calc_family](
@account varchar(30)--操作帐号

)                  
as
begin
declare @str nvarchar(200)
   set nocount on
	update family set population=isnull(b.rn,0),labornum=isnull(b.ll,0) 
		from family a left join (select hm,count(1) rn,sum(case when labors =1 then 1 else 0 end) ll from familymember group by hm) b on a.hm=b.hm
   set nocount off
end
GO
