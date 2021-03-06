USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_hourfang_detail]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*

exec sp_hourfang_detail '32',1,2,null,null

select top 10 * from govdata
select * from xianhoufang
*/
CREATE            proc [dbo].[sp_hourfang_detail](
@bm varchar(20),--当前所要查询的当前编码
@rid int,--0:显示报告列表,>0为具体的报告编号
@mode int,--0:查看具体的后方单位或县,1:按后方单位查看，2:按各县查看,3:县级帐号查看
@fuid int,--后方单位编号,为空忽略
@xm varchar(20)--县编号,为空忽略
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @ol int
declare @sql nvarchar(500)
 set nocount on
	if exists(select 1 from govdata where bm =@bm)
	begin
		select @sid=sid,@ssid=ssid,@xid=xid,@ol = ol from govdata where bm = @bm
		if (@ol =1 or @ol =3 or @ol =2) 
		begin
			if @mode = 0 --查看具体的后方单位或县
			begin
				if @fuid >0 --查看具体的后方单位项目明细
				begin
					if @ol = 1 
						select b.bm,b.oname,a.vt,a.nt,a.fpyt,a.pys,a.fpyd,a.itn,a.fn,a.un,a.er,a.rt,a.rm,a.re from 
						(select sid,ssid,xid,dbo.formatmoney(vt) vt,nt,dbo.formatmoney(fpyt) fpyt,
							dbo.formatmoney(fpys) pys,dbo.formatmoney(fpyd) fpyd,itn,fn,un,dbo.formatmoney(er) er,rt,rm,
							re from xianhoufang where rid = @rid and sid =@sid and fuid = @fuid ) a join 
						(select sid,ssid,xid,bm,oname from govdata where sid=@sid and ssid>0 and xid>0 and xxid = 0) b
						on a.sid = b.sid and a.ssid = b.ssid and a.xid =b.xid
					else if @ol = 2
						select b.bm,b.oname,a.vt,a.nt,a.fpyt,a.pys,a.fpyd,a.itn,a.fn,a.un,a.er,a.rt,a.rm,a.re from 
						(select sid,ssid,xid,dbo.formatmoney(vt) vt,nt,dbo.formatmoney(fpyt) fpyt,
							dbo.formatmoney(fpys) pys,dbo.formatmoney(fpyd) fpyd,itn,fn,un,dbo.formatmoney(er) er,rt,rm,
							re from xianhoufang where rid = @rid and sid =@sid and ssid = @ssid and fuid = @fuid ) a join 
						(select sid,ssid,xid,bm,oname from govdata where sid=@sid and ssid=@ssid and xid>0 and xxid = 0) b
						on a.sid = b.sid and a.ssid = b.ssid and a.xid =b.xid
				end 
				else if not @xm is null--查看具体的县项目明细
				begin
					if @ol = 1
					begin
						if exists(select 1 from govdata where bm = @xm)
						begin
							select @sid=sid,@ssid=ssid,@xid=xid,@ol = ol from govdata where bm = @xm
							if @ol = 3 
							begin
								select a.fuid,b.funame,a.vt,a.nt,a.fpyt,a.pys,a.fpyd,a.itn,a.fn,a.un,a.er,a.rt,a.rm,a.re from 
								(select fuid,dbo.formatmoney(vt) vt,nt,dbo.formatmoney(fpyt) fpyt,
									dbo.formatmoney(fpys) pys,dbo.formatmoney(fpyd) fpyd,itn,fn,un,dbo.formatmoney(er) er,rt,rm,
									re from xianhoufang where rid = @rid and sid =@sid and ssid = @ssid and xid=@xid ) a join 
								govpunit b
								on a.fuid = b.fuid
							end
						end
					end
					else if @ol = 2 
						if exists(select 1 from govdata where bm = @xm)
						begin
							select @sid=sid,@ssid=ssid,@xid=xid,@ol = ol from govdata where bm = @xm
							if @ol = 3 
							begin
								select a.fuid,b.funame,a.vt,a.nt,a.fpyt,a.pys,a.fpyd,a.itn,a.fn,a.un,a.er,a.rt,a.rm,a.re from 
								(select fuid,dbo.formatmoney(vt) vt,nt,dbo.formatmoney(fpyt) fpyt,
									dbo.formatmoney(fpys) pys,dbo.formatmoney(fpyd) fpyd,itn,fn,un,dbo.formatmoney(er) er,rt,rm,
									re from xianhoufang where rid = @rid and sid =@sid and ssid = @ssid and xid=@xid ) a join 
								govpunit b
								on a.fuid = b.fuid
							end
						end
				end
			end
			else if @mode =1 --按后方单位汇总查看
			begin
				if @ol =  1
					select a.fuid,a.funame,dbo.formatmoney(b.vt) vt,b.nt,dbo.formatmoney(b.fpyt) fpyt,dbo.formatmoney(b.fpys) fpys,dbo.formatmoney(b.fpyd) fpyd,
					b.itn,b.fn,b.un,dbo.formatmoney(b.er) er,b.rt,b.rm,b.re from govpunit a left join (select fuid,sum(vt) vt,sum(nt) nt,sum(fpyt) fpyt,sum(fpys) fpys,sum(fpyd) fpyd,
					sum(itn) itn,sum(fn) fn,sum(un) un,sum(er) er,sum(rt) rt,sum(rm) rm,sum(re) re from xianhoufang where sid=@sid and rid = @rid group by fuid) b on a.fuid = b.fuid 
				else if @ol = 2
					select a.fuid,a.funame,dbo.formatmoney(b.vt) vt,b.nt,dbo.formatmoney(b.fpyt) fpyt,dbo.formatmoney(b.fpys) fpys,dbo.formatmoney(b.fpyd) fpyd,
					b.itn,b.fn,b.un,dbo.formatmoney(b.er) er,b.rt,b.rm,b.re from govpunit a join (select fuid,sum(vt) vt,sum(nt) nt,sum(fpyt) fpyt,sum(fpys) fpys,sum(fpyd) fpyd,
					sum(itn) itn,sum(fn) fn,sum(un) un,sum(er) er,sum(rt) rt,sum(rm) rm,sum(re) re from xianhoufang where sid=@sid and ssid=@ssid and rid = @rid group by fuid) b on a.fuid = b.fuid 
			end
			else if @mode = 2 --按各县汇总查看
			begin
				if @ol =1
					select a.bm,a.oname,dbo.formatmoney(b.vt) vt,b.nt,dbo.formatmoney(b.fpyt) fpyt,dbo.formatmoney(b.fpys) fpys,dbo.formatmoney(b.fpyd) fpyd,
					b.itn,b.fn,b.un,dbo.formatmoney(b.er) er,b.rt,b.rm,b.re from 
					(select sid,ssid,xid,bm,oname from govdata where sid= @sid and ssid>0 and xid >0 and xxid =0 and pf =1) a 
					left join (select sid,ssid,xid,sum(vt) vt,sum(nt) nt,sum(fpyt) fpyt,sum(fpys) fpys,sum(fpyd) fpyd,
					sum(itn) itn,sum(fn) fn,sum(un) un,sum(er) er,sum(rt) rt,sum(rm) rm,sum(re) re from xianhoufang where sid=@sid  and rid =@rid group by sid,ssid,xid) b 
					on a.sid = b.sid and a.ssid =b.ssid and a.xid=b.xid
				else if @ol = 2
					select a.bm,a.oname,dbo.formatmoney(b.vt) vt,b.nt,dbo.formatmoney(b.fpyt) fpyt,dbo.formatmoney(b.fpys) fpys,dbo.formatmoney(b.fpyd) fpyd,
					b.itn,b.fn,b.un,dbo.formatmoney(b.er) er,b.rt,b.rm,b.re from 
					(select sid,ssid,xid,bm,oname from govdata where sid= @sid and ssid=@ssid and xid >0 and xxid =0) a 
					join (select sid,ssid,xid,sum(vt) vt,sum(nt) nt,sum(fpyt) fpyt,sum(fpys) fpys,sum(fpyd) fpyd,
					sum(itn) itn,sum(fn) fn,sum(un) un,sum(er) er,sum(rt) rt,sum(rm) rm,sum(re) re from xianhoufang where sid=@sid and ssid=@ssid and rid =@rid group by sid,ssid,xid) b 
					on a.sid = b.sid and a.ssid =b.ssid and a.xid=b.xid
			end
			else if @mode =3 --县级帐号查看
			begin
				select a.iid,b.funame,dbo.formatmoney(a.vt) vt,a.nt,dbo.formatmoney(a.fpyt) fpyt,
				dbo.formatmoney(a.fpys) pys,dbo.formatmoney(a.fpyd) fpyd,a.itn,a.fn,a.un,dbo.formatmoney(a.er) er,a.rt,rm,
				a.re,a.xiang,a.chun 
				from XianHouFang a join govpunit b on a.fuid = b.fuid
				where a.sid = @sid and ssid=@ssid and xid = @xid and a.rid =@rid
			end
	end
end

set nocount off
end
GO
