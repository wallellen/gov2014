USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_jiangbu_detail]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
查询指定村编码的将补到户情况
select * from FamilyJiangBu
exec sp_jiangbu_detail '320803103002',1
select * from govdata where bm = '320703001200'
*/
CREATE      proc [dbo].[sp_jiangbu_detail](
@bm varchar(20),--当前编码
@rid int---当前批次号
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
	if exists(select 1 from govdata where bm =@bm and cjt=1) 
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@ol =ol from govdata where bm = @bm
		if @ol <5
		set @sql = 'select b.bm,b.oname,isnull(a.t1,0) t1,isnull(a.t2,0) t2,isnull(a.t3,0) t3,isnull(a.t4,0) t4,isnull(a.t5,0) t5,isnull(a.t6,0) t6,'
			+'isnull(a.t7,0) t7,isnull(a.v,0) v,isnull(a.v1,0) v1,isnull(a.v2,0) v2,isnull(a.v3,0) v3 from (select '
			+case @ol when 1 then 'ssid id,'
						when 2 then 'xid id,'
						when 3 then 'xxid id,'
						when 4 then 'cid id,'
			end 
			+'sum(t1) t1,sum(t2) t2,sum(t3) t3,sum(t4) t4,sum(t5) t5,sum(t6) t6,sum(t7) t7,'
			+'sum(v) v,sum(v1) v1,sum(v2) v2,sum(v3) v3 from FamilyJiangBu where rid='+ltrim(str(@rid))
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
			 +',bm,oname from govdata where cjt=1 and sid='+ltrim(str(@sid))
			+case @ol when 1  then ' and ssid>0 and xid=0'
						when 2 then ' and ssid='+ltrim(str(@ssid)) +' and xid >0 and xxid =0'
						when 3 then ' and ssid='+ltrim(str(@ssid)) +' and xid='+ltrim(str(@xid))+' and xxid >0 and cid =0'
						when 4 then ' and ssid='+ltrim(str(@ssid)) +' and xid='+ltrim(str(@xid))+' and xxid ='+ltrim(str(@xxid))+' and cid>0'
				end
			+') b on a.id = b.id'
			else if @ol =5 
				set @sql ='select a.hm,a.hname,isnull(b.T1,0) T1,isnull(b.T2,0) T2,isnull(b.T3,0) T3,isnull(b.T4,0) T4,isnull(b.T5,0) T5,'
			+'isnull(b.T6,0) T6,isnull(b.T7,0) T7,isnull(b.v,0) V,isnull(b.V1,0) V1,isnull(b.V2,0) V2,isnull(b.V3,0) V3,isnull(b.B1,0) B1  '
			+'from family a left join '
			+'(select * from FamilyJiangBu where sid = '+ltrim(str(@sid))+' and ssid= '+ltrim(str(@ssid))
			+'		and xid = '+ltrim(str(@xid))+' and xxid='+ltrim(str(@xxid))+' and cid='+ltrim(str(@cid))+' and rid = '+ltrim(str(@rid))+' ) b on  a.hm=b.hm '
			+'where a.sid = '+ltrim(str(@sid))+' and a.ssid='+ltrim(str(@ssid))+' and a.xid = '+ltrim(str(@xid))
					+' and a.xxid='+ltrim(str(@xxid))+' and a.cid=' +ltrim(str(@cid ))
			exec (@sql)
	end
set nocount off
end
GO
