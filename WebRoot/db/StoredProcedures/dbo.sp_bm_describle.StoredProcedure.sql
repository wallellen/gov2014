USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_bm_describle]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
--select top 10 * from family
--select count(1),left(bm,4) subbm from family  group by left(bm,4)
/*
插入编码及用户
exec sp_bm_describle '32'
exec sp_bm_describle'3208'
exec sp_bm_describle '320803'
exec sp_bm_describle '320803103'
exec sp_bm_describle '320803103206'
select top 10 * from govdata where p
select top 10 *   from family
select top 10 * from familyyear
select count(1),dbo.fn_family_inl(inTotal) il from familyyear where left(hm,2) = '32' and year = 2012 group by dbo.fn_family_inl(inTotal) order by il
*/
CREATE              proc [dbo].[sp_bm_describle](
@bm varchar(20)
)                  
as
begin
declare @bms  varchar(30)
declare @total int
declare @bm_name varchar(64)
declare @level int
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @hid int--户编号		6:3
declare @year int
declare @htn int--农户总数
declare @ptn int--人口总数
declare @pn int --低收入农户人口
   set nocount on
	set @bms = @bm+'%'
	select @bm_name = oname,@sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@level=ol from govdata where bm = @bm
	if @level = 1--省
	begin
		select @total=count(1) from family where sid =@sid
		select @htn=isnull(sum(htn),0),@ptn=isnull(sum(ptn),0) from govdata where sid = @sid and cid >0
		select @pn = count(1) from familymember where sid = @sid
		select @bm_name name,@total hn,@pn pn,@htn htn,@ptn ptn
		select b.v0 rn,a.bm,a.oname,isnull(c.htn,0) htn,b.v1,b.v2,b.v3,isnull(c.ptn,0) ptn,isnull(d.rn,0) cknum from
				(select ssid,bm,oname from govdata where sid=@sid and xid=0) a 
				 join (select ssid,
						sum(rn) v0,
						max(case property when 1 then rn else 0 end) v1,
       				max(case property when 2 then rn else 0 end) v2,
		 				max(case property when 3 then rn else 0 end) v3
						 from 
		 					(select ssid,property,count(1) rn from family where sid=@sid group by ssid,property ) as xx group by ssid
						)b on a.ssid = b.ssid 
			     join (select ssid,sum(htn) htn,sum(ptn) ptn from govdata where sid=@sid group by ssid) c  on a.ssid = c.ssid
				  left join(select count(1) rn,ssid from family where sid=@sid and ischeck= 1 group by ssid) d on a.ssid= d.ssid
			 order by a.bm
--
	end
	else if @level =2 --市
	begin
		select @total=count(1) from family where sid =@sid and ssid = @ssid
		select @htn=isnull(sum(htn),0),@ptn=isnull(sum(ptn),0) from govdata  where sid =@sid and ssid = @ssid and cid >0
		select @pn = count(1) from familymember where sid = @sid and ssid = @ssid
		select @bm_name name,@total hn,@pn pn,@htn htn,@ptn ptn
		select b.v0 rn,a.bm,a.oname,isnull(c.htn,0) htn,b.v1,b.v2,b.v3,isnull(c.ptn,0) ptn,isnull(d.rn,0) cknum from
			(select xid,bm,oname from govdata where sid=@sid and ssid= @ssid and xxid=0) a
			 join (
						select xid,
						sum(rn) v0,
						 max(case property when 1 then rn else 0 end) v1,
       				max(case property when 2 then rn else 0 end) v2,
		 				max(case property when 3 then rn else 0 end) v3 from 
		 					(select xid,property,count(1) rn from family where sid=@sid and ssid=@ssid group by xid,property ) as xx group by xid
					)b on a.xid = b.xid  
			join (select xid,isnull(sum(htn),0) htn,sum(ptn) ptn from govdata where sid=@sid and ssid=@ssid group by xid) c  on a.xid = c.xid
			left join(select xid,count(1) rn from family where sid = @sid and ssid = @ssid and ischeck = 1 group by xid) d  on a.xid = d.xid
			order by a.bm
	end
	else if @level =3 --县
	begin
		select @total=count(1) from family where sid =@sid and ssid = @ssid and xid=@xid
		select @htn=isnull(sum(htn),0),@ptn=isnull(sum(ptn),0) from govdata  where sid =@sid and ssid = @ssid and xid=@xid and cid >0
		select @pn = count(1) from familymember where sid = @sid and ssid = @ssid and xid=@xid and cid >0
		select @bm_name name,@total hn,@pn pn,@htn htn,@ptn ptn
		select b.v0 rn,a.bm,a.oname,isnull(c.htn,0) htn,b.v1,b.v2,b.v3,isnull(c.ptn,0) ptn,isnull(d.rn,0) cknum from
			(select xxid,bm,oname from govdata where sid=@sid and ssid= @ssid and xid=@xid and cid=0) a 
			join (
					select xxid,
						sum(rn) v0,
						 max(case property when 1 then rn else 0 end) v1,
       				max(case property when 2 then rn else 0 end) v2,
		 				max(case property when 3 then rn else 0 end) v3 from 
		 					(select xxid,property,count(1) rn from family 
								where sid=@sid and ssid=@ssid and xid=@xid group by xxid,property ) as xx group by xxid
				)b on a.xxid = b.xxid 
			join (select xxid,isnull(sum(htn),0) htn,sum(ptn) ptn from govdata where sid=@sid and ssid=@ssid and xid=@xid group by xxid) c  on a.xxid = c.xxid
			left join(select xxid,count(1) rn from family where sid = @sid and ssid = @ssid and xid =@xid and ischeck = 1 group by xxid ) d 
					on a.xxid = d.xxid
			order by a.bm
	end
	else if @level =4 --乡
	begin
		select @total=count(1) from family where sid =@sid and ssid = @ssid and xid=@xid and xxid =@xxid
		select @htn=isnull(sum(htn),0),@ptn=isnull(sum(ptn),0) from govdata where sid =@sid and ssid = @ssid and xid=@xid and xxid =@xxid and cid >0
		select @pn = count(1) from familymember where sid = @sid and ssid = @ssid and xid=@xid and cid >0 and xxid =@xxid 
		select @bm_name name,@total hn,@pn pn,@htn htn,@ptn ptn 
		select b.v0 rn,a.bm,a.oname,isnull(c.htn,0) htn,b.v1,b.v2,b.v3,isnull(c.ptn,0) ptn,isnull(d.rn,0) cknum  from
			(select cid,bm,oname from govdata where sid=@sid and ssid= @ssid and xid=@xid and xxid=@xxid) a
			join (

						select cid,
						sum(rn) v0,
						 max(case property when 1 then rn else 0 end) v1,
       				max(case property when 2 then rn else 0 end) v2,
		 				max(case property when 3 then rn else 0 end) v3 from 
		 					(select cid,property,count(1) rn from family 
								where sid=@sid and ssid=@ssid and xid=@xid and xxid=@xxid group by cid,property ) as xx group by cid
					) b on a.cid = b.cid 
			join (select cid,isnull(sum(htn),0) htn,sum(ptn) ptn from govdata where sid=@sid and ssid=@ssid and xid=@xid and xxid=@xxid group by cid) c  
						on a.cid = c.cid
			left join(select cid,count(1) rn from family where sid =@sid and ssid = @ssid and xid =@xid and xxid = @xxid and ischeck = 1 group by cid) d
						on a.cid=d.cid
			order by a.bm
	end
	else if @level =5--村
	begin
		select @total=count(1) from family where sid =@sid and ssid = @ssid and xid=@xid and xxid =@xxid and cid =@cid
		select @htn=isnull(htn,0),@ptn=isnull(ptn,0) from govdata where sid =@sid and ssid = @ssid and xid=@xid and xxid =@xxid and cid =@cid
		select @pn = count(1) from familymember where sid = @sid and ssid = @ssid and xid=@xid and cid >0 and xxid =@xxid  and cid =@cid
		select @bm_name name,@total hn,@pn pn,@htn htn,@ptn ptn 
		select a.hm,a.hname,a.zhu,isnull(b.rn,0) population,isnull(b.labors,0) labornum,a.fields,a.house,
				a.Property,a.dcause,a.idcno,a.telnum,a.frname,a.frtel,a.frwork,a.ischeck
	 		from (select hid,hm,hname,zhu,fields,house,dbo.fn_property(property) Property,
				dbo.fn_reason(dcause) dcause,idcno,telnum,frname,frtel,frwork,ischeck from family 
					where sid =@sid and ssid = @ssid and xid=@xid and xxid =@xxid and cid =@cid ) a left join
				(select hid,count(1) rn,sum(case labors when 1 then 1 else 0 end) labors from familymember 
					where sid=@sid and ssid= @ssid and xid=@xid and xxid =@xxid and cid =@cid group by hid) b on a.hid=b.hid
	
	end
	else
		select @level
   set nocount off
end
GO
