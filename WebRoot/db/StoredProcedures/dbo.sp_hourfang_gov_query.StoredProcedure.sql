USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_hourfang_gov_query]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
更新或添加省级后方单位挂钩帮扶情况表记录
exec sp_hourfang_gov_query '320803'
exec sp_hourfang_update '320706',2,'test1','t1','t2',1,2,3,4,5,6,7,8,9
*/
CREATE   proc [dbo].[sp_hourfang_gov_query](
@xm varchar(20)--要更新或插入的项目所属县码

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
	select  fuid,funame from govpunit where own = 1
	select  fuid,funame from govpunit where own = 2
	select  fuid,funame from govpunit where own = 3
	select  fuid,funame from govpunit where own = 4
set nocount off
end
GO
