
/****** Object:  StoredProcedure [dbo].[sp_GetAllStageTypes]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetAllStageTypes]  
AS  
    BEGIN  
	DECLARE @stageTypeTranslationKeyId INT = 19;
        SELECT SE.Id AS 'Id',   
               SE.StageTypeName AS 'StageTypeName',   
               dbo.fn_multiLingualName(SE.Id, @stageTypeTranslationKeyId) AS 'StageTypes'  
        FROM lookups.StageTypes AS SE;  
    END;
GO