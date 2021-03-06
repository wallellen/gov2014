USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_chunprj_update]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
查询指定编码的指定年份的扶贫情况
select top 10 * from govdata
select top 10 * from family
select * from FamilyJiangBu
select * from family
select * from xiangkeyprj
exec sp_keyprj_list '320803'
exec sp_keyprj_update '320803103',null,'AAA',1,2,3,4,5,6,7,8
select * from family where hm like '320703001200%'
*/
CREATE       proc [dbo].[sp_chunprj_update](
@cm varchar(20),--要更新或插入的项目所在乡的编码
@rid int,--报告编号
@pid int, --项目编号,如果是新建,则项目编号为空
@pname varchar(200),--项目名称
@pcontent varchar(200),--项目描述
@spr float,--省级财政投入(万元)
@sspr float,--市级财政投入(万元)
@xpr float,--县级财政投入(万元)
@xxpr float,--乡镇财政投入(万元)
@fpr float,--扶贫资金投入(万元)
@wpr float,--社会捐赠投入(万元)
@yfi float,--项目建成后预计年效益(万元)
@afi float,--项目为集体增加经营性收入(万元)
@lyi float,--上年村集体经营性收入(万元)
@o2015 datetime,--2015目标时间
@sprp int,--省级财政投入资金拨付进度(%)
@pp int--项目实施进度(%)
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号
declare @pr float
declare @prt float
declare @opr float
 set nocount on
	if exists(select 1 from govdata where bm =@cm) and len(@cm) =12
	begin
--		set @spr=dbo.wan2i(@spr)
	--	set @sspr=dbo.wan2i(@sspr)
		--set @xpr=dbo.wan2i(@xpr)
		--set @xxpr=dbo.wan2i(@xxpr)
		--set @fpr=dbo.wan2i(@fpr)
		--set @wpr=dbo.wan2i(@wpr)
		--set @yfi=dbo.wan2i(@yfi)
		--set @afi=dbo.wan2i(@afi)
		--set @lyi=dbo.wan2i(@lyi)
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid from govdata where bm = @cm
		if (@pid is null or @pid = 0)
			select @pid=isnull(max(pid),0)+1 from chunprj where sid=@sid and ssid = @ssid and xid = @xid and xxid =@xxid and cid=@cid and rid = @rid
		set @pr = @spr+@sspr+@xpr+@xxpr
		set @opr = @fpr+@wpr
		set @prt = @pr+@opr
		if exists(select 1 from chunprj where sid=@sid and ssid = @ssid and xid = @xid and xxid =@xxid and cid=@cid and rid=@rid and pid = @pid )
			update chunprj set pname = @pname,pcontent=@pcontent,prt=@prt,pr=@pr,spr=@spr,sspr=@sspr,xpr=@xpr,xxpr=@xxpr,
				opr =@opr,fpr=@fpr,wpr=@wpr,yfi=@yfi,afi=@afi,lyi=@lyi,o2015=@o2015,sprp=@sprp,pp=@pp
				where sid=@sid and ssid = @ssid and xid = @xid and xxid =@xxid and cid=@cid and rid =@rid and pid = @pid
		else
			insert into chunprj(sid,ssid,xid,xxid,cid,rid,pid,bm,pname,pcontent,prt,pr,spr,sspr,xpr,xxpr,opr,fpr,wpr,yfi,afi,lyi,o2015,sprp,pp,rdt)
				values (@sid,@ssid,@xid,@xxid,@cid,@rid,@pid,@cm,@pname,@pcontent,@prt,@pr,@spr,@sspr,@xpr,@xxpr,@opr,@fpr,@wpr,@yfi,@afi,@lyi,
				@o2015,@sprp,@pp,getdate())
	end
set nocount off
end
GO
