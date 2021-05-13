/****** Object:  UserDefinedFunction [dbo].[fn_entityRelationships]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[fn_entityRelationships](@Id INT)
RETURNS NVARCHAR(MAX)
AS
     BEGIN
         DECLARE @entityRelationships AS NVARCHAR(MAX);
         SET @entityRelationships =
         (
             SELECT SERS.FromEntityId AS FromEntityId, 
                    SERS.ToEntityId AS ToEntityId, 
                    SERS.ParentRelationName AS parentRelationName, 
                    SERS.ChildRelationName AS childRelationName, 
                    SERT.Name AS multipleChildRelationShip
             FROM service.EntityRelationships SERS
                  INNER JOIN lookups.EntityRelationTypes SERT ON SERT.ID = SERS.EntityRelationshipTypeId
             WHERE SERS.EntityFieldId = @Id FOR JSON PATH
         );
         RETURN @entityRelationships;
     END;
GO