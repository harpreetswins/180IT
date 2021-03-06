
/****** Object:  StoredProcedure [dbo].[sp_GetGroupsAndServices]    Script Date: 22-01-2021 19:05:26 ******/
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
    
        SELECT DISTINCT G.Id,      
    JSON_QUERY(dbo.fn_multiLingualName(G.Id, @groupTranslationKeyId)) AS Name,      
               G.ParentId,           
               G.OrderNumber,           
        (          
            SELECT SG.Id,        
  JSON_QUERY(dbo.fn_multiLingualName(SG.Id, @groupTranslationKeyId)) AS Name,      
  JSON_QUERY(dbo.fn_multiLingualName(SG.Id, @groupDescTranslationKeyId)) AS Description,     
       SG.ParentId,           
       SG.OrderNumber,          
                             
            (          
                SELECT SSs.Id,              
      JSON_QUERY(dbo.fn_multiLingualName(SSs.Id, @serviceTranslationKeyId)) AS Name,  
   JSON_QUERY(dbo.fn_multiLingualName(SSs.Id, @serviceDescTranslationKeyId)) AS Description,  
      SSs.GroupId,          
      SSs.OrderNumber          
                FROM service.Services SSs          
                WHERE SSs.GroupId = SG.Id AND SSs.IsDeleted = 0 AND SSs.IsProfile = 0 FOR JSON PATH          
            ) AS ChildServices          
            FROM service.Groups SG          
   WHERE SG.ParentId = G.Id          
   AND SG.IsDeleted = 0      
   ORDER BY OrderNumber ASC FOR JSON PATH          
        ) AS ChildGroups,           
        (          
            SELECT SS.Id,           
       JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId)) AS Name,  
    JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @serviceDescTranslationKeyId)) AS Description   
            FROM service.Services SS          
            WHERE SS.GroupId = G.Id AND SS.IsDeleted = 0 AND SS.IsProfile = 0 FOR JSON PATH          
        ) AS GroupServices          
        FROM service.Groups G 
		INNER JOIN service.Services SS11 ON SS11.GroupId = G.Id
        WHERE G.IsDeleted = 0 AND G.ParentId IS NULL   AND SS11.IsProfile = 0  
	
  ORDER BY OrderNumber;  
    END; 
 