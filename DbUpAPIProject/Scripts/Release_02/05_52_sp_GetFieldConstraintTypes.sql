
/****** Object:  StoredProcedure [admin].[sp_GetFieldConstraintTypes]    Script Date: 08-02-2021 16:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [admin].[sp_GetFieldConstraintTypes]    
AS      
    BEGIN      
 Select Id AS FieldConstraintTypes, Name AS FieldConstraintName from lookups.FieldConstraintTypes
    END
