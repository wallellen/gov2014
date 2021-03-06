USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_xiaoe_update]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
小额贷款省县查看
exec sp_xiaoe_update '320723',2013,0,3267,4472.6,0,0,3208,4414.3,59,58.3,null
exec sp_report_list 'xianxiaoe_item',0
select * from reportlist  where subtag = 'xianxiaoe_item'
select * from xianxiaoe
select top 100 * from sys_log  order by logid desc
select round(11.121,2) 
*/
CREATE   proc [dbo].[sp_xiaoe_update](
@bm varchar(20),--查询的县编码
@year int,--年份
@month int,--月份
@tsh int,--本月发出户数
@tsv money,--本月发出金额
@trh int,--本月收回户数
@trv money,--本月收回金额
@nh int,--  未到期户数
@nv money,--未到期金额
@eh int,--逾期户数
@ev money,--逾期金额
@rs varchar(32) out--结果是否写入
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @l int
declare @lh int
declare @lv money
declare @th int
declare @tv money
declare @result int
declare @str varchar(1000)
 set nocount on

	set @rs = '编码错误'
	if exists(select 1 from govdata where bm =@bm)
	begin
		set @rs = '非县级帐号'
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@l=ol from govdata where bm = @bm
		if @l = 3 --县级帐号
		begin
			set @rs ='年月有误，或无上月数据'
			exec sp_xiaoe_calc @bm,@year,@month,@result OUTPUT,@lh OUTPUT,@lv OUTPUT
			if @result = 0 
			begin
				/*set @str  = convert(varchar(30),@lv)
							+convert(varchar(30),@tsv)
							+convert(varchar(30),@trv)
				exec sys_addinfo @str
				set @str  = convert(varchar(30),@nv)
							+convert(varchar(30),@ev)
				exec sys_addinfo @str*/
				set @rs ='未到期＋逾期人数或金额不等'
				set @th = @lh+@tsh-@trh
				set @tv = @lv+@tsv-@trv
				--set @str  = convert(varchar(30),@tv-@nv-@ev)
				--exec sys_addinfo @str
				if @th=@nh+@eh and round(@nv+@ev,1)=round(@tv,1)
				begin
					set @rs = 'ok'
					if exists(select 1 from xianxiaoe where sid = @sid and ssid =@ssid and xid = @xid and year = @year and month = @month)
					begin
						update xianxiaoe set tsh =@tsh,tsv =@tsv,trh=@trh,trv =@trv,lh=@lh,lv=@lv,nh=@nh,nv=@nv,eh=@eh,ev=@ev 
							where sid=@sid and ssid=@ssid and xid=@xid and year = @year and month = @month
					end
					else
					begin
						insert into xianxiaoe(sid,ssid,xid,xxid,cid,year,month,tsh,tsv,trh,trv,lh,lv,th,tv,nh,nv,eh,ev)
							values(@sid,@ssid,@xid,0,0,@year,@month,@tsh,@tsv,@trh,@trv,@lh,@lv,@th,@tv,@nh,@nv,@eh,@ev)
					end
				end
			end
		end
	end
set nocount off
end
GO
