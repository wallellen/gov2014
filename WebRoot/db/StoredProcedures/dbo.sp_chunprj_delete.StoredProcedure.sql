USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[sp_chunprj_delete]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
删除指定村指定项目
exec sp_chunprj_delete '320803103',null,'AAA',1,2,3,4,5,6,7,8
*/
CREATE   proc [dbo].[sp_chunprj_delete](
@cm varchar(20),--要删除的项目对应的村码
@rid int,--报告编号
@pid int --要删除的项目编号
)
as
begin
 set nocount on
	delete chunprj where bm = @cm and rid =@rid and pid =@pid
set nocount off
end
GO
