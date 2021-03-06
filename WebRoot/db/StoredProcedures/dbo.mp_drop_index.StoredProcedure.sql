USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[mp_drop_index]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
根据编码确定档案表中组织结构级别
execute mp_drop_index 
*/
CREATE    proc [dbo].[mp_drop_index]
as
begin
   set nocount on
	drop INDEX Family.ix_family_bm4
	drop INDEX Family.ix_family_bm6
	drop INDEX Family.ix_family_bm9
	drop INDEX Family.ix_family_bm12
	drop INDEX Family.ix_family_bm2
	drop INDEX Family.ix_family_property
	drop INDEX Family.ix_family_dcause
	drop INDEX FamilyYear.ix_familyyear_bm4
	drop INDEX FamilyYear.ix_familyyear_bm6
	drop INDEX FamilyYear.ix_familyyear_bm9
	drop INDEX FamilyYear.ix_familyyear_bm12
	drop INDEX FamilyYear.ix_familyyear_bm2
	drop INDEX FamilyYear.ix_familyyear_intotal
   set nocount off
end
GO
