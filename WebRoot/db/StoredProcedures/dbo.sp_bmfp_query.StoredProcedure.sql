USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_bmfp_query]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
查询指定编码的指定年份的扶贫情况
select top 10 * from govdata
select top 10 * from family
exec sp_bmfp_query '32',2013
*/
CREATE   proc [dbo].[sp_bmfp_query](
@bm varchar(20),--当前编码
@year int--要查询的年份
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
	if exists(select 1 from govdata where bm =@bm)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@l=ol from govdata where bm = @bm
		create table #t(v1 int,v2 int,v3 int,v4 int,v5 int,t1 int,t2 int,t3 int,t4 int,t5 int)
		set @sql = 'insert into #t(v1,v2,v3,v4,v5,t1,t2,t3,t4,t5) select sum(case when grantaid >0 then 1 else 0 end) v1,sum(case when share >0 then 1 else 0 end) v2,'
			+'sum(case when pettyloan > 0 then 1 else 0 end ) v3,sum(case when labTrain >0 then 1 else 0 end ) v4,'
			+'sum(case when labJob >0 then 1 else 0 end) v5,sum(grantaid) t1,sum(share) t2,sum(pettyloan) t3,sum(labtrain) t4,sum(labJob) t5 '
			+'from familyyear where year='+ltrim(str(@year))+' and sid='+ltrim(str(@sid))
			+case when @l >1 then ' and ssid='+ltrim(str(@ssid)) else '' end
			+case when @l>2 then ' and xid='+ltrim(str(@xid)) else '' end
			+case when @l>3 then ' and xxid='+ltrim(str(@xxid)) else '' end
			+case when @l>4 then ' and cid='+ltrim(str(@cid)) else '' end
		exec (@sql)
	--	select substring(@sql,1,200),substring(@sql,201,200),substring(@sql,401,200)
		select '无偿帮扶' name,v1 hnum,t1 val from #t union
		select '股分分红' name,v2 hnum,t2 val from #t union
		select '小额贷款' name,v3 hnum,t3 val from #t union
		select '转移培训' name,v4 hnum,t4 val from #t union
		select '转移就业' name,v5 hnum,t5 val from #t
		drop table #t
	end
set nocount off
end
GO
