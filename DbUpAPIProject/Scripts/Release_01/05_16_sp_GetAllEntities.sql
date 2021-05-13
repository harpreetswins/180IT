/****** Object:  StoredProcedure [dbo].[sp_GetAllEntities]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

ALTER PROCEDURE [dbo].[sp_GetAllEntities] 
AS
    BEGIN
        SELECT SE.Id AS 'Id', 
               SE.Name AS 'EntityName'
        FROM service.Entities AS SE
    END;
GO