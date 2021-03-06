USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_keyprj_updateex]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
查询指定编码的指定年份的扶贫情况
exec sp_keyprj_list '320826',1
exec sp_keyprj_update '320826',1,'','项目二','唱歌乡',1,2,3,4,5,6,7,8
*/
create    proc [dbo].[sp_keyprj_updateex](
@xxm varchar(20),--要更新或插入的项目所在乡的编码
@rid int,--报告编号
@pqid int,--片区编号
@pid int, --项目编号,如果是新建,则项目编号为空
@pname varchar(200),--项目名称
@own varchar(64),--项目所属乡镇名称
@spr money,--省级财政安排
@sspr money,--市县财政安排
@opr money,--其他资金
@pyt money,--资金拨付合计
@spy money,--其中,已拨付省级财政补助资金
@yt int,--项目实施年限
@yp int,--全年计划进度
@np int--截至报告日项目实施进度
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @prt int
 set nocount on
	if exists(select 1 from govdata where bm =@xxm) and len(@xxm) =6
	begin
		set @prt=@spr+@sspr+@opr
		select @sid=sid,@ssid=ssid,@xid=xid from govdata where bm = @xxm
		if (@pid is null or @pid = 0)
			select @pid=isnull(max(pid),0)+1 from xiangkeyprj where sid=@sid and ssid = @ssid and xid = @xid and rid =@rid and pqid = @pqid
		if exists(select 1 from xiangkeyprj where sid=@sid and ssid = @ssid and xid = @xid and rid =@rid and pid = @pid and pqid=@pqid)
			update xiangkeyprj set itemname = @pname,own=@own,prt=@prt,spr=@spr,sspr=@sspr,opr =@opr,pyt=@pyt,spy=@spy,yt=@yt,yp=@yp,np=@np 
				where sid=@sid and ssid = @ssid and xid = @xid and rid=@rid and pid = @pid and pqid=@pqid
		else
			insert into xiangkeyprj(sid,ssid,xid,xxid,cid,rid,pid,pqid,bm,itemname,own,prt,spr,sspr,opr,pyt,spy,yt,yp,np,rdt)
				values (@sid,@ssid,@xid,0,0,@rid,@pid,@pqid,@xxm,@pname,@own,@prt,@spr,@sspr,@opr,@pyt,@spy,@yt,@yp,@np,getdate())
	end
set nocount off
end
GO
