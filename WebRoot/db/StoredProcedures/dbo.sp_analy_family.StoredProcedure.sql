USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_analy_family]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
条件统计农户数
aid:
1:根据人口统计农户数
2:指定年总收入统计农户数,Param为年
3:指定年人均收入统计农户数,Param为年
4:耕地
5:住房面积
6:劳动力
exec sp_analy_family 3208,1,'3,5,8',null
exec sp_analy_family 3208,2,'3000,5000,8000',2013
exec sp_analy_family 3208,3,'3000,5000,8000',2013
exec sp_analy_family 3208,4,'1,2,3',null
exec sp_analy_family 3208,5,'50,80,100',null
exec sp_analy_family 3208,6,'1,2,3',null
*/
CREATE   proc [dbo].[sp_analy_family](
@bm varchar(20),--当前编码
@aid int,--统计编号
@tjstr varchar(100),
@param int
)
as
declare @l int
declare @hms varchar(60)
declare @itn int
declare @cn int
declare @cval int
declare @lval int
declare @sql nvarchar(1000)
declare @sqls nvarchar(200)
declare @sqli nvarchar(200)
begin
	set nocount on
	if exists(select 1 from govdata where bm =@bm)
	begin
		set @itn = dbo.get_itemcount(@tjstr,',')
		set @cn =0
		while @cn <@itn
		begin
			set @cval = dbo.get_itemstr(@tjstr,@cn+1,',')
			if @cn = 0 
			begin
				set @sqli = 'insert into #t(v'+ltrim(str(@cn))
				set @sql = 'select sum(case when val <='+ltrim(str(@cval))+' then 1 else 0 end) v0'
				set @sqls = 'select ''<='+ltrim(str(@cval))+''' at,v'+ltrim(str(@cn)) +' val from #t'
			end
			else
			begin
				set @sqli = @sqli+',v'+ltrim(str(@cn))
				set @sql = @sql+',sum(case when val >'+ltrim(str(@lval))+' and val <='+ltrim(str(@cval))+
					' then 1 else 0 end) v' +ltrim(str(@cn))
				set @sqls = @sqls +' union select ''>'+ltrim(str(@lval))+'<='+ltrim(str(@cval))+''' at,v'+ltrim(str(@cn))+' val from #t'
			end
			set @lval=@cval
			set @cn = @cn+1
		end
		set @sqli = @sqli+',v'+ltrim(str(@cn))+')'
		set @sql =@sql +',sum(case when val >'+ltrim(str(@cval))+' then 1 else 0 end) v'+ltrim(str(@cn))
			+' from ('+case @aid when 1 then 'select count(1) val,hm from familymember where hm like '''+@bm+'%'' group by hm'
						  				when 2 then 'select inTotal  val,hm from familyyear where hm like '''
														+@bm+'%'' and year='+ltrim(str(@param))+'' 
										when 3 then 'select (isnull(d.inTotal,0)/c.population) val from '+
													'(select hm,(case when population=0 then 1 else population end) population from family where hm like '''+
															@bm+'%'') c '
													+'left join (select inTotal,hm from familyyear where year = '
														+ltrim(str(@param))+' and hm like '''+@bm+'%'') d '+
													'on c.hm = d.hm'
										when 4 then 'select fields val from family where hm like '''+@bm+'%'''
										when 5 then 'select house val from family where hm like '''+@bm+'%'''
										when 6 then 'select labornum val from family where hm like '''+@bm+'%'''
										else ''
										end
			+') a' 
		set @sqls = @sqls +' union select ''>'+ltrim(str(@cval))+''' at,v'+ltrim(str(@cn))+' val from #t'
		--
		set @sql =@sqli +' '+@sql
		--select top 10  * from familyyear 
		create table #t(v0 int,v1 int,v2 int,v3 int,v4 int,v5 int,v6 int,v7 int)
		exec (@sql)
		exec(@sqls)
		drop table #t
	end
	set nocount off
end
GO
