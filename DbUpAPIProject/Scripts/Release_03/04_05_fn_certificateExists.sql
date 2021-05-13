-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date, ,>    
-- Description: <Description, ,>    
-- SELECT     
-- =============================================    
CREATE FUNCTION [dbo].[fn_certificateExists]     
(    
@stageActionId INT  
)    
RETURNS INT    
AS    
BEGIN    
    
 DECLARE @certificateid AS INT = 0     
  IF EXISTS        
        (        
            select 1 from service.Certificates Where StageActionId = @stageActionId       
        )        
            BEGIN        
                Select @certificateid = Id from service.Certificates Where StageActionId = @stageActionId;        
        END;        
    
 RETURN @certificateid    
    
END    
  
  
  