USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_analy_people_group]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
条件统计人口信息
aid:
1:性别
2:在校生
3:文化程度
4:身体状况
5:劳动力
6:打工状况
7:低保人口
8:年龄
9:领取低保金、残疾金
exec sp_analy_people_group 32,1,null
exec sp_analy_people_group 32,2,null
exec sp_analy_people_group 32,3,null
exec sp_analy_people_group 32,4,null
exec sp_analy_people_group 32,5,null
exec sp_analy_people_group 32,6,null
exec sp_analy_people_group 32,7,null
exec sp_analy_people_group 32,8,null
exec sp_analy_people_group 32,9,null
select dbo.fn_getsumstr('school',2)
select top 10 * from familymember 
*/
CREATE  proc [dbo].[sp_analy_people_group](
@bm varchar(20),--当前编码
@aid int,--统计编号
@tjstr varchar(100)
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
		if @aid <=7 
		begin
			set @sql  ='select a.oname,b.* from '
				+'(select '+@sm+',oname from govdata '+@conx+') a left join'
				+'(select '+@sm
					+case  @aid when 1 then ','+dbo.fn_getsumstr('sex',2)
									when 2 then ','+dbo.fn_getsumstr('school',2)
									when 3 then ','+dbo.fn_getsumstr('education',7)
									when 4 then  ','+dbo.fn_getsumstr('hearth',5)
									when 5 then  ','+dbo.fn_getsumstr('labors',3)
									when 6 then ','+dbo.fn_getsumstr('works',5)
									when 7 then ','+dbo.fn_getsumstr('bla',2)
						end
					+' from familymember '+@con
		 			+' group by '+@sm+') b on a.'+@sm+'=b.'+@sm
		end
		else if @aid <=9
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
				+' from ('+case @aid when 8 then 'select age val,'+@sm+
													' from familymember ' + @con
											when 9 then 'select tbfd val,'+@sm+' from familymember '+@con
											else ''
											end
				+') a group by ' +@sm +') b right join ' 
				+'(select '+@sm+',oname from govdata '+@conx+') e on b.'+@sm +'=e.'+@sm
		end
		--select @sql
		exec (@sql)
	end
	set nocount off
end
GO
