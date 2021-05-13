SELECT * FROM sys.schemas;

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'admin')
BEGIN
EXEC('CREATE SCHEMA admin')
END

ALTER SCHEMA admin TRANSFER dbo.sp_AddEditEntities;
ALTER SCHEMA admin TRANSFER dbo.sp_AddEditStages;
ALTER SCHEMA admin TRANSFER dbo.sp_AddGroups;
ALTER SCHEMA admin TRANSFER dbo.sp_AddServices;
ALTER SCHEMA admin TRANSFER dbo.sp_AddUpdateStageActions;
ALTER SCHEMA admin TRANSFER dbo.sp_AdminDeleteStageActions;
ALTER SCHEMA admin TRANSFER dbo.sp_AdminGetForms;
ALTER SCHEMA admin TRANSFER dbo.sp_AdminGetRoles;
ALTER SCHEMA admin TRANSFER dbo.sp_AdminLinkUnlinkStageForms;
ALTER SCHEMA admin TRANSFER dbo.sp_ReorderGroups;
ALTER SCHEMA admin TRANSFER dbo.sp_ReorderServices;
ALTER SCHEMA admin TRANSFER dbo.sp_ReorderStages;

ALTER SCHEMA admin TRANSFER dbo.sp_DeleteService;
ALTER SCHEMA admin TRANSFER dbo.sp_GetAllStageTypes;
ALTER SCHEMA admin TRANSFER dbo.sp_GetServicesById;
ALTER SCHEMA admin TRANSFER dbo.sp_GetStageActionTypes;
ALTER SCHEMA admin TRANSFER dbo.sp_GetStageActionsByStageId;
ALTER SCHEMA admin TRANSFER dbo.sp_GetStagesByServiceId;
ALTER SCHEMA admin TRANSFER dbo.sp_DeleteStages;
ALTER SCHEMA admin TRANSFER dbo.sp_GetAllEntities;
ALTER SCHEMA admin TRANSFER dbo.sp_AddEditForms;
ALTER SCHEMA admin TRANSFER dbo.sp_AdminGetStageForms;
ALTER SCHEMA admin TRANSFER dbo.sp_DeleteGroup;
ALTER SCHEMA admin TRANSFER dbo.sp_GetGroupsById;