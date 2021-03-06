USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_year_describle]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
查询指定村编码的将补到户情况
exec sp_year_describle '32',2013
*/
CREATE       proc [dbo].[sp_year_describle](
@bm varchar(20),--当前编码
@year int---当前年号
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @ol int
declare @sql nvarchar(1000)
 set nocount on
	if exists(select 1 from govdata where bm =@bm) 
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@ol =ol from govdata where bm = @bm
		if @ol <5
		set @sql = 'select b.bm,b.oname,a.inTotal,a.hn from (select '
			+case @ol when 1 then 'ssid id,'
						when 2 then 'xid id,'
						when 3 then 'xxid id,'
						when 4 then 'cid id,'
			end 
			+'floor(avg(inTotal)) inTotal'
			+',count(1) hn'
			+' from FamilyYear where year='+ltrim(str(@year))
			+case @ol when  1 then ' and sid = '+ltrim(str(@sid))+' group by ssid'
						when 2 then ' and sid = '+ltrim(str(@sid))+' and ssid='+ltrim(str(@ssid))+' group by xid'
						when 3 then ' and sid = '+ltrim(str(@sid))+' and ssid='+ltrim(str(@ssid))+' and xid='+ltrim(str(@xid))+' group by xxid'
						when 4 then ' and sid = '+ltrim(str(@sid))+' and ssid='+ltrim(str(@ssid))+' and xid='+ltrim(str(@xid))
										+' and xxid='+ltrim(str(@xxid))+' group by cid'
			end
			+') a right join (select '
			+case @ol when 1 then ' ssid id'
						when 2 then ' xid id'
						when 3 then ' xxid id'
						when 4 then ' cid id'
			 end
			 +',bm,oname from govdata where sid='+ltrim(str(@sid))
			+case @ol when 1  then ' and ssid>0 and xid=0'
						when 2 then ' and ssid='+ltrim(str(@ssid)) +' and xid >0 and xxid =0'
						when 3 then ' and ssid='+ltrim(str(@ssid)) +' and xid='+ltrim(str(@xid))+' and xxid >0 and cid =0'
						when 4 then ' and ssid='+ltrim(str(@ssid)) +' and xid='+ltrim(str(@xid))+' and xxid ='+ltrim(str(@xxid))+' and cid>0'
				end
			+') b on a.id = b.id'
			else if @ol =5 
				set @sql ='select a.hm,a.hname,floor(b.inTotal) inTotal,floor(b.incrop) incrop,floor(b.inlivstock) inlivstock,floor(b.inwork) inwork,'
			+'floor(b.inbla) inbla,floor(b.insubside) insubside,floor(b.inother) inother,floor(b.inpersonal) inpersonal,'
			+'floor(b.grantaid) grantaid,floor(b.share) share,floor(b.pettyloan) pettyloan,b.labtrain,b.labjob '
			+'from family a left join '
			+'(select * from FamilyYear where sid = '+ltrim(str(@sid))+' and ssid= '+ltrim(str(@ssid))
			+'		and xid = '+ltrim(str(@xid))+' and xxid='+ltrim(str(@xxid))+' and cid='+ltrim(str(@cid))+' and year = '+ltrim(str(@year))+' ) b on  a.hm=b.hm '
			+'where a.sid = '+ltrim(str(@sid))+' and a.ssid='+ltrim(str(@ssid))+' and a.xid = '+ltrim(str(@xid))
					+' and a.xxid='+ltrim(str(@xxid))+' and a.cid=' +ltrim(str(@cid ))
			exec (@sql)
	end
set nocount off
end
GO
