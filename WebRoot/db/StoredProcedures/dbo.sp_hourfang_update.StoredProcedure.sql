USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_hourfang_update]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
更新或添加省级后方单位挂钩帮扶情况表记录
exec sp_hourfang_list '320706'
exec sp_hourfang_update '320706',2,'test1','t1','t2',1,2,3,4,5,6,7,8,9

*/
CREATE           proc [dbo].[sp_hourfang_update](
@xm varchar(20),--要更新或插入的项目所属县码
@rid int,--报告编号
@iid int, --项目编号,如果是新建,则项目编号为空
@fuid int,--帮扶单位名称编号
@xiang varchar(20),--所在乡镇名称
@chun varchar(20),--挂钩村名称
@vt money,--到村项目资金
@nt int,--到村项目个数
@fpys money,--后方单位自筹资金
@fpyd money,--协调资金
@fn int,--完成项目数
@un int,--在建项目数
@er money,--帮扶实物折价
@rm int,--单位领导
@re int--中层及以下人员159-51895037-li
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @ol int
declare @fpyt float--无偿帮扶资金投入合计
declare @itn int
declare @rt int
 set nocount on
	if exists(select 1 from govdata where bm =@xm) and len(@xm)= 6
	begin
		--set @vt=dbo.wan2i(@vt)
		--set @fpys=dbo.wan2i(@fpys)
		--set @fpyd=dbo.wan2i(@fpyd)
		--set @er=dbo.wan2i(@er)
		set @fpyt=@fpys+@fpyd
		set @itn=@fn+@un
		set @rt=@rm+@re
		select @sid=sid,@ssid=ssid,@xid=xid,@ol=ol from govdata where bm = @xm
		if (@iid is null or @iid = 0)
			select @iid=isnull(max(iid),0)+1 from XianHouFang where sid=@sid and ssid = @ssid  and xid = @xid  and rid =@rid
		if exists(select 1 from XianHouFang where sid=@sid and ssid = @ssid and xid = @xid and rid =@rid and iid = @iid )
			update XianHouFang set xiang = @xiang,chun=@chun,vt=@vt,nt=@nt,fpyt =@fpyt,fpys=@fpys,fpyd=@fpyd,itn=@itn,fn=@fn,
				un=@un,er=@er,rt=@rt,rm=@rm,re=@re,fuid = @fuid 
				where sid=@sid and ssid = @ssid and xid = @xid and rid =@rid and iid = @iid
		else
			insert into XianHouFang(sid,ssid,xid,xxid,cid,rid,iid,xiang,chun,vt,nt,fpyt,fpys,fpyd,itn,fn,un,er,rt,rm,re,fuid)
				values (@sid,@ssid,@xid,0,0,@rid,@iid,@xiang,@chun,@vt,@nt,@fpyt,@fpys,@fpyd,@itn,@fn,@un,@er,@rt,@rm,@re,@fuid)
	end
set nocount off
end
GO
