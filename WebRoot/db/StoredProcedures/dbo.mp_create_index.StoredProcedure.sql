USE [gov2014]
GO
/****** Object:  StoredProcedure [dbo].[mp_create_index]    Script Date: 06/17/2014 09:13:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
根据编码确定档案表中组织结构级别
select * from govdata
execute mp_create_index 

backup log gov2014 with no_log 

*/
CREATE     proc [dbo].[mp_create_index]
as
begin
set nocount on
CREATE  INDEX [ix_family_bm4] ON [dbo].[Family]([SID], [SSID]) ON [PRIMARY]
CREATE  INDEX [ix_family_bm6] ON [dbo].[Family]([SID], [SSID], [XID]) ON [PRIMARY]
CREATE  INDEX [ix_family_bm9] ON [dbo].[Family]([SID], [SSID], [XID], [XXID]) ON [PRIMARY]
CREATE  INDEX [ix_family_bm12] ON [dbo].[Family]([SID], [SSID], [XID], [XXID], [CID]) ON [PRIMARY]
CREATE  INDEX [ix_family_bm2] ON [dbo].[Family]([SID]) ON [PRIMARY]
CREATE  INDEX [ix_family_property] ON [dbo].[Family]([Property]) ON [PRIMARY]
CREATE  INDEX [ix_family_dcause] ON [dbo].[Family]([DCause]) ON [PRIMARY]
CREATE  INDEX [ix_familyyear_bm4] ON [dbo].[FamilyYear]([SID], [SSID]) ON [PRIMARY]
CREATE  INDEX [ix_familyyear_bm6] ON [dbo].[FamilyYear]([SID], [SSID], [XID]) ON [PRIMARY]
CREATE  INDEX [ix_familyyear_bm9] ON [dbo].[FamilyYear]([SID], [SSID], [XID], [XXID]) ON [PRIMARY]
CREATE  INDEX [ix_familyyear_bm12] ON [dbo].[FamilyYear]([SID], [SSID], [XID], [XXID], [CID]) ON [PRIMARY]
CREATE  INDEX [ix_familyyear_bm2] ON [dbo].[FamilyYear]([SID]) ON [PRIMARY]
CREATE  INDEX [ix_familyyear_intotal] ON [dbo].[FamilyYear]([inTotal]) ON [PRIMARY]
set nocount off
end
GO
