USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_analy_family_group]    Script Date: 06/17/2014 09:13:20 ******/
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
---------------------
7:家庭属性
8:贫困原因
9:扶贫情况
exec sp_analy_family_group 320803103,1,'3,5,8',null
exec sp_analy_family_group 32,2,'3000,5000,8000',2013
exec sp_analy_family_group 3208,3,'3000,5000,8000',2013
exec sp_analy_family_group 3208,4,'1,2,3',null
exec sp_analy_family_group 3208,5,'50,80,100',null
exec sp_analy_family_group 3208,6,'1,2,3',null
select * from family
exec sp_analy_family_group 3208,7,'1,2,3',null
exec sp_analy_family_group 3208,8,'1,2,3',null
exec sp_analy_family_group 3208,9,'1,2,3',2013
*/
CREATE  proc [dbo].[sp_analy_family_group](
@bm varchar(20),--当前编码
@aid int,--统计编号
@tjstr varchar(100),
@param int
)
as
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @l int
declare @itn int
declare @cn int
declare @cval int
declare @lval int
declare @sql nvarchar(1000)
declare @sm varchar(20)
declare @con varchar(100)
declare @conx varchar(100)
begin
	set nocount on
	if exists(select 1 from govdata where bm =@bm)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@l=ol from govdata where bm = @bm
		set @itn = dbo.get_itemcount(@tjstr,',')
		set @cn =0
		set @sm = case @l when 1 then 'ssid'
							   when 2 then 'xid'
								when 3 then 'xxid'
								when 4 then 'cid' end
		set @con ='where sid='+ltrim(str(@sid))
					+ case when @l >1 then ' and ssid='+ltrim((@ssid)) else '' end
					+ case when @l >2 then ' and xid='+ltrim(str(@xid)) else '' end
					+ case when @l >3 then ' and xxid='+ltrim(str(@xxid)) else '' end
		set @conx ='where '
					+ case @l 
							when  1 then 'sid='+ltrim(str(@sid))+' and ssid <> 0 and xid=0'
							when 2 then 'sid='+ltrim(str(@sid))+' and ssid='+ltrim(str(@ssid))+' and xid<>0 and xxid=0'
							when 3 then 'sid='+ltrim(str(@sid))+' and ssid='+ltrim(str(@ssid))+' and xid='+ltrim(str(@xid))+' and xxid<>0 and cid=0'
							when 4 then 'sid='+ltrim(str(@sid))+' and ssid='+ltrim(str(@ssid))+' and xid='+ltrim(str(@xid))+' and xxid='+ltrim(str(@xxid))+' and cid<>0'
							end
		if @aid <=6
		begin
			while @cn <@itn
			begin
				set @cval = dbo.get_itemstr(@tjstr,@cn+1,',')
				if @cn = 0 
				begin
					set @sql = 'select e.oname,b.* from (select a.'+@sm+',sum(case when val <='+ltrim(str(@cval))+' then 1 else 0 end) [<='+ltrim(str(@cval))+']'
				end
				else
				begin
					set @sql = @sql+',sum(case when val >'+ltrim(str(@lval))+' and val <='+ltrim(str(@cval))+
						' then 1 else 0 end) [>'+ltrim(str(@lval))+'<='+ltrim(str(@cval))+']'
				end
				set @lval=@cval
				set @cn = @cn+1
			end
			set @sql =@sql +',sum(case when val >'+ltrim(str(@cval))+' then 1 else 0 end) [>'+ltrim(str(@cval))+']'
				+' from ('+case @aid when 1 then 'select population val,'+@sm+
													' from family ' + @con
							  				when 2 then 'select inTotal  val,'+@sm
													+' from familyyear '+@con + ' and year='+ltrim(str(@param))
											when 3 then 'select (isnull(d.inTotal,0)/c.population) val,c.'+@sm+' from '+
														'(select '+@sm+',hm,(case when population=0 then 1 else population end) population from family where hm like '''+
																@bm+'%'') c '
														+'left join (select inTotal,hm from familyyear '+@con+' and year = '
															+ltrim(str(@param))+') d '+
															'on c.hm = d.hm'
											when 4 then 'select fields val,'+@sm+' from family '+@con
											when 5 then 'select house val,'+@sm+' from family '+@con
											when 6 then 'select labornum val,'+@sm+' from family '+@con
											else ''
											end
				+') a group by ' +@sm +') b right join ' 
				+'(select '+@sm+',oname from govdata '+@conx+') e on b.'+@sm +'=e.'+@sm
		end
		else if @aid <=8
		begin
			set @sql  ='select a.oname,b.* from '
			+'(select '+@sm+',oname from govdata '+@conx+') a left join'
			+'(select '+@sm
				+case  @aid when 7 then ','+dbo.fn_getsumstr('property',3)
								when 8 then ','+dbo.fn_getsumstr('dcause',8)
					else ''
					end
				+' from family '+@con
	 			+' group by '+@sm+') b on a.'+@sm+'=b.'+@sm
		end
		else if @aid=9
		begin
			set @sql  ='select a.oname,b.* from '
			+'(select '+@sm+',oname from govdata '+@conx+') a left join'
			+'(select '+@sm
				+',sum(case when grantaid >0 then 1 else 0 end) [无偿帮扶],sum(case when share >0 then 1 else 0 end) [股分分红],'
			+'sum(case when pettyloan > 0 then 1 else 0 end ) [小额贷款],sum(case when labTrain >0 then 1 else 0 end ) [转移培训],'
			+'sum(case when labJob >0 then 1 else 0 end) [转移就业]'				
			+' from familyyear '+@con + ' and year='+ltrim(str(@param))
	 			+' group by '+@sm+') b on a.'+@sm+'=b.'+@sm
		end
		exec (@sql)
--select @conx
	end
	set nocount off
end
GO
