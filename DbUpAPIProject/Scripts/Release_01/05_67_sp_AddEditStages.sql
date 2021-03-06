
/****** Object:  StoredProcedure [dbo].[sp_AddEditStages]    Script Date: 25-01-2021 15:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_AddEditStages] @serviceid int, @stages NVARCHAR(4000)            
AS            
    BEGIN            
 DECLARE @enlanguageid AS INT = 1, @aralanguageid AS INT = 2, @stageid AS INT, @translationkeyid AS INT = 12, @ordernumber AS INT = 0;        
     
  BEGIN TRY            
            BEGIN TRAN;            
                        
            CREATE TABLE #tempStages            
            (StageId INT,        
    Name        NVARCHAR(100),          
    LanguageId INT,        
    StageTypeId INT           
            );            
            INSERT INTO #tempStages            
            (StageId,        
    Name,        
    LanguageId,        
    StageTypeId           
            )            
                   SELECT StageId,         
              Name,            
                          LanguageId,        
        StageTypeId            
                   FROM OPENJSON(@stages) WITH(StageId INT, Name NVARCHAR(100), LanguageId INT, StageTypeId INT);         
       
  SELECT TOP 1 @ordernumber = ISNULL(OrderNumber, 0) + 1 From service.Stages Where ServiceId = @serviceid order by OrderNumber DESC      
      
          MERGE service.Stages AS TARGET        
                            USING #tempStages AS SOURCE        
                            ON(TARGET.Id = SOURCE.StageId)        
                                WHEN MATCHED AND TARGET.StageTypeId <> SOURCE.StageTypeId OR TARGET.Name <> SOURCE.Name AND SOURCE.LanguageId = @enlanguageid        
                                THEN UPDATE SET          
                                                @stageid = TARGET.Id,        
                                                TARGET.Name = SOURCE.Name,        
            TARGET.StageTypeId = SOURCE.StageTypeId        
                                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid        
                                THEN        
                                  INSERT(        
       Name,        
    OrderNumber,      
    ServiceId,      
       StageTypeId        
       )        
                                  VALUES        
                            (Name,       
       @orderNumber,      
       @serviceId,      
                             StageTypeId        
                            );        
       SET @stageid = ISNULL(@stageid, SCOPE_IDENTITY());        
        
        MERGE service.Translations AS TARGET        
                            USING #tempStages AS SOURCE        
                            ON(TARGET.ItemId = SOURCE.StageId AND TARGET.LanguageId = SOURCE.LanguageId AND TARGET.TranslationKeyId = @translationkeyid)        
                                WHEN MATCHED AND TARGET.Value <> SOURCE.Name         
                                THEN UPDATE SET          
                                                TARGET.Value = SOURCE.Name        
                                WHEN NOT MATCHED BY TARGET         
                                THEN        
                                  INSERT(        
       TranslationKeyId,        
       ItemId,        
       LanguageId,        
       Value        
       )        
                                  VALUES        
                            (@translationkeyid,         
                             @stageId,        
        LanguageId,        
        Name        
                            );        
      
         SELECT @stageId AS Id,         
                           200 AS STATUS,         
                           'Success' AS Message;        
                    
            COMMIT TRANSACTION;        
        END TRY        
        BEGIN CATCH        
            ROLLBACK TRANSACTION;        
            SELECT @stageId AS Id,         
                   500 AS STATUS,         
                   ERROR_MESSAGE() AS Message;        
        END CATCH;        
    END 