USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_bm_getfullpath]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
插入编码及用户
exec sp_bm_getfullpath '320803103203','320803'
*/
CREATE  proc [dbo].[sp_bm_getfullpath](
@curbm varchar(20),
@rootbm varchar(30),
@rets varchar(200) out
)                  
as

begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @ol int--户编号		6:3
declare @olr int
declare @st varchar(100)
declare @stx varchar(100)
   set nocount on
	set @curbm = left(@curbm,12)
	set @rets=''
	if left(@curbm,len(@rootbm))=@rootbm
	begin
		if exists(select 1 from govdata where bm =@curbm) and exists(select 1 from govdata where bm = @rootbm)
		begin
			select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@ol = ol from govdata where bm = @curbm
			select @olr = ol from govdata where bm = @rootbm
			while(@olr <=@ol)
			begin
				if @olr = 1 --省
					select @st = oname,@stx = left(@curbm,2) from govdata where sid = @sid and ol=1
				else if @olr = 2--市
					select @st = oname,@stx = left(@curbm,4) from govdata where sid = @sid and ssid = @ssid and ol=2
				else if @olr = 3--县
					select @st = oname,@stx = left(@curbm,6) from govdata where sid = @sid and ssid = @ssid and xid=@xid and ol=3
				else if @olr = 4 --乡
					select @st = oname,@stx = left(@curbm,9) from govdata where sid = @sid and ssid = @ssid and xid=@xid and xxid=@xxid and ol=4
				else if @olr = 5--村
					select @st = oname,@stx = left(@curbm,12) from govdata where sid = @sid and ssid = @ssid and xid=@xid 
						and xxid=@xxid and cid=@cid and ol=5
				set @rets = @rets+@st+';'+@stx+';'+@rootbm+';';
				set @olr=@olr +1;
			end
		end
	end
   set nocount off
end
GO
