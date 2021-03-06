USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_bm_nav]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--select top 10 * from family
--select count(1),left(bm,4) subbm from family  group by left(bm,4)
/*
插入编码及用户
exec sp_bm_nav '3208'
exec sp_bm_nav'3208'
exec sp_bm_nav '320803'
exec sp_bm_nav '320803103'
exec sp_bm_describle '320803103206'
select top 10 * from govdata where p
select top 10 *   from family
select top 10 * from familyyear
select count(1),dbo.fn_family_inl(inTotal) il from familyyear where left(hm,2) = '32' and year = 2012 group by dbo.fn_family_inl(inTotal) order by il
*/
CREATE       proc [dbo].[sp_bm_nav](
@bm varchar(20)
)                  
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @ol int--户编号		6:3
declare @sql nvarchar(500)
   set nocount on
	--set @bms = @bm+'%'
	--select @bm_name = oname,@sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@level=ol from govdata where bm = @bm
	if exists(select 1 from govdata where bm =@bm)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@ol = ol from govdata where bm = @bm
		set @sql = 'select bm,oname from govdata where sid='+ltrim(str(@sid))
			+case @ol when 1 then ' and ssid>0 and xid=0'
						when 2 then ' and ssid='+ltrim(str(@ssid))+' and xid>0 and xxid=0'
						when 3 then ' and ssid='+ltrim(str(@ssid))+' and xid='+ltrim(str(@xid))+' and xxid>0 and cid =0'
						when 4 then ' and ssid='+ltrim(str(@ssid))+' and xid='+ltrim(str(@xid))+' and xxid='+ltrim(str(@xxid))+' and cid>0'
			end
		exec (@sql)
	end
	
   set nocount off
end
GO
