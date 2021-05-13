
/****** Object:  StoredProcedure [dbo].[sp_GetGroupsAndServices]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================          
-- Author:  <Author,,Name>          
-- Create date: <Create Date,,>          
-- Description: <Description,,>          
-- sp_GetGroupsAndServices         
-- SELECT * FROM [system].[TranslationKeys]
-- =============================================          
ALTER PROCEDURE [dbo].[sp_GetGroupsAndServices]        
AS        
    BEGIN        
 DECLARE @groupTranslationKeyId INT = 14, @groupDescTranslationKeyId INT = 15, @serviceTranslationKeyId INT = 11, @serviceDescTranslationKeyId INT = 16;  
-- DECLARE @Service NVARCHAR(MAX);    
 --SET @Service =     
        SELECT G.Id,         
    --G.Name,     
    JSON_QUERY(dbo.fn_multiLingualName(G.Id, @groupTranslationKeyId)) AS Name,    
               G.ParentId,         
               G.OrderNumber,         
        (        
            SELECT SG.Id,        
  --SG.Name,       
  JSON_QUERY(dbo.fn_multiLingualName(SG.Id, @groupTranslationKeyId)) AS Name,    
  JSON_QUERY(dbo.fn_multiLingualName(SG.Id, @groupDescTranslationKeyId)) AS Description,   
       SG.ParentId,         
       SG.OrderNumber,        
                           
            (        
                SELECT SSs.Id,         
                       --SSs.Name,        
      JSON_QUERY(dbo.fn_multiLingualName(SSs.Id, @serviceTranslationKeyId)) AS Name,
	  JSON_QUERY(dbo.fn_multiLingualName(SSs.Id, @serviceDescTranslationKeyId)) AS Description,
      SSs.GroupId,        
      SSs.OrderNumber        
                FROM service.Services SSs        
                WHERE SSs.GroupId = SG.Id AND SSs.IsDeleted = 0 FOR JSON PATH        
            ) AS ChildServices        
            FROM service.Groups SG        
   WHERE SG.ParentId = G.Id        
   AND SG.IsDeleted = 0    
   ORDER BY OrderNumber ASC FOR JSON PATH        
        ) AS ChildGroups,         
        (        
            SELECT SS.Id,         
                   --SS.Name     
       JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId)) AS Name,
	   JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @serviceDescTranslationKeyId)) AS Description 
            FROM service.Services SS        
            WHERE SS.GroupId = G.Id AND SS.IsDeleted = 0 FOR JSON PATH        
        ) AS GroupServices        
        FROM service.Groups G        
        WHERE G.IsDeleted = 0 AND G.ParentId IS NULL    
  ORDER BY OrderNumber; --ASC FOR JSON PATH) ;        
  --SELECT @Service AS GroupServices    
    END;  
GO