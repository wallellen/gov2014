USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_xiaoe_calc]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
小额贷款省县查看
exec sp_xiaoe_list '320803',1
exec sp_report_list 'xianxiaoe_item',0
select * from reportlist  where subtag = 'xianxiaoe_item'
*/
CREATE     proc [dbo].[sp_xiaoe_calc](
@bm varchar(20),--查询的县编码
@year int,--计算年份
@month int,--计算月份
@result int out,--计算是否有效
@lsh int out,--上月户数
@lsv money out--上月结余
)
as
begin
declare @sid int
declare @ssid int--市编号	2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @l int
 set nocount on
	set @result = -1--代码错误
	if exists(select 1 from govdata where bm =@bm)
	begin
		set @result = -2--代码级别错误
		select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid,@l=ol from govdata where bm = @bm
		if @l = 3 --县级帐号
		begin
			set @result = -3--年份月份有误
			if @year = 2013
			begin
				set @lsh = 0
				set @lsv = 0.0
				set @result = 0
			end
			else if @year > 2013 and (@month between 1 and 12)
			begin
				if @month >1 
					set @month = @month -1
				else
				begin
					set @year = @year -1
					set @month = 12
				end
				if @year = 2013 set @month =0
				set @result = -4 --上月数据不存在
				if exists(select 1 from xianxiaoe where sid =@sid and ssid = @ssid and xid =@xid and year = @year and month = @month)
				begin
					select @lsh=th,@lsv =tv from xianxiaoe where sid =@sid and ssid = @ssid and xid =@xid and year = @year and month = @month
					set @result = 0
				end
				else
				begin
					select @lsh=0,@lsv =0
				end
			end
		end
	end
set nocount off
end
GO
