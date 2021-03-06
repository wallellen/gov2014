USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_family_insert]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
添加家庭信息
select top  10 * from govdata
select top  10 * from family
*/
CREATE       proc [dbo].[sp_family_insert](
@account varchar(30),--操作帐号
@bm varchar(30),--当前编码
@HName varchar(100),--户名
@zhu varchar(30),--所在组
@Fields float,--耕地
@House float,--住房
@Property int,--家庭属性
@DCause int,--贫困原因
@IDCNo varchar(30),--残疾证号
@TelNum varchar(32),--电话号码
@FrName varchar(60),--帮扶人
@FrTel varchar(60),--帮扶人联系电话
@FrWork varchar(60)--帮扶人职务
)                  
as
begin
declare @sid int
declare @ssid int--市编号		2:2
declare @xid int--县编号		3:2
declare @xxid int--乡镇编号	4:3
declare @cid int--村编号		5:3
declare @hid int--户编号		6:3
declare @hm varchar(32)
declare @str nvarchar(200)
   set nocount on
	if (len(@bm)=12) 
	begin
		set @hm = 'none'
		if exists(select 1 from govdata where bm = @bm)
		begin
			select @sid=sid,@ssid=ssid,@xid=xid,@xxid=xxid,@cid=cid from govdata where bm = @bm
			select @hid=isnull(max(hid),0)+1 from family where sid=@sid and ssid =@ssid and xid =@xid and xxid = @xxid and cid =@cid
			if @hid <1000 
			begin
				set @hm = @bm + replace(str(@hid,3),' ','0')
				insert into family(sid,ssid,xid,xxid,cid,hid,hname,zhu,hm,Population,labornum,fields,house,property,dcause,idcno,telnum,frname,frtel,frwork) 
				values(@sid,@ssid,@xid,@xxid,@cid,@hid,@hname,@zhu,@hm,0,0,@Fields,@House,@Property,@DCause,@IDCNo,@TelNum,@FrName,@FrTel,@FrWork)	
				set @str = 'account['+@account+'] 添加家庭信息['+@hm+']'
				execute sys_addlog 1,"添加",@account,@str
				insert into familylog(sid,ssid,xid,xxid,cid,hid,opa,hm,odt,cause) values(@sid,@ssid,@xid,@xxid,@cid,@hid,1,@hm,getdate(),1) 
			end
		end
	end
	select @hm hm 
   set nocount off
end
GO
