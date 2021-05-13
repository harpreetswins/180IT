
/****** Object:  StoredProcedure [dbo].[sp_AddServices]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_AddServices] @Id      INT,     
                                       @Service NVARCHAR(4000)    
AS    
    BEGIN    
        BEGIN TRY    
            BEGIN TRAN;    
            DECLARE @ServiceId INT;    
            DECLARE @LanguageId INT;    
            SET @LanguageId = 1;    
            DECLARE @serviceTranslationKeyId INT = 11;    
   DECLARE @OrderNo AS INT;      
   DECLARE @descTranslationKeyId INT = 16;    
   --SELECT @DescTranslationKey = Id    
   --         FROM system.TranslationKeys    
   --         WHERE [Name] = 'Service Description';    
   --         SELECT @ServiceTranslationKey = Id    
   --         FROM system.TranslationKeys    
   --         WHERE [Name] = 'Services';    
            DECLARE @ServiceName AS VARCHAR(500);    
            SET @ServiceName = '';    
            CREATE TABLE #temp    
            (ServiceName  NVARCHAR(100),     
             GroupId      INT,     
             OrderNumber  INT,     
             StartStageId INT,  
    IsProfile   BIT,  
             LanguageId   INT,     
             Description  NVARCHAR(400)    
            );    
            INSERT INTO #temp    
            (ServiceName,     
             GroupId,     
             OrderNumber,     
             StartStageId,   
    IsProfile,  
             LanguageId,     
             Description    
            )    
                   SELECT ServiceName,     
                          groupId,     
                          orderNumber,     
                          startStageId,   
        isProfile,  
                          languageId,     
                          description    
                   FROM OPENJSON(@Service) WITH(ServiceName NVARCHAR(100), GroupId INT, OrderNumber INT, StartStageId INT, IsProfile BIT, LanguageId INT, Description NVARCHAR(400));    
            SELECT @ServiceName = ISNULL(ServiceName, '') + ',' + @ServiceName    
            FROM #Temp;    
            DECLARE @Name NVARCHAR(100);    
            DECLARE @Description NVARCHAR(400);    
   DECLARE @GroupId AS INT;  
            SELECT @Name = ServiceName,     
                   @Description = Description,  
       @GroupId = GroupId  
            FROM #temp    
            WHERE LanguageId = @LanguageId;    
  
   SET @OrderNo = (SELECT TOP 1 MAX(SS.OrderNumber) + 1 FROM service.Services SS WHERE SS.GroupId = @GroupId AND SS.IsDeleted = 0 GROUP BY SS.OrderNumber ORDER BY SS.OrderNumber DESC)   
  
                    IF EXISTS    
                    ( SELECT 1 FROM service.Services WHERE Id = @Id)    
                        BEGIN    
                            UPDATE service.Services SET Name = @Name, Description = @Description WHERE Id = @Id;    
      END;    
                    ELSE    
  
     IF(@OrderNo IS NULL)  
     BEGIN  
      INSERT INTO service.Services (Name, GroupId, OrderNumber, Description, Settings, StartStageID, IsProfile)    
                            SELECT ServiceName, GroupId, 0, Description, NULL, StartStageId, IsProfile FROM #temp WHERE LanguageId = @LanguageId;    
                            SET @ServiceId = SCOPE_IDENTITY();    
     END   
  
     ELSE  
  
                        BEGIN    
                            INSERT INTO service.Services (Name, GroupId, OrderNumber, Description, Settings, StartStageID, IsProfile)    
                            SELECT T.ServiceName, T.GroupId, (SELECT TOP 1 MAX(SS.OrderNumber) + 1 FROM service.Services SS WHERE SS.GroupId = T.GroupId AND SS.IsDeleted = 0 GROUP BY SS.OrderNumber ORDER BY SS.OrderNumber DESC), --SS.[Name] = T.ServiceName     
                                   T.Description, NULL, T.StartStageId, T.IsProfile FROM #temp T WHERE T.LanguageId = @LanguageId;    
                            SET @ServiceId = SCOPE_IDENTITY();    
      END;    
  
            IF @ServiceId > 0    
                BEGIN    
                    INSERT INTO service.Translations (TranslationKeyId, LanguageId, ItemId, Value)    
                    SELECT @serviceTranslationKeyId, LanguageId, @ServiceId, ServiceName FROM #temp;    
    
     INSERT INTO service.Translations (TranslationKeyId, LanguageId, ItemId, Value)    
     SELECT @descTranslationKeyId, LanguageId, @ServiceId, Description FROM #temp;    
    
    
    
                    SELECT @ServiceId AS Id,     
                           200 AS STATUS,     
                           'Success' AS Message;    
            END;    
            IF EXISTS    
            (    
                SELECT 1    
                FROM service.Services    
                WHERE Id = @Id    
            )    
                BEGIN    
                    UPDATE service.Translations    
                      SET     
                          service.Translations.Value = te.Description    
                    FROM service.Translations t    
                         INNER JOIN #temp te ON te.LanguageId = t.LanguageId    
                   -- WHERE t.ItemId = @Id AND t.TranslationKeyId = @serviceTranslationKeyId (SELECT Id FROM system.TranslationKeys WHERE [Name] = 'Service Description');    
                    WHERE t.ItemId = @Id AND t.TranslationKeyId = @serviceTranslationKeyId;    
					
     UPDATE service.Translations    
                      SET     
                          service.Translations.Value = te.ServiceName    
                    FROM service.Translations t    
                         INNER JOIN #temp te ON te.LanguageId = t.LanguageId    
                   -- WHERE t.ItemId = @Id AND t.TranslationKeyId = (SELECT Id FROM system.TranslationKeys WHERE [Name] = 'Services');    
                    WHERE t.ItemId = @Id AND t.TranslationKeyId = @serviceTranslationKeyId;    
					
                    SELECT @Id AS Id,     
                           200 AS STATUS,     
                           'Success' AS Message;    
            END;      
            COMMIT TRANSACTION;    
        END TRY    
        BEGIN CATCH    
            SELECT @ServiceId AS Id,     
                   500 AS STATUS,     
                   ERROR_MESSAGE() AS Message;    
            ROLLBACK TRANSACTION;    
        END CATCH;    
    END;
GO