
/****** Object:  StoredProcedure [dbo].[sp_AddApplications]    Script Date: 01-02-2021 19:49:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- exec sp_AddApplications 1,1,'','',NULL  
--   
-- =============================================  
ALTER PROCEDURE [dbo].[sp_AddApplications] @ServiceId         INT, 
                                            @CreatorId         NVARCHAR(100), 
                                            @UserAgent         NVARCHAR(500), 
                                            @ClientIP          NVARCHAR(50), 
                                            @ParentApplication INT, 
                                            @ProfileAppId      INT
AS
    BEGIN
		DECLARE @OpenStageID int = 1
        DECLARE @ApplicationId AS INT;
        DECLARE @CurrentDate AS DATETIME;
        SET @CurrentDate = GETDATE();
        DECLARE @uId INT;
        EXEC @uId = sp_GetUserId 
             @CreatorId;
        BEGIN TRY
            BEGIN TRAN;
            INSERT INTO application.Applications
            (ServiceId, 
             CreatorId, 
             CreatedOn, 
             DeviceTypeId, 
             ApplicationNumber, 
             UserAgent, 
             ClientIPAddress, 
             ParentApplicationId, 
             ProfileAppId
            )
            VALUES
            (@ServiceId, 
             @uId, 
             @CurrentDate, 
             1, 
             1, 
             @UserAgent, 
             @ClientIP, 
             NULL, 
             @ProfileAppId
            );
            SET @ApplicationId = SCOPE_IDENTITY();
            UPDATE application.Applications
              SET 
            -- ApplicationNumber = 'AppNo' + CAST(@ApplicationId AS VARCHAR(10))
                  ApplicationNumber = 'AppNo' + CONVERT(VARCHAR(10), @ApplicationId)
            WHERE Id = @ApplicationId;
            INSERT INTO application.ApplicationStages
            (ApplicationId, 
             UserId, 
             StageId, 
             CreatedOn, 
             StageStatusId, 
             PreviousStageId
            )
            VALUES
            (@ApplicationId, 
             @uId, 
            (
                SELECT TOP 1 Id
                FROM service.Stages
                WHERE ServiceId = @ServiceId
                ORDER BY Id ASC
            ), 
            @CurrentDate, 
            @OpenStageID, 
             NULL
            );
            SELECT @ApplicationId AS Id, 
                   200 AS STATUS, 
                   'Success' AS SuccessMessage;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            SELECT @ApplicationId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS ErrorMessage;
            ROLLBACK TRANSACTION;
        END CATCH;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AddEditEntities]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_AddEditEntities] @entities NVARCHAR(4000)      
AS      
    BEGIN      
 DECLARE @enlanguageid AS INT = 1, @aralanguageid AS INT = 2, @entityid AS INT, @translationkeyid AS INT = 17;  
 --Select @enlanguageid = id From system.Languages Where Name = 'English';  
 --Select @aralanguageid = id From system.Languages Where Name = 'Arabic';  
 --Select @translationkeyid = Id from system.TranslationKeys Where Name = 'Entity';  
          
  BEGIN TRY      
            BEGIN TRAN;      
                  
            CREATE TABLE #tempForms      
            (EntityId INT,  
   Name        NVARCHAR(100),    
    LanguageId INT   
            );      
            INSERT INTO #tempForms      
            (EntityId,  
   Name,  
    LanguageId  
         
            )      
                   SELECT EntityId,   
              Name,      
                          LanguageId      
                   FROM OPENJSON(@entities) WITH(EntityId INT, Name NVARCHAR(100), LanguageId INT);   
         
          MERGE service.Entities AS TARGET  
                            USING #tempForms AS SOURCE  
                            ON(TARGET.Id = SOURCE.EntityId)  
                                WHEN MATCHED AND TARGET.Name <> SOURCE.Name AND SOURCE.LanguageId = @enlanguageid  
                                THEN UPDATE SET    
                                                @entityid = TARGET.Id,  
                                                TARGET.Name = SOURCE.Name  
                                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid  
                                THEN  
                                  INSERT(  
       Name  
       )  
                                  VALUES  
                            (Name  
                            );  
       SET @entityid = ISNULL(@entityid, SCOPE_IDENTITY());  
  
        MERGE service.Translations AS TARGET  
                            USING #tempForms AS SOURCE  
                            ON(TARGET.ItemId = SOURCE.EntityId AND TARGET.LanguageId = SOURCE.LanguageId AND TARGET.TranslationKeyId = @translationkeyid)  
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
                             @entityId,  
        LanguageId,  
        Name  
                            );  
         SELECT @entityid AS Id,   
                           200 AS STATUS,   
                           'Success' AS SuccessMessage;  
              
            COMMIT TRANSACTION;  
        END TRY  
        BEGIN CATCH  
            ROLLBACK TRANSACTION;  
            SELECT @entityid AS Id,   
                   500 AS STATUS,   
                   ERROR_MESSAGE() AS ErrorMessage;  
        END CATCH;  
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_AddEditForms]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_AddEditForms] @stageid INT,   
                                         @forms   NVARCHAR(4000)  
AS  
    BEGIN  
        DECLARE @enlanguageid AS INT= 1, @aralanguageid AS INT= 2, @formid AS INT, @translationkeyid AS INT= 2, @ordernumber AS INT= 0;  
        BEGIN TRY  
            BEGIN TRAN;  
            CREATE TABLE #tempForms  
            (FormId     INT,   
             Name       NVARCHAR(100),   
             LanguageId INT,   
             EntityId   INT  
            );  
            INSERT INTO #tempForms  
            (FormId,   
             Name,   
             LanguageId,   
             EntityId  
            )  
                   SELECT FormId,   
                          Name,   
                          LanguageId,   
                          EntityId  
                   FROM OPENJSON(@forms) WITH(FormId INT, Name NVARCHAR(100), LanguageId INT, EntityId INT);           
            -- select * from #tempForms        
            MERGE service.Forms AS TARGET  
            USING #tempForms AS SOURCE  
            ON(TARGET.Id = SOURCE.FormId)  
                WHEN MATCHED --AND TARGET.Name <> SOURCE.Name  
                                 AND SOURCE.LanguageId = @enlanguageid      --TARGET.EntityId <> SOURCE.EntityId OR    
                THEN UPDATE SET   
                                @formid = TARGET.Id,   
                                TARGET.Name = SOURCE.Name,   
                                TARGET.EntityId = SOURCE.EntityId  
                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid  
                THEN  
                  INSERT(Name,   
                         EntityId)  
                  VALUES  
            (Name,   
             EntityId  
            );  
            SET @formid = ISNULL(@formid, SCOPE_IDENTITY());  
            MERGE service.Translations AS TARGET  
            USING #tempForms AS SOURCE  
            ON(TARGET.ItemId = SOURCE.FormId  
               AND TARGET.LanguageId = SOURCE.LanguageId  
               AND TARGET.TranslationKeyId = @translationkeyid)  
                WHEN MATCHED AND TARGET.Value <> SOURCE.Name  
                THEN UPDATE SET   
                                TARGET.Value = SOURCE.Name  
                WHEN NOT MATCHED BY TARGET  
                THEN  
                  INSERT(TranslationKeyId,   
                         ItemId,   
                         LanguageId,   
                         Value)  
                  VALUES  
            (@translationkeyid,   
             @formid,   
             LanguageId,   
             Name  
            );  
            IF(ISNULL(@stageid, 0) > 0)  
                BEGIN  
                    SELECT TOP 1 @ordernumber = ISNULL(OrderNumber, 0) + 1  
                    FROM service.StageForms  
                    WHERE StageId = @stageid  
                    ORDER BY FormId DESC;  
                    IF(  
                    (  
                        SELECT ISNULL(FormId, 0)  
                        FROM #tempForms  
                        WHERE Languageid = @enlanguageid  
                    ) < 1)  
                        BEGIN  
                            INSERT INTO service.StageForms  
                            (StageId,   
                             FormId,   
                             OrderNumber  
                            )  
                            VALUES  
                            (@stageid,   
                             @formid,   
                             @ordernumber  
                            );  
                    END;  
            END;  
            SELECT @formid AS Id,   
                   200 AS STATUS,   
                   'Success' AS SuccessMessage;  
            COMMIT TRANSACTION;  
        END TRY  
        BEGIN CATCH  
            ROLLBACK TRANSACTION;  
            SELECT @formid AS Id,   
                   500 AS STATUS,   
                   ERROR_MESSAGE() AS ErrorMessage;  
        END CATCH;  
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AddEditStages]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_AddEditStages 6,'[{"StageId":36,"LanguageId":1,"Name":"Capital ","StageTypeId":2},{"StageId":36,"LanguageId":2,"Name":"رأس المال","StageTypeId":2}]'    

ALTER PROCEDURE [dbo].[sp_AddEditStages] @serviceid INT, 
                                          @stages    NVARCHAR(4000)
AS
    BEGIN
        DECLARE @enlanguageid AS INT= 1, @aralanguageid AS INT= 2, @stageid AS INT, @translationkeyid AS INT= 12, @ordernumber AS INT= 0;
        BEGIN TRY
            BEGIN TRAN;
            CREATE TABLE #tempStages
            (StageId     INT, 
             Name        NVARCHAR(100), 
             LanguageId  INT, 
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

            -- Select * from #tempStages               

            SELECT TOP 1 @ordernumber = ISNULL(OrderNumber, 0) + 1
            FROM service.Stages
            WHERE ServiceId = @serviceid
            ORDER BY OrderNumber DESC;
            MERGE service.Stages AS TARGET
            USING #tempStages AS SOURCE
            ON(TARGET.Id = SOURCE.StageId)
                WHEN MATCHED AND SOURCE.LanguageId = @enlanguageid
                THEN UPDATE SET 
                                @stageid = TARGET.Id, 
                                TARGET.Name = SOURCE.Name, 
                                TARGET.StageTypeId = SOURCE.StageTypeId
                WHEN NOT MATCHED BY TARGET AND SOURCE.LanguageId = @enlanguageid
                THEN
                  INSERT(Name, 
                         OrderNumber, 
                         ServiceId, 
                         StageTypeId)
                  VALUES
            (Name, 
             @orderNumber, 
             @serviceId, 
             StageTypeId
            );
            SET @stageid = ISNULL(@stageid, SCOPE_IDENTITY());


            MERGE service.Translations AS TARGET
            USING #tempStages AS SOURCE
            ON(TARGET.ItemId = SOURCE.StageId
               AND TARGET.LanguageId = SOURCE.LanguageId
               AND TARGET.TranslationKeyId = @translationkeyid)
                WHEN MATCHED --AND TARGET.Value <> SOURCE.Name
                THEN UPDATE SET 
                                TARGET.Value = SOURCE.Name
                WHEN NOT MATCHED BY TARGET
                THEN
                  INSERT(TranslationKeyId, 
                         ItemId, 
                         LanguageId, 
                         Value)
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
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AddGroups]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_AddGroups] @Id     INT,     
                                      @Groups NVARCHAR(4000)    
AS    
    BEGIN    
        BEGIN TRY    
            BEGIN TRAN;    
            DECLARE @GroupId INT;    
            DECLARE @LanguageId AS INT;    
            SET @LanguageId = 1;    
            DECLARE @ParentId AS INT;    
            DECLARE @OrderNo AS INT;    
            DECLARE @GroupTranslationKey AS INT = 14;    
            DECLARE @DescTranslationkey AS INT = 15;    
            --SELECT @DescTranslationkey = Id    
            --FROM system.TranslationKeys    
            --WHERE [Name] = 'Group Description';    
            --SELECT @GroupTranslationKey = Id    
            --FROM system.TranslationKeys    
            --WHERE [Name] = 'Groups';    
            CREATE TABLE #temp    
            (Name        NVARCHAR(100),     
             ParentId    INT,     
             OrderNumber INT,     
             LanguageId  INT,     
             Description NVARCHAR(400)    
            );    
            INSERT INTO #temp    
            (Name,     
             ParentId,     
             OrderNumber,     
             LanguageId,     
             Description    
            )    
                   SELECT GroupName,     
                          ParentGroupId,     
                          OrderNumber,     
                          LanguageId,     
                          [Description]    
                   FROM OPENJSON(@Groups) WITH(GroupName NVARCHAR(100), ParentGroupId INT, OrderNumber INT, LanguageId INT, [Description] NVARCHAR(400));    
            DECLARE @Name NVARCHAR(100);    
            DECLARE @Description NVARCHAR(400);    
            SELECT @Name = Name,     
                   @Description = Description,     
                   @ParentId = ParentId    
            FROM #temp    
            WHERE LanguageId = @LanguageId;    
            SET @OrderNo =    
            (    
                SELECT MAX(SG.OrderNumber) + 1    
                FROM service.Groups SG    
                WHERE SG.ParentId = @ParentId    
                      AND SG.IsDeleted = 0    
            );    
            IF EXISTS    
            (    
                SELECT 1    
                FROM service.Groups    
                WHERE Id = @Id    
            )    
                BEGIN    
                    UPDATE service.Groups    
                      SET     
                          Name = @Name,     
                          Description = @Description    
                    WHERE Id = @Id;    
            END;    
                ELSE    
                BEGIN    
                    IF(@ParentId IS NOT NULL)    
                        BEGIN    
                            IF(@OrderNo IS NULL)    
                                BEGIN    
                                    INSERT INTO service.Groups    
                                    (Name,     
                                     ParentId,     
                                     OrderNumber,     
                                     Description    
                                    )    
                                           SELECT Name,     
                                                  ParentId,     
                                                  0,     
                                                  T.Description    
                                           FROM #temp T    
                                           WHERE T.LanguageId = @LanguageId;    
                                    SET @GroupId = SCOPE_IDENTITY();    
                            END;    
                                ELSE    
                                BEGIN    
                                    INSERT INTO service.Groups    
                                    (Name,     
                       ParentId,     
                                     OrderNumber,     
                                     Description    
                                    )    
                           SELECT Name,     
                                                  ParentId,     
                                                  @OrderNo,     
                                                  T.Description    
                                           FROM #temp T    
                                           WHERE T.LanguageId = @LanguageId;    
                                    SET @GroupId = SCOPE_IDENTITY();    
                            END;    
                    END;    
                        ELSE    
                        BEGIN    
                            INSERT INTO service.Groups    
                            (Name,     
                             ParentId,     
                             OrderNumber,     
                             Description    
                            )    
                                   SELECT Name,     
                                          ParentId,     
                                   (    
                                       SELECT MAX(SG.OrderNumber) + 1    
                                       FROM service.Groups SG    
                                       WHERE SG.IsDeleted = 0    
                                   ),     
                                          T.Description    
                                   FROM #temp T    
                                   WHERE T.LanguageId = @LanguageId;    
                            SET @GroupId = SCOPE_IDENTITY();    
                    END;    
            END;    
            IF @GroupId > 0    
                BEGIN    
                    INSERT INTO service.Translations    
                    (TranslationKeyId,     
                     LanguageId,     
                     ItemId,     
                     Value    
                    )    
                           SELECT @GroupTranslationKey,     
                                  T.LanguageId,     
                                  @GroupId,     
                                  T.Name    
                           FROM #Temp T;    
                    INSERT INTO service.Translations    
                    (TranslationKeyId,     
                     LanguageId,     
                     ItemId,     
                     Value    
                    )    
                           SELECT @DescTranslationkey,     
                                  T.LanguageId,     
                                  @GroupId,     
                                  T.Description    
                           FROM #Temp T;    
                    SELECT @GroupId AS Id,  
     (Select OrderNumber from service.Groups Where id = @GroupId)  AS OrderNumber,   
                           200 AS STATUS,     
                           'Success' AS Message;    
            END;    
            IF EXISTS    
            (    
                SELECT 1    
                FROM service.Groups    
                WHERE Id = @Id    
            )    
                BEGIN    
                    UPDATE service.Translations    
                      SET     
                          service.Translations.Value = te.Description    
                    FROM service.Translations t    
                         INNER JOIN #temp te ON te.LanguageId = t.LanguageId    
                    WHERE t.ItemId = @Id    
                          AND t.TranslationKeyId = @DescTranslationkey;   
                    --(    
                    --    SELECT Id    
                    --    FROM system.Translationkeys    
                    --    WHERE [Name] = 'Group Description'    
                    --);    
                    UPDATE service.Translations    
                      SET     
                          service.Translations.Value = te.Name    
                    FROM service.Translations t    
                         INNER JOIN #temp te ON te.LanguageId = t.LanguageId    
                    WHERE t.ItemId = @Id    
                          AND t.TranslationKeyId =  @GroupTranslationKey;
                    --(    
                    --    SELECT Id    
                    --    FROM system.Translationkeys    
                    --    WHERE [Name] = 'Groups'    
                    --);    
                    SELECT @Id AS Id,   
     (Select OrderNumber from service.Groups Where id = @Id)  AS OrderNumber,    
                           200 AS STATUS,     
                           'Success' AS Message;    
           END;    
            COMMIT TRANSACTION;    
        END TRY    
        BEGIN CATCH    
            SELECT @GroupId AS Id,     
                   500 AS STATUS,     
                   ERROR_MESSAGE() AS Message;    
            ROLLBACK TRANSACTION;    
        END CATCH;    
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AddLog]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--sp_AddLog '637426913323688117','Chrome','{\"Error\":\"ExecuteAction not working properly\",\"UserId\":2,\"ApplicationId\":14,\"ServiceId\":34,\"LanguageId\":2,\"ExceptionOn\":\"12/04/2020 03:14:52\"}','BadRequest'
ALTER PROCEDURE [dbo].[sp_AddLog]
-- Add the parameters for the stored procedure here
--@ExceptionId VARCHAR(100), 
@Browser     VARCHAR(50), 
@Status      VARCHAR(100),
@Error       VARCHAR(MAX), 
@UserId		NVARCHAR(100),
@ApplicationId INT,
@ServiceId     INT
AS
    BEGIN

	DECLARE @CurrentDate DATETIME;
	SET @CurrentDate = GETDATE();
	DECLARE @uId INT;
        EXEC @uId = sp_GetUserId 
             @UserId;

        SET NOCOUNT ON;

        -- Insert statements for procedure here
		  INSERT INTO lookup.Logs
        ([Browser], 
         [Status], 
         [Error],
		 [CreatedDate],
		 [UserId],
		 [ApplicationId],
		 [ServiceId]
        )
        VALUES
        (@Browser, 
         @Status,
         CONVERT(VARCHAR(MAX), @Error),
		 @CurrentDate,
		 @uId,
		 @ApplicationId,
		 @ServiceId
        );
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AddServices]    Script Date: 01-02-2021 19:49:13 ******/
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
            DECLARE @serviceTranslationKeyId INT= 11;
            DECLARE @OrderNo AS INT;
            DECLARE @descTranslationKeyId INT= 16;    
            DECLARE @ServiceName AS VARCHAR(500);
            SET @ServiceName = '';
            CREATE TABLE #temp
            (ServiceName  NVARCHAR(100), 
             GroupId      INT, 
             OrderNumber  INT, 
             StartStageId INT, 
             IsProfile    BIT, 
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
            SET @OrderNo =
            (
                SELECT TOP 1 MAX(SS.OrderNumber) + 1
                FROM service.Services SS
                WHERE SS.GroupId = @GroupId
                      AND SS.IsDeleted = 0
                GROUP BY SS.OrderNumber
                ORDER BY SS.OrderNumber DESC
            );
            IF EXISTS
            (
                SELECT 1
                FROM service.Services
                WHERE Id = @Id
            )
                BEGIN
                    UPDATE service.Services
                      SET 
                          Name = @Name, 
                          Description = @Description
                    WHERE Id = @Id;
            END;
                ELSE
                IF(@OrderNo IS NULL)
                    BEGIN
                        INSERT INTO service.Services
                        (Name, 
                         GroupId, 
                         OrderNumber, 
                         Description, 
                         Settings, 
                         StartStageID, 
                         IsProfile
                        )
                               SELECT ServiceName, 
                                      GroupId, 
                                      0, 
                                      Description, 
                                      NULL, 
                                      StartStageId, 
                                      IsProfile
                               FROM #temp
                               WHERE LanguageId = @LanguageId;
                        SET @ServiceId = SCOPE_IDENTITY();
                END;
                    ELSE
                    BEGIN
                        INSERT INTO service.Services
                        (Name, 
                         GroupId, 
                         OrderNumber, 
                         Description, 
                         Settings, 
                         StartStageID, 
                         IsProfile
                        )
                               SELECT T.ServiceName, 
                                      T.GroupId, 
                               (
                                   SELECT TOP 1 MAX(SS.OrderNumber) + 1
                                   FROM service.Services SS
                                   WHERE SS.GroupId = T.GroupId
                                         AND SS.IsDeleted = 0
                                   GROUP BY SS.OrderNumber
                                   ORDER BY SS.OrderNumber DESC
                               ),    
                                      T.Description, 
                                      NULL, 
                                      T.StartStageId, 
                                      T.IsProfile
                               FROM #temp T
                               WHERE T.LanguageId = @LanguageId;
                        SET @ServiceId = SCOPE_IDENTITY();
                END;
            IF (@ServiceId > 0)
                BEGIN
                    INSERT INTO service.Translations
                    (TranslationKeyId, 
                     LanguageId, 
                     ItemId, 
                     Value
                    )
                           SELECT @serviceTranslationKeyId, 
                                  LanguageId, 
                                  @ServiceId, 
                                  ServiceName
                           FROM #temp;
                    INSERT INTO service.Translations
                    (TranslationKeyId, 
                     LanguageId, 
                     ItemId, 
                     Value
                    )
                           SELECT @descTranslationKeyId, 
                                  LanguageId, 
                                  @ServiceId, 
                                  Description
                           FROM #temp;
                    SELECT @ServiceId AS Id, 
                    (
                        SELECT OrderNumber
                        FROM service.Services
                        WHERE Id = @ServiceId
                    ) AS Name, 
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
                          Value = te.ServiceName
                    FROM service.Translations t
                         INNER JOIN #temp te ON te.LanguageId = t.LanguageId     
                    WHERE t.ItemId = @Id
                          AND t.TranslationKeyId = @serviceTranslationKeyId;
                    UPDATE service.Translations
                      SET 
                          Value = te.Description
                    FROM service.Translations t
                         INNER JOIN #temp te ON te.LanguageId = t.LanguageId     
                    WHERE t.ItemId = @Id
                          AND t.TranslationKeyId = @descTranslationKeyId;
                    
                    SELECT @Id AS Id, 
                    (
                        SELECT OrderNumber
                        FROM service.Services
                        WHERE Id = @Id
                    ) AS Name, 
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
/****** Object:  StoredProcedure [dbo].[sp_AddUpdateStageActions]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                                        
-- Author:  Neeraj Saini                                        
-- Create date: 14 Jan,2021                                        
-- Description: create stage actions with translations.  
-- sp_AddUpdateStageActions 37,114,'[{"StageActionName":"test actions","ActionTypeId":1,"StageId":37,"DestinationStageId":37,"LanguageId":1,"Description":null,"Roles":""},{"StageActionName":"test actions","ActionTypeId":1,"StageId":37,"DestinationStageId":37,"LanguageId":2,"Description":null,"Roles":""}]'
-- =============================================                                        
ALTER PROCEDURE [dbo].[sp_AddUpdateStageActions] @stageid       INT,         
                                                 @stageactionid INT,         
                                                 @stageaction   NVARCHAR(4000)        
AS        
    BEGIN        
        
        -- Declare variable for order number                          
        DECLARE @ordernumber AS INT= 0, @enLanguageId INT= 1, @arLanguageId INT= 2, @stageActionTranslationKeyId INT= 7, @stageactionroles AS NVARCHAR(4000);        
        BEGIN TRY        
            BEGIN TRAN;        
        
            -- Create temporary stage actions                           
            CREATE TABLE #tempStages        
            (StageActionName    NVARCHAR(100),         
             ActionTypeId       INT,         
             StageId            INT,         
             DestinationStageId INT,         
             LanguageId         INT,         
             [Description]      NVARCHAR(400),         
             Roles              NVARCHAR(1000)        
            );        
            INSERT INTO #tempStages        
            (StageActionName,         
             ActionTypeId,         
             StageId,         
             DestinationStageId,         
             LanguageId,         
             [Description],         
             Roles        
            )        
                   SELECT StageActionName,         
                          ActionTypeId,         
                          StageId,        
                          CASE        
                              WHEN DestinationStageId = 0        
                              THEN NULL        
                              ELSE DestinationStageId        
                          END,         
                          LanguageId,         
                          [Description],         
                          Roles        
                   FROM OPENJSON(@stageaction) WITH(StageActionName NVARCHAR(100), ActionTypeId INT, StageId INT, DestinationStageId INT, LanguageId INT, [Description] NVARCHAR(400), Roles NVARCHAR(1000));        
        
            -- Initialize greatest order number if stage action type already exists for this stage                          
            SET @ordernumber = ISNULL(        
            (        
                SELECT TOP 1 OrderNumber        
                FROM service.StageActions        
                WHERE StageId = @stageid        
                ORDER BY OrderNumber DESC        
            ), 0);        
        
            -- Case :- create new stage action                          
            IF(@stageactionid < 1)        
                BEGIN        
                    INSERT INTO service.StageActions        
                    ([Name],         
                     ActionTypeId,         
                     OrderNumber,         
                     StageId,         
                     ToStageId        
                    )        
                           SELECT StageActionName,         
                                  ActionTypeId,         
                                  @ordernumber + 1,         
                                  StageId,         
                                  DestinationStageId        
                           FROM #tempStages        
                           WHERE LanguageId = @enLanguageId;        
                    SET @stageactionid = SCOPE_IDENTITY();        
                    INSERT INTO service.Translations        
                    (TranslationKeyId,         
                     LanguageId,         
                     ItemId,         
         Value        
                    )        
                           SELECT @stageActionTranslationKeyId,         
                                  tempSt.LanguageId,         
                                  @stageactionid,         
                                  tempSt.StageActionName        
                           FROM #tempStages tempSt        
                           WHERE tempSt.LanguageId = @enLanguageId;        
                    INSERT INTO service.Translations        
                    (TranslationKeyId,         
                     LanguageId,         
                     ItemId,         
                     Value        
                    )        
                           SELECT @stageActionTranslationKeyId,         
                                  tempS.LanguageId,         
                                  @stageactionid,         
                                  tempS.StageActionName        
                           FROM #tempStages tempS        
                           WHERE tempS.LanguageId = @arLanguageId;        
                    SELECT @stageactionid AS Id,         
                           200 AS STATUS,         
                           'Success' AS Message;        
            END;        
                ELSE        
                BEGIN        
        
                    -- Case :  update case for existing stage action                          
                    UPDATE [service].[StageActions]        
                      SET         
                          [Name] = temp.StageActionName,         
                          ActionTypeId = temp.ActionTypeId,         
                          StageId = temp.StageId,         
                          ToStageID = temp.DestinationStageId        
                    FROM #tempStages temp        
                    WHERE [service].[StageActions].Id = @stageactionid        
                          AND temp.LanguageId = @enLanguageId;        
                    UPDATE service.Translations        
                      SET         
                          service.Translations.Value = te.StageActionName        
                    FROM service.Translations t        
                         INNER JOIN #tempStages te ON te.LanguageId = t.LanguageId        
                    WHERE t.ItemId = @stageactionid        
                          AND t.TranslationKeyId = @stageActionTranslationKeyId        
                          AND t.LanguageId = te.LanguageId;        
            END;        
            SELECT TOP 1 @stageactionroles = t.Roles        
            FROM #tempStages t        
            WHERE t.LanguageId = @enLanguageId;        
            DECLARE @Target_Table TABLE        
            (RoleId        INT,         
             StageActionId INT        
            );        
            INSERT INTO @Target_Table        
                   SELECT value,         
                          @stageactionid        
                   FROM STRING_SPLIT(@stageactionroles, ',');        
      
      
      
            IF EXISTS        
            (        
                SELECT 1        
                FROM @Target_Table SAR        
                WHERE SAR.RoleId IS NOT NULL AND  SAR.RoleId  > 0      
            )        
                BEGIN        
                    IF EXISTS        
                    (        
                        SELECT 1        
                        FROM service.StageActionRoles        
                        WHERE StageActionId = @stageactionid        
                    )        
                        BEGIN        
                            DELETE FROM service.StageActionRoles        
                            WHERE StageActionId = @stageactionid        
                                  AND RoleId NOT IN        
                            (        
                                SELECT RoleId        
                                FROM @Target_Table        
                            );        
          INSERT INTO service.StageActionRoles        
                            (StageActionId,         
                             RoleId        
                            )        
                                   SELECT StageActionId,         
                                          RoleId        
          FROM @Target_Table        
                                   WHERE RoleId NOT IN        
                                   (        
                                       SELECT RoleId        
                                       FROM service.StageActionRoles        
                                       WHERE StageActionId = @stageactionid        
                                   );        
                    END;        
                        ELSE        
                        BEGIN        
                            INSERT INTO service.StageActionRoles        
                            (StageActionId,         
                             RoleId        
                            )        
                                   SELECT StageActionId,         
                                          RoleId        
                                   FROM @Target_Table;        
                    END;        
            END;   
   ELSE  
   BEGIN  
   Delete from service.StageActionRoles Where StageActionId = @stageactionid AND RoleId NOT IN (Select ISNULL(RoleId, 0) From @Target_Table Where StageActionId = @stageactionid)  
   END       
        
            /* END OF MERGE */        
        
            -- Return status, message and stageactionid                          
            SELECT @stageactionid AS Id,         
                   200 AS STATUS,         
                   'Success' AS Message;        
            COMMIT TRANSACTION;        
        END TRY        
        BEGIN CATCH        
            ROLLBACK TRANSACTION;        
            SELECT @stageactionid AS Id,         
                   500 AS STATUS,         
                   ERROR_MESSAGE() AS Message;        
        END CATCH;        
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AdminDeleteStageActions]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- exec sp_AdminDeleteStageActions   
-- =============================================  
ALTER PROCEDURE [dbo].[sp_AdminDeleteStageActions] @stageactionid AS INT
AS  
    BEGIN  
	BEGIN TRY
	BEGIN TRAN
     Delete From service.StageActionRoles
	  where StageActionId = @stageactionid

	  Delete from service.StageActions Where Id = @stageactionid

	   SELECT @stageactionid AS Id,     
                           200 AS STATUS,     
                           'Success' AS Message;    
                
            COMMIT TRANSACTION;    
        END TRY    
        BEGIN CATCH    
            ROLLBACK TRANSACTION;    
            SELECT @stageactionid AS Id,     
                   500 AS STATUS,     
                   ERROR_MESSAGE() AS Message;    
        END CATCH; 
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AdminGetForms]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AdminGetForms] @stageid AS INT
AS
    BEGIN
        DECLARE @formTranslationKeyId INT= 2;
        SELECT Id, 
               Name, 
               dbo.fn_multiLingualName(Id, @formTranslationKeyId) AS FormName
        FROM service.Forms sf
        WHERE Id NOT IN
        (
            SELECT FormId
            FROM service.stageforms
            WHERE stageid = @stageid
        );
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AdminGetRoles]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- exec sp_AdminGetRoles   
-- =============================================  
ALTER PROCEDURE [dbo].[sp_AdminGetRoles] 
AS  
    BEGIN  
     Select Id, Name from service.Roles
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AdminGetStageForms]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_AdminGetStageForms]     
AS    
BEGIN    
DECLARE @formTranslationKeyId INT= 2;      
        SELECT Id,       
               Name,       
               dbo.fn_multiLingualName(Id, @formTranslationKeyId) AS FormName      
        FROM service.Forms sf      
        --WHERE Id NOT IN      
        --(      
        --    SELECT FormId      
        --    FROM service.stageforms      
        --    WHERE stageid = @stageid      
        --);      
  END
GO
/****** Object:  StoredProcedure [dbo].[sp_AdminLinkUnlinkStageForms]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                    
-- Author:  <Author,,Name>                    
-- Create date: <Create Date,,>                    
-- Description: <Description,,>                    
-- sp_AdminLinkUnlinkStageForms 22,7,'true'                    
-- =============================================                    
ALTER PROCEDURE [dbo].[sp_AdminLinkUnlinkStageForms] @stageid INT,   
                                                      @formid  INT,   
                                                      @Status  BIT 
AS  
    BEGIN  
        BEGIN TRY  
            BEGIN TRAN;  
            DECLARE @ordernumber AS INT= 0;  
            SELECT @ordernumber = ISNULL(OrderNumber, 0)  
            FROM service.StageForms  
            WHERE StageId = @stageid  
                  AND FormId = @formid;  
            IF(@Status = 1)  
                BEGIN  
                    IF NOT EXISTS  
                    (  
                        SELECT 1  
                        FROM service.StageForms  
                        WHERE StageId = @stageid  
                              AND FormId = @formid  
                    )  
                        BEGIN  
                            INSERT INTO service.StageForms  
                            (StageId,   
                             FormId,   
                             OrderNumber  
                            )  
                            VALUES  
                            (@stageid,   
                             @formid,   
                             @ordernumber + 1  
                            );   
                    END;  
            END;  
                ELSE  
                BEGIN  
                    DELETE FROM service.StageForms  
                    WHERE StageId = @stageid  
                          AND FormId = @formid;  
                    UPDATE service.StageForms  
                      SET   
                          OrderNumber = OrderNumber - 1  
                    WHERE StageId = @stageid  
                          AND OrderNumber > @formid;  
            END;  
            SELECT @stageid AS ID,   
                   200 AS STATUS,   
                   'Success' AS SuccessMessage;  
            COMMIT TRANSACTION;  
        END TRY  
        BEGIN CATCH  
            ROLLBACK TRANSACTION;  
            SELECT @stageid AS ID,   
                   500 AS STATUS,   
                   ERROR_MESSAGE() AS ErrorMessage;  
        END CATCH;  
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckCurrentApplicationStatus]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,> 
-- exec [sp_CheckCurrentApplicationStatus] 1,1
-- =============================================
ALTER PROCEDURE [dbo].[sp_CheckCurrentApplicationStatus] @applicationid INT, @userid AS NVARCHAR(100)
AS
    BEGIN

	DECLARE  @uId int  
    EXEC @uId= sp_GetUserId @userId 

        SELECT TOP 1 ASS.Name AS statusName
        FROM application.ApplicationStages AAS
		INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
             INNER JOIN application.StageStatuses ASS ON ASS.Id = AAS.StageStatusId
        WHERE AAS.ApplicationId = @applicationid AND AA.CreatorId = @uId
        ORDER BY AAS.Id DESC;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteActionAttachment]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- sp_DeleteActionAttachment 
-- =============================================  
ALTER PROCEDURE [dbo].[sp_DeleteActionAttachment]  
(  
@actionattachmentId INT,
@applicationid INT
)  
AS  
BEGIN  
  
DECLARE @CurrentDate AS DATETIME      
SET @CurrentDate = GETDATE();     
  
BEGIN TRY  
 BEGIN TRAN  
  
 UPDATE application.ActionAttachments SET IsDeleted = 1, DeletedDate = @CurrentDate WHERE Id = @actionattachmentId  AND AppId = @applicationid
  
  
 SELECT @actionattachmentId AS Id, '200' AS Status, 'Success' as SuccessMessage;   
 COMMIT TRANSACTION  
END TRY  
  
BEGIN CATCH  
 ROLLBACK TRANSACTION  
 DECLARE @message VARCHAR(4000);  
 SELECT @message = ERROR_MESSAGE();  
 SELECT @actionattachmentId AS Id, 500 as Status,@message as ErrorMessage;  
END CATCH  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteAttachment]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_DeleteAttachment]
(
@attachmentId INT
)
AS
BEGIN

DECLARE @CurrentDate AS DATETIME    
SET @CurrentDate = GETDATE();   

BEGIN TRY
	BEGIN TRAN

	UPDATE application.ApplicationAttachments SET IsDeleted = 1, DeletedDate = @CurrentDate WHERE Id = @attachmentId


	SELECT @attachmentId AS Id, '200' AS Status, 'Success' as SuccessMessage; 
	COMMIT TRANSACTION
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @message VARCHAR(4000);
	SELECT @message = ERROR_MESSAGE();
	SELECT @attachmentId AS Id, 500 as Status,@message as ErrorMessage;
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGroup]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,> 
-- sp_DeleteGroup 15089,1 
-- =============================================  
ALTER PROCEDURE [dbo].[sp_DeleteGroup] @GroupId   INT, 
                               @DeletedBy INT
AS
    BEGIN
        DECLARE @CurrentDate DATETIME;
        SET @CurrentDate = GETDATE();
        BEGIN TRY
            BEGIN TRAN;
            UPDATE service.Groups
              SET 
                  IsDeleted = 1, 
                  DeletedDate = @CurrentDate, 
                  DeletedBy = @DeletedBy
            WHERE Id = @GroupId;
            IF(
            (
                SELECT ISNULL(ParentId, 0)
                FROM service.Groups
                WHERE Id = @GroupId
            ) > 0)
                BEGIN
                    UPDATE service.Groups
                      SET 
                          OrderNumber = OrderNumber - 1
                    WHERE OrderNumber > (Select OrderNumber From service.Groups Where id = @GroupId)
                          AND ParentId =
                    (
                        SELECT ISNULL(ParentId, 0)
                        FROM service.Groups
                        WHERE Id = @GroupId
                    )
                          AND IsDeleted = 0;
            END;
                ELSE
                BEGIN
                    UPDATE service.Groups
                      SET 
                          OrderNumber = OrderNumber - 1
                    WHERE OrderNumber > (Select OrderNumber From service.Groups Where id = @GroupId)
                          AND ParentId IS NULL
                          AND IsDeleted = 0;
            END;
            SELECT @GroupId AS Id, 
                   200 AS STATUS, 
                   'Success' AS Message;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            SELECT @GroupId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS Message;
            ROLLBACK TRANSACTION;
        END CATCH;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteService]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- sp_DeleteService 7045,4
-- =============================================
ALTER PROCEDURE [dbo].[sp_DeleteService] @ServiceId INT, 
                                  @DeletedBy INT
AS
    BEGIN
        DECLARE @CurrentDate DATETIME;
        SET @CurrentDate = GETDATE();
		DECLARE @GroupId INT
		SET @GroupId = (SELECT GroupId FROM service.Services WHERE Id = @ServiceId)

        BEGIN TRY
            BEGIN TRAN;
            UPDATE service.Services
              SET 
                  IsDeleted = 1, 
                  DeletedDate = @CurrentDate, 
                  DeletedBy = @DeletedBy
            WHERE Id = @ServiceId;

			Update service.Services SET OrderNumber = OrderNumber - 1 WHERE OrderNumber > (Select OrderNumber From service.Services Where Id = @ServiceId AND GroupId = @GroupId) AND GroupId = @GroupId AND IsDeleted = 0

            SELECT @ServiceId AS Id, 
                   200 AS STATUS, 
                   'Success' AS Message;
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
/****** Object:  StoredProcedure [dbo].[sp_DeleteStages]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_DeleteStages] @stageId INT

AS
BEGIN

BEGIN TRY
BEGIN TRAN

DELETE FROM [service].[Stages] WHERE Id = @stageId
Update [service].[Stages] SET OrderNumber = OrderNumber - 1 WHERE OrderNumber > (Select OrderNumber From [service].[Stages] Where Id = @stageId) 

SELECT @stageId AS Id,
		200 AS STATUS, 
        'Success' AS Message;

COMMIT TRANSACTION
END TRY

BEGIN CATCH
SELECT @stageId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS Message;
            ROLLBACK TRANSACTION;
END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ExecuteActions]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_ExecuteActions] @applicationId INT, 
                                           @stageActionId INT, 
                                           @userId        NVARCHAR(100), 
                                           @data          NVARCHAR(4000), 
                                           @comments      NVARCHAR(400)
AS
    BEGIN

        -- Get userid from sp_GetUserId function by passing user authenticated token                        
        DECLARE @uId INT;
        EXEC @uId = sp_GetUserId 
             @userId;

        -- Declaration of stage, service, status, parentid, entityfield id's and main, child json variables                        
        DECLARE @stageid AS INT, @serviceid AS INT, @statusId AS INT, @stagestatusid AS INT, @openstagestatusid AS INT= 1, @closestagestatusid AS INT= 2, @submitstageactiontypeid AS INT= 2, @parentId AS INT, @entityFieldId AS INT, @value AS NVARCHAR(1000), @childrensJson AS NVARCHAR(MAX), @applicationstageid AS INT, @nextstageavailability AS BIT= 0, @appStageActionId INT, @attachmentActionId INT, @attachmentAppStageId INT, @actiontypeid INT;
        SELECT @actiontypeid = ActionTypeId
        FROM service.StageActions
        WHERE Id = @stageActionId;
        SELECT @attachmentAppStageId = AppStageId, 
               @attachmentActionId = ActionTypeId
        FROM application.ActionAttachments
        WHERE AppId = @applicationId;

        -- Initialize values in declared variables                        
        SELECT TOP 1 @applicationstageid = AAS.Id, 
                     @stageid = AAS.StageId, 
                     @serviceid = AAA.ServiceId, 
                     @statusId = AAS.StageStatusId
        FROM application.ApplicationStages AAS
             INNER JOIN application.Applications AAA ON AAA.Id = AAS.ApplicationId
        WHERE AAS.ApplicationId = @applicationId
        ORDER BY AAS.Id DESC;
        IF EXISTS
        (
            SELECT 1
            FROM service.StageActions
            WHERE Id = @stageActionId
                  AND ToStageID <> @stageid
                  AND ToStageID IS NOT NULL
        )
            BEGIN
                SET @nextstageavailability = 1;
        END;

        --CREATE temporary tablewith existence check                        
        DROP TABLE IF EXISTS #temp;
        CREATE TABLE #temp
        (entityFieldId INT, 
         value         NVARCHAR(1000), 
         childrens     NVARCHAR(MAX)
        );
        BEGIN TRY
            BEGIN TRAN;
            IF(@statusId <> @closestagestatusid)
                BEGIN
                    INSERT INTO #temp
                    (entityFieldId, 
                     value, 
                     childrens
                    )
                           SELECT entityFieldId, 
                                  value, 
                                  childrens
                           FROM OPENJSON(@data) WITH(entityFieldId INT, value NVARCHAR(1000), childrens NVARCHAR(MAX) AS JSON);

                    -- Add update table Application Field Values data        
                    MERGE application.ApplicationFieldValues AS TARGET
                    USING #temp AS SOURCE
                    ON(TARGET.EntityFieldId = SOURCE.entityFieldId
                       AND TARGET.ApplicationId = @applicationid)
                        WHEN MATCHED AND SOURCE.childrens IS NULL
                                         AND TARGET.Value <> SOURCE.value
                        THEN UPDATE SET 
                                        TARGET.Value = SOURCE.value
                        WHEN NOT MATCHED BY TARGET AND SOURCE.childrens IS NULL
                        THEN
                          INSERT([ApplicationId], 
                                 [EntityFieldId], 
                                 [Value], 
                                 [ParentId], 
                                 [ItemIndex])
                          VALUES
                    (@applicationId, 
                     entityFieldId, 
                     value, 
                     NULL, 
                     0
                    );
                    DECLARE @childTemp TABLE
                    ([ApplicationId] INT, 
                     [EntityFieldId] INT, 
                     [Value]         NVARCHAR(1000), 
                     [ParentId]      INT, 
                     [itemIndex]     INT
                    );

                    -- DECLARE THE CURSOR FOR A QUERY.                              
                    DECLARE reference_form_cursor CURSOR READ_ONLY
                    FOR SELECT entityFieldId, 
                               value, 
                               childrens
                        FROM #temp
                        WHERE childrens IS NOT NULL;

                    --OPEN CURSOR.                              
                    OPEN reference_form_cursor;

                    --FETCH THE RECORD INTO THE VARIABLES.                              
                    FETCH NEXT FROM reference_form_cursor INTO @entityFieldId, @value, @childrensJson;

                    --LOOP UNTIL RECORDS ARE AVAILABLE.                             
                    WHILE @@FETCH_STATUS = 0
                        BEGIN
                            INSERT INTO application.ApplicationFieldValues
                            ([ApplicationId], 
                             [EntityFieldId], 
                             [Value], 
                             [ParentId]
                            )
                                   SELECT @applicationId, 
                                          @entityFieldId, 
                                          @value, 
                                          NULL
                                   FROM #temp
                                   WHERE childrens IS NOT NULL;
								   --Select @parentId

                            SET @parentId = SCOPE_IDENTITY();
                            INSERT INTO @childTemp
                            ([ApplicationId], 
                             [EntityFieldId], 
                             [Value], 
                             [ParentId], 
                             [itemIndex]
                            )
                                   SELECT @applicationId, 
                                          entityFieldId, 
                                          value, 
                                          @parentId, 
                                          itemIndex
                                   FROM OPENJSON(@childrensJson) WITH(entityFieldId INT, value NVARCHAR(1000), itemIndex INT);
                          
						    --MERGE application.ApplicationFieldValues AS TARGET
          --                  USING @childTemp AS SOURCE
          --                  ON(TARGET.EntityFieldId = SOURCE.entityFieldId
          --                     AND TARGET.ApplicationId = @applicationid
          --                     AND TARGET.ItemIndex = SOURCE.ItemIndex)
          --                      WHEN MATCHED AND TARGET.Value <> SOURCE.value
          --                      THEN UPDATE SET 
          --                                      TARGET.Value = SOURCE.value
          --                      WHEN NOT MATCHED BY TARGET
          --                      THEN
          --                        INSERT([ApplicationId], 
          --                               [EntityFieldId], 
          --                               [Value], 
          --                               [ParentId], 
          --                               [ItemIndex])
          --                        VALUES
          --                  (@applicationId, 
          --                   entityFieldId, 
          --                   value, 
          --                   @parentId, 
          --                   itemIndex
          --                  )
          --                      WHEN NOT MATCHED BY SOURCE
          --                      THEN DELETE;    
                            INSERT INTO application.ApplicationFieldValues        
                            ([ApplicationId],         
                             [EntityFieldId],         
                             [Value],         
                             [ParentId],         
                             [itemIndex]        
                            )        
                                   SELECT @applicationId,         
                                          entityFieldId,         
                                          value,         
                                          @parentId,         
                                          itemIndex        
                                   FROM OPENJSON(@childrensJson) WITH(entityFieldId INT, value NVARCHAR(1000), itemIndex INT);        
                            --FETCH THE NEXT RECORD INTO THE VARIABLES.                              
                            FETCH NEXT FROM reference_form_cursor INTO @entityFieldId, @value, @childrensJson;
            END;

                    --CLOSE THE CURSOR.                              
                    CLOSE reference_form_cursor;
                    DEALLOCATE reference_form_cursor;

                    -- testing purpose end              
                    -- Add data to application stage action table in respect to performed action..                  

                    INSERT INTO application.ApplicationStageActions
                    ([ApplicationStageId], 
                     [StageActionId], 
                     [CreatedOn], 
                     [UserId], 
                     [Data], 
                     [Comments]
                    )
                    VALUES
                    (
                    (
                        SELECT TOP 1 Id
                        FROM application.ApplicationStages
                        WHERE ApplicationId = @applicationid
                              AND StageStatusId = @openstagestatusid
                        ORDER BY 1 DESC
                    ), 
                    @stageActionId, 
                    GETDATE(), 
                    @uId, 
                    @data, 
                    @comments
                    );
                    SET @appStageActionId = SCOPE_IDENTITY();
                    IF(@stageid = @attachmentAppStageId
                       AND @actiontypeid = @attachmentActionId)
                        BEGIN
                            UPDATE application.ActionAttachments
                              SET 
                                  AppStageActionId = @appStageActionId
                            WHERE AppStageId = @attachmentAppStageId
                                  AND ActionTypeId = @attachmentActionId;
                    END;

                    -- Updation of application stage and its status based on action type                        
                    IF EXISTS
                    (
                        SELECT TOP 1 1
                        FROM application.ApplicationStages AAS
                        WHERE ApplicationId = @applicationid
                              AND AAS.StageStatusId = @openstagestatusid
                        ORDER BY AAS.Id DESC
                    )
                        BEGIN
                            IF(@nextstageavailability = 1)
                                BEGIN
                                    UPDATE AAS2
                                      SET 
                                          AAS2.StageStatusId = @closestagestatusid
                                    FROM application.ApplicationStages AAS2
                                    WHERE AAS2.ApplicationId = @applicationId
                                          AND AAS2.StageStatusId = @openstagestatusid
                                          AND AAS2.Id = @applicationstageid;
                                    INSERT INTO application.ApplicationStages
                                    ([ApplicationId], 
                                     [UserId], 
                                     [StageId], 
                                     [CreatedOn], 
                                     [StageStatusId], 
                                     [PreviousStageId]
                                    )
                                           SELECT TOP 1 ApplicationId, 
                                                        UserId, 
                                           (
                                               SELECT ToStageId
                                               FROM service.StageActions
                                               WHERE Id = @stageActionId
                                                     AND ToStageID <> @stageid
                                                     AND ToStageID IS NOT NULL
                                           ) AS StageId, 
                                                        GETDATE() AS CreatedOn, 
                                                        @openstagestatusid AS StageStatusId, 
                                                        StageId AS PreviousStageId
                                           FROM application.ApplicationStages
                                           WHERE ApplicationId = @applicationId
                                           ORDER BY ID DESC;
                            END;
                    END;
                    SELECT @stageActionId AS Id, 
                           200 AS STATUS, 
                           'Success' AS SuccessMessage;
            END;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            SELECT @stageActionId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS ErrorMessage;
        END CATCH;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetActionAttachmentById]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- sp_GetActionAttachmentById 47  
-- =============================================  
ALTER PROCEDURE [dbo].[sp_GetActionAttachmentById] @actionattachmentId INT, @applicationid INT  
AS  
    BEGIN  
        SELECT AppId AS ApplicationId,   
               AppStageId AS ApplicationStageId, 
               FileContents AS FileName,   
               FileName AS Name,   
               Extension  
        FROM application.ActionAttachments  
        WHERE Id = @actionattachmentId AND 
		      AppId = @applicationid AND 
              IsDeleted = 0;  
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllEntities]    Script Date: 01-02-2021 19:49:13 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetAllLanguages]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetAllLanguages] 
AS
    BEGIN
        SELECT L.Id AS 'Id', 
               L.Name AS 'LanguageName',
			   L.Direction AS 'Direction'
        FROM system.Languages AS L
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllStageTypes]    Script Date: 01-02-2021 19:49:13 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetApplicationActivityLogs]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetApplicationActivityLogs] @ApplicationId INT, 
                                                       @UserId        NVARCHAR(100)
AS
    BEGIN
        DECLARE @uId INT;
        EXEC @uId = sp_GetUserId 
             @UserId;
        DECLARE @serviceTranslationKeyId INT= 11, @stageTranslationKeyId INT= 12, @statusesTranslationKeyId INT= 13, @stageActionsTranslationKeyId INT= 7;
        DECLARE @ActivityLogs NVARCHAR(MAX);
        SET @ActivityLogs =
        (
            SELECT DISTINCT 
                   AA.Id AS ApplicationId, 
                   AA.ApplicationNumber AS ApplicationNumber, 
                   SS.Name AS ServiceName, 
                   JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId)) AS ServicesName, 
            (
                SELECT AAS1.StageId, 
                       SSS.Name AS StageName, 
                       JSON_QUERY(dbo.fn_multiLingualName(SSS.Id, @stageTranslationKeyId)) AS StagesName, 
                       ASS.Name AS StatusName, 
                       JSON_QUERY(dbo.fn_multiLingualName(ASS.Id, @statusesTranslationKeyId)) AS StatusesName, 
                (
                    SELECT AASA.CreatedOn AS PerformedDate, 
                           AASA.UserId AS CreatedBy, 
                           SSA.Name AS ActionName, 
                           JSON_QUERY(dbo.fn_multiLingualName(SSA.Id, @stageActionsTranslationKeyId)) AS StagesActionName, 
                           SAT.Name AS ActionTypeName, 
                           AASA.Comments, 
                    (
                        SELECT AAAS.Id, 
                               AAAS.Extension, 
                               AAAS.Size, 
                               AAAS.FileName
                        FROM application.ActionAttachments AAAS
                        WHERE AAAS.AppId = @ApplicationId
                              AND AAAS.AppStageActionId = AASA.Id
                              AND AAAS.IsDeleted = 0 FOR JSON PATH
                    ) AS ActionAttachment,
					 (
                        SELECT APTS.OrderNumber,
						APTS.OrderId,
						APTS.CreatedDateTime
                        FROM application.PaymentTransactions APTS
                        WHERE APTS.ApplicationStageId = AASA.ApplicationStageId
                          FOR JSON PATH
                    ) AS TransactionDetail
                    FROM application.ApplicationStageActions AASA             
                         --INNER JOIN [application.ApplicationStages] AAS3 ON AAS3.Id = AASA.ApplicationStageId            
                         INNER JOIN service.StageActions SSA ON SSA.Id = AASA.StageActionId
                         INNER JOIN lookups.ActionTypes SAT ON SAT.Id = SSA.ActionTypeId
                    WHERE AASA.ApplicationStageId = AAS1.Id
                    ORDER BY AASA.CreatedOn ASC FOR JSON PATH
                ) AS Actions
                FROM service.Stages SSS
                     INNER JOIN application.ApplicationStages AAS1 ON AAS1.StageId = SSS.Id
                     INNER JOIN lookups.StageStatuses ASS ON ASS.Id = AAS1.StageStatusId
                WHERE SSS.ServiceId = AA.ServiceId
                      AND AAS1.ApplicationId = AAS.ApplicationId FOR JSON PATH
            ) AS Stages
            FROM application.ApplicationStages AAS
                 INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
                 INNER JOIN service.Services SS ON SS.Id = AA.ServiceId
            WHERE AAS.ApplicationId = @ApplicationId FOR JSON PATH
        );
        SELECT @ActivityLogs AS ActivityLogs;
    END;


GO
/****** Object:  StoredProcedure [dbo].[sp_GetApplicationChildForm]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetApplicationChildForm 71,7,71    
ALTER PROCEDURE [dbo].[sp_GetApplicationChildForm] @applicationid AS      INT, 
                                                    @entityid AS           INT, 
                                                    @formsectionfieldid AS INT
AS
    BEGIN
        DECLARE @instructionsTranslationKeyId INT= 4, @FieldTranslationKeyId INT= 1, @formsectionfiledConstraintTranslationKeyId INT= 10, @attachmentConstraintTypesTranslationKeyId INT= 9, @AttachmentsTranslationKeyId INT= 6, @currentstageid INT;
        SELECT TOP 1 @currentstageid = StageId
        FROM application.ApplicationStages
        WHERE ApplicationId = @applicationid
        ORDER BY 1 DESC;
        DECLARE @childFormFields NVARCHAR(MAX);
        SET @childFormFields =
        (
            SELECT
            (
                SELECT FSF.Id AS id, 
                       FSF.EntityFieldId AS entityFieldId,
                       CASE
                           WHEN ISNULL(FSF.ShowOnMainForm, 0) = 0
                           THEN 'Hide'
                           ELSE 'Show'
                       END AS showOnMainForm, 
                       MAX(EF.Name) AS formSectionFieldNameKey, 
                       JSON_QUERY(dbo.fn_entityRelationships(EF.Id)) AS entityRelationships, 
                       JSON_QUERY(dbo.fn_multiLingualName(EF.Id, @instructionsTranslationKeyId)) AS instructions, 
                       (CASE
                            WHEN MAX(SAFV.Value) IS NULL
                            THEN ''
                            ELSE MAX(SAFV.Value)
                        END) AS formSectionFieldValue, 
                       SAFV.ItemIndex AS itemIndex, 
                       FT.Id AS fieldTypeId,               
            --MAX(EF.Name) AS formSectionFieldNameKey,               
                       JSON_QUERY(dbo.fn_multiLingualName(EF.Id, @FieldTranslationKeyId)) AS formSectionFieldName, 
                       JSON_QUERY(dbo.fn_formSectionFieldConstraints(FSF.Id, @formsectionfiledConstraintTranslationKeyId)) AS constraints
                FROM service.FormSectionFields FSF
                     INNER JOIN service.EntityFields EF ON EF.Id = FSF.EntityFieldId
                     INNER JOIN lookups.FieldTypes FT ON FT.Id = EF.FieldTypeId
                     LEFT JOIN application.ApplicationFieldValues SAFV ON SAFV.EntityFieldId = FSF.EntityFieldId
                                                                          AND SAFV.ApplicationId = @applicationid
                     LEFT JOIN service.EntityRelationships SER ON SER.EntityFieldId = EF.Id
                WHERE FSF.FormSectionParentId = @formsectionfieldid
                      AND FSF.FormSectionParentId IS NOT NULL
                GROUP BY FSF.Id, 
                         FSF.EntityFieldId, 
                         FSF.OrderNumber, 
                         FT.Id, 
                         EF.Id, 
                         FSF.FormSectionId, 
                         FSF.ShowOnMainForm, 
                         SAFV.ItemIndex
                ORDER BY SAFV.ItemIndex ASC FOR JSON PATH
            ) AS Fields, 
            (
                SELECT SFSA.Id AS FormSectionAttachmentId, 
                       SFSA.OrderNumber AS FormSectionAttachmentOrderNumber, 
                       SFSA.AttachmentId AS AttachmentId, 
                       SAT.Id AS AttachmentTypeId, 
                       JSON_QUERY(dbo.fn_attachmentFiles(SFSA.AttachmentId, @applicationid)) AS AttachmentFiles, 
                       JSON_QUERY(dbo.fn_attachmentConstraints(SFSA.Id, @attachmentConstraintTypesTranslationKeyId)) AS constraints, 
                       JSON_QUERY(dbo.fn_multiLingualName(SA.Id, @AttachmentsTranslationKeyId)) AS attachmentName--, 
        --        (
        --            SELECT AAA.FileContents, 
        --                   AAA.FileName, 
        --                   AAA.Extension,
						  -- AAA.ItemIndex
        --            FROM application.ApplicationAttachments AAA
        --            WHERE AAA.AppId = @applicationid
        --                  AND AAA.AttachmentId = SFSA.AttachmentId
        --                  AND AAA.AppStageId = @currentstageid
						  --AND AAA.IsDeleted = 0 FOR JSON PATH
        --        ) AS applicationAttachment
                FROM service.FormSectionAttachments SFSA
                     INNER JOIN service.Attachments SA ON SA.Id = SFSA.AttachmentId
                     INNER JOIN lookups.AttachmentTypes SAT ON SAT.Id = SA.AttachmentTypeId
                WHERE SFSA.FormSectionFieldId = @formsectionfieldid FOR JSON PATH
            ) AS FormSectionAttachments FOR JSON PATH
        );
        SELECT @childFormFields AS ChildFormFields;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetApplicationCurrentStage]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Neeraj Saini
-- Create date: 01 Dec, 2020
-- Description:	Get current application stage status.
-- =============================================

-- sp_GetApplicationCurrentStage 16

ALTER PROCEDURE [dbo].[sp_GetApplicationCurrentStage] @applicationid INT
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;
        SELECT TOP 1 ASS.Id, 
                     ASS.StageStatusId, 
                     ASA.StageActionId
        FROM application.ApplicationStages ASS
             LEFT JOIN application.ApplicationStageActions ASA ON ASA.ApplicationStageId = ASS.Id
        WHERE ASS.ApplicationId = @applicationid
        GROUP BY ASS.Id, 
                 ASS.StageStatusId, 
                 ASA.StageActionId
        ORDER BY ASS.Id DESC;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetApplicationForm]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetApplicationForm 87,null,'NAD Program Manager','09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0'
ALTER PROCEDURE [dbo].[sp_GetApplicationForm] @applicationid AS INT, 
                                              @stageid AS       INT, 
                                              @role AS          NVARCHAR(100), 
                                              @creatorId AS     NVARCHAR(100)
AS
    BEGIN
        DECLARE @roleId INT, @uId INT, @stageTranslationKeyId INT= 12, @formTranslationKeyId INT= 2, @serviceTranslationKeyId INT= 11, @stageStatusTranslationKeyId INT= 13, @isOwner BIT= 0, 
		@IsPermission INT = 1;  

		CREATE TABLE #temp(Id INT)
		INSERT INTO #temp
		EXEC sp_GetRoleId @role
		
		EXEC @uId = sp_GetUserId 
             @creatorId;
        IF(
        (
            SELECT TOP 1 CreatorId
            FROM application.Applications
            WHERE Id = @applicationid
        ) = @uId)
            BEGIN
                SET @isOwner = 1;
        END;

		DECLARE @currentStageId AS INT; 
		Select TOP 1 @currentStageId = StageId FROM application.ApplicationStages AAS Where ApplicationId = @applicationid ORDER BY 1 DESC

		DECLARE @yes AS BIT = 0; 
		IF EXISTS(SELECT SAR.RoleId FROM service.StageActionRoles SAR
		INNER JOIN service.StageActions SA ON SA.Id = SAR.StageActionId 
		WHERE EXISTS (SELECT Id FROM #temp) AND SA.StageId = @currentStageId)
		BEGIN
		SET @yes = 1;
		END

		IF(@yes = 1 OR @isOwner = 1)
		BEGIN
        SELECT DISTINCT TOP 1 AAS.StageId, 
                              AA.ApplicationNumber, 
                              SS.Name, 
                              SS.OrderNumber, 
                              AA.CreatedOn AS CreatedDate, 
                              AA.CreatorId, 
                              JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @stageTranslationKeyId)) AS stageName, 
                              AA.ProfileAppId AS ProfileAppId, 
                              JSON_QUERY(dbo.fn_multiLingualName(AAS.StageStatusId, @stageStatusTranslationKeyId)) AS CurrentStatusName,                        
        (
            SELECT F.id AS formId, 
                   F.Name AS formNameKey, 
                   SSs.Id AS formMode, 
                   SF.OrderNumber AS formOrder, 
                   SE.Id AS EntityId, 
                   JSON_QUERY(dbo.fn_multiLingualName(F.Id, @formTranslationKeyId)) AS formName, 
                   JSON_QUERY(dbo.fn_formSection(SF.FormId, @applicationid)) AS formSection
            FROM service.StageForms SF
                 INNER JOIN service.Forms F ON F.Id = SF.FormId
                 INNER JOIN service.Entities SE ON SE.Id = F.EntityId
                 INNER JOIN lookups.StageStatuses SSs ON SSs.Id = AAS.StageStatusId
                 INNER JOIN service.Stages SS1 ON SS1.Id = SF.StageId
            WHERE SF.StageId = AAS.StageId
                  AND SS1.ServiceId = AA.ServiceId
            ORDER BY SF.OrderNumber ASC FOR JSON PATH
        ) AS Forms, 
                              S.Id AS ServiceId, 
                              JSON_QUERY(dbo.fn_multiLingualName(S.Id, @serviceTranslationKeyId)) AS ServiceName,                               
							  JSON_QUERY(dbo.fn_stageActions(AAS.StageId, @role, @isOwner)) AS Actions,
							  @IsPermission AS IsPermission
        FROM application.ApplicationStages AAS
             INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
             INNER JOIN service.Stages SS ON SS.Id = AAS.StageId
             INNER JOIN service.Services S ON S.Id = AA.ServiceId
        WHERE aas.ApplicationId = @applicationid              
              -- AND AA.ProfileAppId IS NULL          
              AND (@stageid IS NULL
                   OR aas.StageId = @stageid)
        ORDER BY 1 DESC;
		END
		ELSE
		BEGIN
		SET @IsPermission = 0;
		SELECT @IsPermission AS IsPermission
		END
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetApplicationPaymentDetail]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetApplicationPaymentDetail] @applicationid AS INT, 
                                                        @languageid AS    INT, 
                                                        @userid AS        NVARCHAR(100), 
                                                        @stageActionId AS INT
AS
    BEGIN
        DECLARE @stageid AS INT, @stagestatusid AS INT, @applicationstageid AS INT, @orderid AS INT, @stagesettings AS NVARCHAR(500), @serviceId AS INT, @orderdate AS DateTime;
        DECLARE @paid AS INT, @message AS VARCHAR(50)= 'New', @currentdate AS DATETIME, @minute AS INT, @orderNumber AS VARCHAR(50);
        DECLARE @openStageStatusId INT= 1, @closeStageStatusId INT= 2, @paymentId INT= 2;
        DECLARE @uId INT;
        EXEC @uId = sp_GetUserId 
             @userid;
        BEGIN TRY
            BEGIN TRAN;
            SELECT DISTINCT TOP 1 @applicationstageid = AAS3.Id, 
                                  @stageid = AAS3.StageId, 
                                  @stagestatusid = AAS3.StageStatusId, 
                                  @stagesettings = SS2.Settings, 
                                  @serviceId = AA5.ServiceId
            FROM application.ApplicationStages AAS3
                 INNER JOIN application.applications AA5 ON AA5.Id = AAS3.ApplicationId
                 INNER JOIN service.Stages SS2 ON SS2.Id = AAS3.StageId
            WHERE applicationId = @applicationid
                  AND UserId = @uId
            ORDER BY AAS3.Id DESC;
            CREATE TABLE #tempStageSettings
            (ServiceCode VARCHAR(50), 
             Quantity    INT, 
             Amount      VARCHAR(50)
            );
            INSERT INTO #tempStageSettings
            (ServiceCode, 
             Quantity, 
             Amount
            )
                   SELECT ServiceCode, 
                          Quantity, 
                          Amount
                   FROM OPENJSON(@stagesettings) WITH(ServiceCode VARCHAR(50), Quantity INT, Amount VARCHAR(50));
            UPDATE #tempStageSettings
              SET 
                  Quantity = 1
            WHERE Quantity IS NULL;              
            -- select * from  #tempStageSettings              

            SELECT @paid = PT.Paid, 
                   @orderNumber = PT.OrderNumber, 
                   @currentdate = PT.CreatedDateTime
            FROM application.PaymentTransactions PT
            WHERE PT.ApplicationStageId = @applicationstageid;
            SET @minute =
            (
                SELECT DATEDIFF(MINUTE, @currentdate, GETDATE())
            );
            IF EXISTS
            (
                SELECT 1
                FROM application.PaymentTransactions PT
                WHERE PT.ApplicationStageId = @applicationstageid
            )
                BEGIN
                    IF(@paid IS NULL
                       AND @minute <= 15)
                        BEGIN
                            SET @message = 'Pending';
                    END;
                        ELSE
                        IF(@paid IS NULL
                           AND @minute >= 15)
                            BEGIN
                                SET @message = 'Check';
                        END;
                            ELSE
                            IF(@paid = 1)
                                BEGIN
                                    SET @message = 'Paid';
                            END;
                                ELSE
                                IF(@paid = 0)
                                    BEGIN
                                        SET @message = 'Failed';
                                END;
            END;
            IF(@message = 'Failed'
               OR @message = 'New')
                BEGIN
                    IF EXISTS
                    (
                        SELECT 1
                        FROM application.ApplicationStages AAS
                             INNER JOIN service.Stages SS ON SS.Id = AAS.StageId
                             INNER JOIN lookups.StageStatuses SSS ON SSS.Id = AAS.StageStatusId
                        WHERE AAS.applicationId = @applicationid
                              AND AAS.UserId = @uId
                              AND AAS.Id = @applicationstageid
                              AND AAS.StageStatusId = @openStageStatusId             
                              --(              
                              --    SELECT Id              
                              --    FROM lookups.StageStatuses              
                              --    WHERE [Name] = 'Open'              
                              --)              
                              AND AAS.StageId =
                        (
                            SELECT SS.Id
                            FROM service.Stages SS
                                 INNER JOIN application.applicationStages AAS ON AAS.StageId = SS.Id
                                 INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
                                 INNER JOIN lookups.StageTypes LST ON LST.Id = SS.StageTypeId
                            WHERE LST.Id = @paymentId
                                  AND AAS.Id = @applicationstageid
                                  AND AA.ServiceId = @serviceId
                        )
                    )
                        BEGIN
                            INSERT INTO application.PaymentTransactions
                            (OrderNumber, 
                             OrderDate, 
                             Paid, 
                             ApplicationStageId, 
                             TaxAmount, 
                             EDirhamFeesAmount, 
                             TotalAmount, 
                             CreatedBy, 
                             CreatedDateTime
                            )
                            VALUES
                            (1, 
                             GETDATE(), 
                             NULL, 
                             @applicationstageid, 
                             NULL, 
                             NULL, 
                             NULL, 
                             @uId, 
                             GETDATE()
                            );
                            SET @orderid = SCOPE_IDENTITY();
							SELECT @orderdate = CreatedDateTime From application.PaymentTransactions Where OrderId = @orderid
                            UPDATE application.PaymentTransactions
                              SET 
                                --  OrderNumber = 'ORD' + CONVERT(VARCHAR(10), @orderid)
								OrderNumber = 'ORD' + CAST(CAST(Datediff(s, '2000-01-01', @orderdate) AS BIGINT)*1000 AS Varchar(100))
                            WHERE OrderId = @orderid;
                            INSERT INTO [application].[PaymentTransactionDetails]
                            (OrderId, 
                             ServiceCode, 
                             Quantity, 
                             Amount
                            )
                                   SELECT @orderid, 
                                          JSON_VALUE(stagesetting.VALUE, '$.ServiceCode') AS ServiceCode, 
                                          ISNULL(JSON_VALUE(stagesetting.VALUE, '$.Quantity'), 1) AS Quantity, 
                                          JSON_VALUE(stagesetting.VALUE, '$.Amount') AS Amount
                                   FROM OPENJSON(@stagesettings) AS stagesetting;
                            INSERT INTO [application].[applicationstageactions]
                            (ApplicationStageId, 
                             StageActionId, 
                             CreatedOn, 
                             UserId, 
                             Data
                            )
                            VALUES
                            (@applicationstageid, 
                             @stageActionId, 
                             GETDATE(), 
                             @uId, 
                             NULL
                            );
                            SELECT DISTINCT TOP 1 AAS1.Id, 
                                                  AA1.ApplicationNumber AS ApplicationNumber, 
                                                  APT.OrderNumber AS OrderNumber, 
                            (
                                SELECT ServiceCode, 
                                       Quantity, 
                                       Amount
                                FROM #tempStageSettings FOR JSON AUTO, INCLUDE_NULL_VALUES
                            ) AS Services, 
                                                  'Ok' AS STATUS, 
                                                  @message AS Message
                            FROM application.ApplicationStages AAS1
                                 INNER JOIN application.Applications AA1 ON AA1.Id = AAS1.ApplicationId
                                 INNER JOIN application.PaymentTransactions APT ON APT.ApplicationStageId = AAS1.Id
                            WHERE applicationId = @applicationid
                                  AND UserId = @uId
                                  AND @stageid =
                            (
                                SELECT SS.Id
                                FROM service.Stages SS
                                     INNER JOIN application.applicationStages AAS ON AAS.StageId = SS.Id
                                     INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
                                     INNER JOIN lookups.StageTypes LST ON LST.Id = SS.StageTypeId
                                WHERE LST.Id = @paymentId
                                      AND AAS.Id = @applicationstageid
                                      AND AA.ServiceId = @serviceId
                            )
                                      AND @stagestatusid = @openStageStatusId          
                                     
                                      AND APT.OrderId = @orderid
                            ORDER BY AAS1.Id DESC;
                    END;
            END;
                ELSE
                BEGIN
                    SELECT @applicationstageid AS Id, 
                    (
                        SELECT AA.ApplicationNumber
                        FROM [application].[ApplicationStages] AAS
                             INNER JOIN [application].[Applications] AA ON AA.Id = AAS.ApplicationId
                        WHERE AAS.Id = @applicationstageid
                    ) AS ApplicationNumber, 
                           @orderNumber AS OrderNumber, 
                           NULL AS Services, 
                           'Ok' AS STATUS, 
                           @message AS Message;
            END;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            SELECT @orderid AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS ErrorMessage;
            ROLLBACK TRANSACTION;
        END CATCH;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAttachment]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetAttachment] @applicationId      INT, 
                                         @applicationStageId INT, 
                                         @attachmentId       INT
AS
    BEGIN
        SELECT AppId AS ApplicationId, 
               AppStageId AS ApplicationStageId, 
               AttachmentId, 
               FileContents AS FileName, 
               FileName AS Name, 
               Extension
        FROM application.ApplicationAttachments
        WHERE AppId = @applicationId
              AND AppStageId = @applicationStageId
              AND AttachmentId = @attachmentId
              AND IsDeleted = 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAttachmentById]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- sp_GetAttchmentById 47
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetAttachmentById] @attachmentId INT
AS
    BEGIN
        SELECT AppId AS ApplicationId, 
               AppStageId AS ApplicationStageId, 
               AttachmentId, 
               FileContents AS FileName, 
               FileName AS Name, 
               Extension
        FROM application.ApplicationAttachments
        WHERE Id = @attachmentId
              AND IsDeleted = 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCascadedLookupValues]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetCascadedLookupValues 56,4,1  
ALTER PROCEDURE [dbo].[sp_GetCascadedLookupValues] @EntityFieldId INT,     
                                                   @Value         INT,     
                                                   @LanguageId    INT    
AS    
    BEGIN    
        DECLARE @ParentId AS INT, @lookupsTranslationKeyId INT = 8, @systemLookupTranslationKeyId INT = 18;    
        SET @ParentId =    
        (    
            SELECT Id    
            FROM service.EntityFieldLookups    
            WHERE Value = @Value    
                  AND EntityFieldId = @EntityFieldId    
        );    
        SELECT DISTINCT     
               SFSF.EntityFieldId,     
               SFSF.FormSectionId,     
               SEF.FieldTypeId,     
               SFT.Name AS FieldTypeName, 
			   
			   ( CASE WHEN SEF.Settings IS NULL THEN         
      (SELECT LEFL.Value AS lookupId,     
                   STS.Value AS lookupValue,     
                   STS.ItemId AS LookupTranslationId,     
                   LEFL.EntityFieldId AS EntityFieldId    
            FROM service.EntityFieldLookups LEFL    
                 INNER JOIN service.Translations STS ON STS.ItemId = LEFL.id    
                 INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId    
            WHERE STK.Id = @lookupsTranslationKeyId   
                  AND STS.LanguageId = @LanguageId    
                  AND LEFL.ParentId = @ParentId FOR JSON PATH)               
        
		ELSE
		 (SELECT SLV.Id AS lookupId,  
				   STS.Value AS lookupValue,          
                   SLV.Name AS lookupFieldValue,                 
                   STS.ItemId AS LookupTranslationId,        
				   SEF.Id AS EntityFieldId  
      FROM system.LookupValues SLV             
      INNER JOIN system.SystemTranslations STS ON STS.ItemId = SLV.id            
      INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId              
     WHERE SLV.ParentId = @Value AND STK.Id = @systemLookupTranslationKeyId AND STS.LanguageId = @languageid AND SLV.LookupTypeId =  (select CAST(JSON_VALUE(Settings, '$.lookupTypeId') AS INT) from service.EntityFields where id = SFSF.EntityFieldId)         
     FOR JSON PATH)               
        
		END ) AS entityData 
			       
        --(    
        --    SELECT LEFL.Value AS lookupId,     
        --           STS.Value AS lookupValue,     
        --           STS.ItemId AS LookupTranslationId,     
        --           LEFL.EntityFieldId AS EntityFieldId    
        --    FROM service.EntityFieldLookups LEFL    
        --         INNER JOIN service.Translations STS ON STS.ItemId = LEFL.id    
        --         INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId    
        --    WHERE STK.Id = @lookupsTranslationKeyId   
        --          AND STS.LanguageId = @LanguageId    
        --          AND LEFL.ParentId = @ParentId FOR JSON PATH    
        --) AS entityData    
        FROM service.EntityFieldLookups LEFLS    
             INNER JOIN service.EntityFields SEF ON SEF.Id = LEFLS.EntityFieldId    
             INNER JOIN lookups.FieldTypes SFT ON SFT.Id = SEF.FieldTypeId    
             INNER JOIN service.FormSectionFields SFSF ON SFSF.EntityFieldId = SEF.Id    
        WHERE LEFLS.ParentId IS NOT NULL;    
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetChildEntityFieldLookups]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetChildEntityFieldLookups] @formsectionparentid AS     INT,               
                                                  @languageid AS INT              
              ,@serviceid AS INT              
AS              
    BEGIN          
 DECLARE @lookupTranslationKeyId INT = 8, @systemLookupTranslationKeyId INT = 18;      
        SELECT DISTINCT SFSF.EntityFieldId,               
               SFSF.FormSectionId,               
               SEF.FieldTypeId,               
               SFT.Name AS FieldTypeName,               
            
      (SELECT LEFL.Value AS lookupId,          
                   STS.Value AS lookupValue,               
                   STS.ItemId AS LookupTranslationId,      
       LEFL.EntityFieldId AS EntityFieldId              
          
      FROM service.EntityFieldLookups LEFL           
      INNER JOIN service.Translations   STS  ON STS.ItemId =  LEFL.id          
                 INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId            
     WHERE STS.ItemId = LEFL.id AND STK.Id = @lookupTranslationKeyId AND STS.LanguageId = @languageid AND LEFL.EntityFieldId = SFSF.EntityFieldId          
     FOR JSON PATH              
        ) AS entityData, 
		
		
		( CASE WHEN SEF.Settings IS NULL THEN         
      (SELECT LEFL.Value AS lookupId,          
                   STS.Value AS lookupValue,               
                   STS.ItemId AS LookupTranslationId,      
       LEFL.EntityFieldId AS EntityFieldId              
          
      FROM service.EntityFieldLookups LEFL           
      INNER JOIN service.Translations   STS  ON STS.ItemId =  LEFL.id          
                 INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId            
     WHERE STS.ItemId = LEFL.id AND STK.Id = @lookupTranslationKeyId AND STS.LanguageId = @languageid AND LEFL.EntityFieldId = SFSF.EntityFieldId          
     FOR JSON PATH)               
        
		ELSE
		 (SELECT SLV.Id AS lookupId,  
				   STS.Value AS lookupValue,          
                   SLV.Name AS lookupFieldValue,                 
                   STS.ItemId AS LookupTranslationId,        
				   SEF.Id AS EntityFieldId  
      FROM system.LookupValues SLV             
      INNER JOIN system.SystemTranslations STS ON STS.ItemId = SLV.id            
      INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId              
     WHERE STK.Id = @systemLookupTranslationKeyId AND STS.LanguageId = @languageid AND SLV.LookupTypeId =  (select CAST(JSON_VALUE(Settings, '$.lookupTypeId') AS INT) from service.EntityFields where id = SFSF.EntityFieldId)         
     FOR JSON PATH)               
        
		END ) AS entityData  
		       
              
        FROM         service.FormSectionFields SFSF              
             INNER JOIN service.EntityFields SEF ON SEF.id = SFSF.EntityFieldId              
             INNER JOIN lookups.FieldTypes SFT ON SFT.Id = SEF.FieldTypeId    
    INNER JOIN service.EntityFieldLookups LEFLS ON LEFLS.EntityFieldId = SFSF.EntityFieldId      
                
        WHERE SFSF.FormSectionParentId = @formsectionparentid AND SFSF.FormSectionId IS NULL;              
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetEntityFieldLookups]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetEntityFieldLookups] @formid AS     INT,                 
                                                  @languageid AS INT                
              ,@serviceid AS INT                
AS                
    BEGIN             
 DECLARE @lookupTranslationKeyId INT = 8, @systemLookupTranslationKeyId INT = 18;      
      SELECT DISTINCT SFSF.EntityFieldId,                 
               SFSF.FormSectionId,                 
               SEF.FieldTypeId,                 
               SFT.Name AS FieldTypeName,                 
    ( CASE WHEN SEF.Settings IS NULL THEN         
      (SELECT LEFL.Value AS lookupId,            
                   STS.Value AS lookupValue,                 
                   STS.ItemId AS LookupTranslationId,        
       LEFL.EntityFieldId AS EntityFieldId                
            
      FROM service.EntityFieldLookups LEFL             
      INNER JOIN service.Translations STS  ON STS.ItemId =  LEFL.id            
      INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId              
     WHERE STS.ItemId = LEFL.id AND STK.Id = @lookupTranslationKeyId AND STS.LanguageId = @languageid AND LEFL.EntityFieldId = SFSF.EntityFieldId            
    AND LEFL.ParentId Is NULL
	 FOR JSON PATH)               
        
		ELSE
		 (SELECT SLV.Id AS lookupId,  
				   STS.Value AS lookupValue,          
                   SLV.Name AS lookupFieldValue,                 
                   STS.ItemId AS LookupTranslationId,        
				   SEF.Id AS EntityFieldId  
      FROM system.LookupValues SLV             
      INNER JOIN system.SystemTranslations STS ON STS.ItemId = SLV.id            
      INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId              
     WHERE STK.Id = @systemLookupTranslationKeyId AND STS.LanguageId = @languageid AND SLV.LookupTypeId =  (select CAST(JSON_VALUE(Settings, '$.lookupTypeId') AS INT) from service.EntityFields where id = SFSF.EntityFieldId)         
     FOR JSON PATH)               
        
		END ) AS entityData           
        FROM service.Forms SF                
             INNER JOIN service.FormSections SFS ON SFS.FormId = SF.id                
             INNER JOIN service.FormSectionFields SFSF ON SFSF.FormSectionId = SFS.Id                
             INNER JOIN service.EntityFields SEF ON SEF.id = SFSF.EntityFieldId                
             INNER JOIN lookups.FieldTypes SFT ON SFT.Id = SEF.FieldTypeId       
			-- INNER JOIN service.EntityFieldLookups LEFLS ON LEFLS.EntityFieldId = SFSF.EntityFieldId              
        WHERE SF.Id = @formid --AND LEFLS.ParentId Is NULL              
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGroupsAndServices]    Script Date: 01-02-2021 19:49:13 ******/
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
    JSON_QUERY(dbo.fn_multiLingualName(G.Id, @groupTranslationKeyId)) AS name,      
               G.ParentId,           
               G.OrderNumber,           
        (          
            SELECT SG.Id,        
  JSON_QUERY(dbo.fn_multiLingualName(SG.Id, @groupTranslationKeyId)) AS name,      
  JSON_QUERY(dbo.fn_multiLingualName(SG.Id, @groupDescTranslationKeyId)) AS Description,     
       SG.ParentId,           
       SG.OrderNumber,          
                             
            (          
                SELECT SSs.Id,              
      JSON_QUERY(dbo.fn_multiLingualName(SSs.Id, @serviceTranslationKeyId)) AS name,  
   JSON_QUERY(dbo.fn_multiLingualName(SSs.Id, @serviceDescTranslationKeyId)) AS Description,  
      SSs.GroupId,          
      SSs.OrderNumber          
                FROM service.Services SSs          
                WHERE SSs.GroupId = SG.Id AND SSs.IsDeleted = 0 AND SSs.IsProfile = 0 FOR JSON PATH          
            ) AS groupServices          
            FROM service.Groups SG          
   WHERE SG.ParentId = G.Id          
   AND SG.IsDeleted = 0      
   ORDER BY OrderNumber ASC FOR JSON PATH          
        ) AS ChildGroups,           
        (          
            SELECT SS.Id,           
       JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId)) AS name,  
    JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @serviceDescTranslationKeyId)) AS Description   
            FROM service.Services SS          
            WHERE SS.GroupId = G.Id AND SS.IsDeleted = 0 AND SS.IsProfile = 0 FOR JSON PATH          
        ) AS groupServices          
        FROM service.Groups G 
		--INNER JOIN service.Services SS11 ON SS11.GroupId = G.Id
        WHERE G.IsDeleted = 0 AND G.ParentId IS NULL  -- AND SS11.IsProfile = 0  
		and G.Id not in (Select GroupId From Service.Services Where IsProfile = 1 )
	
  ORDER BY OrderNumber;  
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGroupsById]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- sp_GetGroupsById 9092
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetGroupsById] @GroupId INT
AS
    BEGIN
        SELECT DISTINCT 
               G.Id AS GroupId, 
               ParentId, 
               OrderNumber, 
               ST.LanguageId, 
        (
            SELECT ST1.Value AS GroupTranslatedName
            FROM system.TranslationKeys STK1
                 INNER JOIN service.Translations ST1 ON ST1.TranslationKeyId = STK1.Id
                                                          AND STK1.Name = 'Groups'
            WHERE ST1.ItemId = G.Id
                  AND ST1.LanguageId = ST.LanguageId FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        ) AS GroupName, 
        (
            SELECT ST2.Value AS GroupTranslatedDescription
            FROM system.TranslationKeys STK2
                 INNER JOIN service.Translations ST2 ON ST2.TranslationKeyId = STK2.Id
                                                          AND STK2.Name = 'Group Description'
            WHERE ST2.ItemId = G.Id
                  AND ST2.LanguageId = ST.LanguageId FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        ) AS GroupDescription
        FROM service.Translations ST
             INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId
             INNER JOIN service.Groups G ON ST.ItemId = G.Id
        WHERE G.Id = @GroupId
              AND IsDeleted = 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGroupServices]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetGroupServices        
ALTER PROCEDURE [dbo].[sp_GetGroupServices]          
AS          
    BEGIN      
 DECLARE @groupTranslationKeyId INT = 14, @serviceTranslationKeyId INT = 11, @serviceDescriptionTranslationKeyId INT = 16;  
        SELECT a.ID,           
              -- a.Name,        
            (SELECT ST.Value AS value,           
                       ST.LanguageId AS langId          
                FROM service.Translations ST          
                     INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId          
                     INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId          
                WHERE ST.ItemId =  a.Id         
                      AND STK.Id = @groupTranslationKeyId FOR JSON PATH ) AS Name,          
               COALESCE(b.Name, '-') AS 'ParentName',    
      a.ParentId,           
               a.OrderNumber AS GroupOrder,           
        (          
            SELECT s.Id,           
                   s.Name,           
                   s.OrderNumber ,        
        (          
                SELECT ST.Value AS value,           
                       ST.LanguageId AS langId          
                FROM service.Translations ST          
                     INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId          
                     INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId          
                WHERE ST.ItemId = S.Id          
                      AND STK.Id = @serviceTranslationKeyId FOR JSON PATH          
            ) AS serviceName,    
   (          
                SELECT ST.Value AS value,           
                       ST.LanguageId AS langId          
                FROM service.Translations ST          
                     INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId          
                     INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId          
                WHERE ST.ItemId = S.Id          
                      AND STK.Id = @serviceDescriptionTranslationKeyId FOR JSON PATH          
            ) AS serviceDescription       
            FROM service.Services AS s          
            WHERE s.GroupId = a.Id AND s.IsDeleted = 0 
   ORDER BY S.OrderNumber ASC FOR JSON PATH          
        ) AS Services          
        FROM service.Groups AS a          
             LEFT JOIN service.Groups AS b ON a.ParentID = b.Id WHERE a.IsDeleted = 0    
    ORDER BY a.OrderNumber ASC;          
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetResourceKeyValues]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetResourceKeyValues 'Menu,Button', 1
ALTER PROCEDURE [dbo].[sp_GetResourceKeyValues] @categoryname VARCHAR(100) = 'Menu,Button', 
                                                @languageid   INT          = 1
AS
    BEGIN
        DECLARE @data NVARCHAR(MAX), @delimiter NVARCHAR(5);
        SET @data = @categoryname;
        SET @delimiter = ',';
        DECLARE @textXML XML;
        -- SELECT @textXML = CAST('<d>' + REPLACE(@data, @delimiter, '</d><d>') + '</d>' AS XML);
        SELECT @textXML = CONVERT(XML, '<d>' + REPLACE(@data, @delimiter, '</d><d>') + '</d>');
        DECLARE @temp TABLE(Category VARCHAR(100));
        INSERT INTO @temp
               SELECT T.split.value('.', 'nvarchar(max)') AS data
               FROM @textXML.nodes('/d') T(split);
        SELECT TRV.Id AS 'Id', 
               TRK.TextresourcesKeyName AS 'Key', 
               TRV.Value AS 'Value', 
               TRC.TextResourceCategoryName AS 'Category'
        FROM system.TextResourceValues AS TRV
             INNER JOIN system.TextResourcesKeys AS TRK ON TRK.Id = TRV.TextResourcesKeyId
             INNER JOIN system.TextResourcesCategories AS TRC ON TRC.Id = TRK.TextResourceCategoryId
             INNER JOIN system.Languages AS L ON L.Id = TRV.LanguageId
        WHERE TRC.TextResourceCategoryName IN
        (
            SELECT Category
            FROM @temp
        )
              AND TRV.LanguageId = @languageid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRoleId]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- exec sp_GetRoleId 'NAD Program Manager,Admin'  
-- =============================================  
ALTER PROCEDURE [dbo].[sp_GetRoleId] @Role NVARCHAR(100)  
AS  
    BEGIN  
 DECLARE @temp TABLE (Roles VARCHAR(100));  
 INSERT INTO @temp(Roles) SELECT Item FROM SplitString(@Role, ',');  
   
   SELECT Id FROM [service].[Roles] WHERE [Name] IN (SELECT Roles FROM @temp);  
  
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetServiceProfileData]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================        
-- Author:  <Author,,Name>        
-- Create date: <Create Date,,>        
-- Description: <Description,,>        
-- sp_GetServiceProfileData 2,null,'06af3268-d501-4c43-92ef-6f71249dccdc'       
-- =============================================        
ALTER PROCEDURE [dbo].[sp_GetServiceProfileData] @ServiceId    INT, 
                                                 @ProfileAppId INT, 
                                                 @CreatorId    NVARCHAR(100)
AS
    BEGIN
        DECLARE @uId INT, @serviceTranslationKeyId INT= 11, @fieldTranslationKeyId INT= 1, @closeStatusTranslationKeyId INT= 2;
        EXEC @uId = sp_GetUserId 
             @CreatorId;
        DECLARE @ProfileData NVARCHAR(MAX);
        SET @ProfileData =
        (
            SELECT DISTINCT 
                   SSP.ProfileServiceId, 
                   JSON_QUERY(dbo.fn_multiLingualName(SSP.ProfileServiceId, @serviceTranslationKeyId)) AS serviceName, 
            (
                SELECT SST.Id, 
                (
                    SELECT AAS.ApplicationId, 
                           AAS.StageId, 
                    (
                        SELECT SFSF.EntityFieldId, 
                               EF.FieldTypeId, 
                        (
                            SELECT STS.Value AS value, 
                                   STS.LanguageId AS langId
                            FROM service.EntityFieldLookups LEFLS
                                 INNER JOIN application.ApplicationFieldValues SAFVS ON SAFVS.EntityFieldId = LEFLS.EntityFieldId
                                 INNER JOIN service.Translations STS ON STS.ItemId = LEFLs.id
                                 INNER JOIN system.TranslationKeys STK ON STK.Id = STS.TranslationKeyId
                            WHERE SAFVS.ApplicationId = AAS.ApplicationId
                                  AND LEFLS.EntityFieldId = SFSF.EntityFieldId
                                  AND CAST(LEFLS.Value AS VARCHAR(10)) = SAFV.Value FOR JSON PATH
                        ) AS lookupValues, 
                               (CASE
                                    WHEN MAX(SAFV.Value) IS NULL
                                    THEN ''
                                    ELSE MAX(SAFV.Value)
                                END) AS formSectionFieldValue, 
                               JSON_QUERY(dbo.fn_multiLingualName(SFSF.EntityFieldId, @fieldTranslationKeyId)) AS formSectionFieldName
                        FROM service.FormSectionFields SFSF
                             INNER JOIN service.EntityFields EF ON EF.Id = SFSF.EntityFieldId
                             LEFT JOIN application.ApplicationFieldValues SAFV ON SAFV.EntityFieldId = SFSF.EntityFieldId
                                                                                  AND SAFV.ApplicationId = AAS.ApplicationId
                        WHERE EF.IsPromoted = 1
                        GROUP BY SFSF.EntityFieldId, 
                                 EF.FieldTypeId, 
                                 SAFV.Value, 
                                 SFSF.OrderNumber
                        ORDER BY SFSF.OrderNumber ASC FOR JSON PATH
                    ) AS Fields
                    FROM application.ApplicationStages AAS
                         INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
                         INNER JOIN service.StageForms SSF ON SSF.StageId = AAS.StageId
                         INNER JOIN service.Forms SF ON SF.Id = SSF.FormId
                         INNER JOIN service.FormSections SFS ON SFS.FormId = SF.Id
                         INNER JOIN service.FormSectionFields FSF ON FSF.FormSectionId = SFS.Id
                         INNER JOIN service.EntityFields EF ON EF.Id = FSF.EntityFieldId
                    WHERE aas.StageId = SST.Id
                          AND AA.CreatorId = @uId
                          AND AAS.StageStatusId = @closeStatusTranslationKeyId
                          AND (@ProfileAppId IS NULL
                               OR AA.Id = @ProfileAppId)
                    GROUP BY AAS.ApplicationId, 
                             AAS.StageId
                    ORDER BY AAS.ApplicationId DESC FOR JSON PATH
                ) AS applications
                FROM service.Stages SST
                WHERE SST.ServiceId = SSP.ProfileServiceId FOR JSON PATH
            ) AS stages
            FROM service.ServiceProfiles SSP
                 INNER JOIN service.Services SS ON SSP.ServiceId = SS.Id
                 INNER JOIN application.Applications AA ON AA.ServiceId = SS.Id
            WHERE SS.Id = @ServiceId
                  AND SS.IsDeleted = 0 FOR JSON PATH
        );
        SELECT @ProfileData AS ProfileData;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetServicesById]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>      
-- sp_GetServicesById 6043      
-- =============================================      
ALTER PROCEDURE [dbo].[sp_GetServicesById] @ServiceId INT  
AS  
    BEGIN  
	DECLARE @serviceTranslationKeyId INT = 11, @serviceDescritionTranslationKeyId INT = 16;
        SELECT S.Id,   
               ST.LanguageId,   
        (  
            SELECT ST1.Value AS ServiceTranslatedName  
            FROM system.TranslationKeys STK1  
                 INNER JOIN service.Translations ST1 ON ST1.TranslationKeyId = STK1.Id  
                                                          AND STK1.Id = @serviceTranslationKeyId  
            WHERE ST1.ItemId = S.Id  
                  AND ST1.LanguageId = ST.LanguageId FOR JSON PATH, WITHOUT_ARRAY_WRAPPER  
        ) AS ServiceName,   
        (  
            SELECT ST2.Value AS ServiceTranslatedDescription  
            FROM system.TranslationKeys STK2  
                 INNER JOIN service.Translations ST2 ON ST2.TranslationKeyId = STK2.Id  
                                                          AND STK2.Id = @serviceDescritionTranslationKeyId 
            WHERE ST2.ItemId = S.Id  
                  AND ST2.LanguageId = ST.LanguageId FOR JSON PATH, WITHOUT_ARRAY_WRAPPER  
        ) AS ServiceDescription,   
               S.GroupId,   
               MAX(G.[Name]) AS GroupName,   
               S.OrderNumber,   
               S.StartStageID  
        FROM service.Translations ST  
             INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId  
             INNER JOIN service.Services S ON S.Id = ST.ItemId  
             INNER JOIN service.Groups G ON S.GroupId = G.Id  
        WHERE S.Id = @ServiceId  
              AND S.IsDeleted = 0  
        GROUP BY S.Id,   
                 ST.LanguageId,   
                 S.GroupId,   
                 S.OrderNumber,   
                 S.StartStageID;  
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStageActionsByStageId]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>      
-- sp_AddGroups       
-- =============================================      
ALTER PROCEDURE [dbo].[sp_GetStageActionsByStageId] @stageId INT
AS
    BEGIN
        SELECT SSA.ID AS StageActionId, 
               SSA.Name AS StageActionName, 
               SSA.OrderNumber AS OrderNumber, 
               SS.Name AS StageName, 
               SS1.Name AS DestinationStageName
        FROM service.StageActions SSA
             INNER JOIN service.Stages SS ON SS.Id = SSA.StageId
             LEFT JOIN service.Stages SS1 ON SS1.Id = SSA.ToStageId
        WHERE SSA.StageId = @stageid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStageActionTypes]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                
-- Author:  Neeraj Saini                
-- Create date: 14 Jan,2021                
-- Description: Get action types of service.                
-- =============================================                
ALTER PROCEDURE [dbo].[sp_GetStageActionTypes] @serviceid AS INT  
AS  
    BEGIN  
        SELECT    
               LAT.Id,   
               LAT.Name AS ActionType  
        FROM lookups.ActionTypes LAT  
            
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStagesByServiceId]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                  
-- Author:  <Author,,Name>                  
-- Create date: <Create Date,,>                  
-- Description: <Description,,>                  
-- sp_GetStagesByServiceId 61                   
-- =============================================                  
ALTER PROCEDURE [dbo].[sp_GetStagesByServiceId] @serviceid INT        
AS        
    BEGIN        
        DECLARE @translationkeyid AS INT = 12, @formtranslationkeyid AS INT = 2, @actiontranslationkeyid AS INT = 7;        
            
        
        SELECT SSS.Id AS StageId,         
        (        
            SELECT ST.LanguageId AS langId,         
                   ST.Value AS value        
            FROM service.Translations ST        
            WHERE ST.ItemId = SSS.Id        
                  AND ST.TranslationKeyId = @translationkeyid FOR JSON PATH        
        ) AS StageName,         
               SSS.OrderNumber AS OrderNumber,         
        (        
            SELECT Id AS StageTypeId,         
                   StageTypeName AS StageTypeName        
            FROM lookups.StageTypes        
            WHERE Id = LST.Id        
        FOR JSON PATH) AS StageTypeName,         
        (        
            SELECT SF.Id AS FormId,         
            (        
                SELECT ST.LanguageId AS langId,         
                       ST.Value AS value        
                FROM service.Translations ST        
                WHERE ST.ItemId = SF.Id        
                      AND ST.TranslationKeyId = @formtranslationkeyid FOR JSON PATH        
            ) AS FormName,         
                   SF.EntityId        
            FROM service.StageForms SSF        
                 INNER JOIN service.Forms SF ON SF.Id = SSF.FormId        
            WHERE SSF.StageId = SSS.Id        
            ORDER BY SSF.OrderNumber ASC FOR JSON PATH        
        ) AS Forms,         
        (        
            SELECT SSA.Id AS ActionId,         
                   (        
                SELECT ST.LanguageId AS langId,         
                       ST.Value AS value        
                FROM service.Translations ST        
                WHERE ST.ItemId = SSA.Id        
                      AND ST.TranslationKeyId = @actiontranslationkeyid FOR JSON PATH        
            )  AS StageActionName,      
   SSA.ActionTypeId,      
     SSA.ToStageID AS DestinationStageId,  
  (Select RoleId from service.StageActionRoles Where StageActionId = SSA.Id FOR JSON PATH) AS StageActionRoles   
            FROM service.StageActions SSA        
            WHERE SSA.StageId = SSS.Id FOR JSON PATH        
        ) AS Actions        
        FROM service.Stages SSS        
             INNER JOIN service.Services SS ON SS.Id = SSS.ServiceId        
             INNER JOIN lookups.StageTypes LST ON LST.Id = SSS.StageTypeId        
        WHERE SSS.ServiceId = @serviceid ORDER BY SSS.OrderNumber ASC;        
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStateMachineJson]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetStateMachineJson]
	@ServiceId int,
	@ShowIds bit = 0
AS
BEGIN
	select 'const fetchMachine = Machine({id: "'+STRING_ESCAPE(case @ShowIds when 1 then '('+ cast(service.Services.Id as varchar(50))+') ' end + service.Services.Name,'json')+'",initial:"'+  case @ShowIds when 1 then '('+ cast(InitialStage.Id as varchar(50))+') ' end + STRING_ESCAPE(InitialStage.Name,'json')+'"'+
	',states: {'+STUFF(
	(
		select ',"', case @ShowIds when 1 then '('+ cast(Id as varchar(50))+') ' end ,Name,'":',
		'{on: {'+STUFF(
			(
			SELECT        ',"' , case @ShowIds when 1 then '('+ cast(service.StageActions.Id as varchar(50))+') ' end, service.StageActions.Name , '":"', STRING_ESCAPE(ISNULL(case @ShowIds when 1 then '('+ cast(ToStage.Id as varchar(50))+') ' end + ToStage.Name, 'Done'), 'json') , '"' 
			FROM            service.StageActions INNER JOIN
									 service.Stages ON service.StageActions.StageId = service.Stages.Id LEFT OUTER JOIN
									 service.Stages AS ToStage ON service.StageActions.ToStageID = ToStage.Id
			WHERE        (service.Stages.Id = ParentStage.Id)
			FOR XML PATH(''),TYPE
			).value('.','VARCHAR(MAX)'),
			1, 1, ''
		)+'}}'
		from service.Stages ParentStage
		where ParentStage.ServiceId=service.Services.Id
		order by ParentStage.OrderNumber
		FOR XML PATH(''),TYPE
		).value('.','VARCHAR(MAX)'),
			1, 1, ''
	)+',"Done": {type: "final"}}});'
	from service.Services join service.Stages InitialStage on service.Services.StartStageID=InitialStage.Id
	where service.Services.Id = @ServiceId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUpdateTransactionDetail]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                  
-- Author:  <Author,,Name>                  
-- Create date: <Create Date,,>                  
-- Description: <Description,,>                  
-- sp_AddEditEntities                   
-- =============================================                  
ALTER PROCEDURE [dbo].[sp_GetUpdateTransactionDetail] @ordernumber       VARCHAR(50),           
                                                      @services          NVARCHAR(4000),           
                                                      @statusmessage     VARCHAR(100),           
                                                      @status            VARCHAR(20),           
                                                      @edirhamfees       DECIMAL(18, 2),           
                                                      @urn               VARCHAR(50),           
                                                      @transactionamount DECIMAL(18, 2),           
                                                      @paymentmethodtype VARCHAR(50),           
                                                      @success           VARCHAR(10),           
                                                      @errorid           INT,           
                                                      @languageid        INT,  
               @creatorId   NVARCHAR(100)  
AS         
    BEGIN         
        BEGIN TRY         
            BEGIN TRAN;         
            DECLARE @applicationstageid INT, @applicationid INT, @paymenttransactionid INT, @timediffrence INT, @returnmessage VARCHAR(50), @paid BIT, @openstatus INT = 1, @closestatus INT = 2,   
   @stageid INT, @serviceid INT, @statusId INT, @uId INT, @IsPermission INT = 1, @serviceTranslationKeyId INT = 11, @englanguageid INT = 1, @arabiclanguageid INT = 2;         
              
   EXEC @uId = sp_GetUserId @creatorId;  
              
            SELECT @paymenttransactionid = APT.OrderId,           
                   @applicationstageid = APT.ApplicationStageId,           
                   @timediffrence = DATEDIFF(minute, APT.CreatedDateTime, GETDATE()),           
                   @paid = APT.Paid         
            FROM application.PaymentTransactions APT         
            WHERE APT.OrderNumber = @ordernumber;         
            SELECT TOP 1 @stageid = AAS.StageId,           
                         @serviceid = AAA.ServiceId,           
                         @statusId = AAS.StageStatusId         
            FROM application.ApplicationStages AAS         
                 INNER JOIN application.Applications AAA ON AAA.Id = AAS.ApplicationId         
            WHERE AAS.Id = @applicationstageid         
            ORDER BY AAS.Id DESC;         
          
IF(ISJSON(@services) = 1)      
BEGIN      
            --CREATE temporary tablewith existence check                      
            DROP TABLE IF EXISTS #tempTransactions;         
            CREATE TABLE #tempTransactions         
            (ServiceCode VARCHAR(50),           
             Quantity    INT,           
             Amount      DECIMAL(18, 2),           
             TotalAmount DECIMAL(18, 2),           
             Tax         DECIMAL(18, 2)         
            );         
            INSERT INTO #tempTransactions         
            (ServiceCode,           
             Quantity,           
             Amount,           
             TotalAmount,           
             Tax         
            )         
                   SELECT ServiceCode,           
                          Quantity,           
                          Amount,           
                          TotalAmount,           
                          Tax         
                   FROM OPENJSON(@services) WITH(ServiceCode VARCHAR(50), Quantity INT, Amount DECIMAL(18, 2), TotalAmount DECIMAL(18, 2), Tax DECIMAL(18, 2));         
    
  MERGE application.PaymentTransactionDetails AS TARGET         
                            USING #tempTransactions AS SOURCE         
                            ON(TARGET.ServiceCode = SOURCE.ServiceCode)             
                            --When records are matched, update the records if there is any change            
                                WHEN MATCHED AND ISNULL(TARGET.Amount,0) <> SOURCE.Amount         
                                THEN UPDATE SET           
                                                TARGET.Amount = SOURCE.Amount;     
    
END      
            IF EXISTS         
            (         
                SELECT 1         
                FROM application.PaymentTransactions         
                WHERE OrderNumber = @ordernumber         
            )         
                BEGIN         
                    IF(@paid IS NULL)         
                        BEGIN         
                            UPDATE application.PaymentTransactions         
                              SET           
                                  SourceCode = @status,           
                                  EDirhamFeesAmount = @edirhamfees,           
                                  TotalAmount = @transactionamount,           
           URN = @urn,           
                                  Message = @statusmessage,         
         Paid = CASE WHEN @status = '0000' THEN 1 ELSE 0 END         
                            WHERE OrderNumber = @ordernumber;         
          
          
                                  
        Update application.ApplicationStageActions SET Data = (Select DISTINCT APT3.OrderId, APT3.OrderNumber AS OrderNumber,           
                       APT3.URN AS URN,           
                       APT3.CreatedDateTime AS PaymentDate,           
                       APT3.TaxAmount AS TaxAmount,           
                       APT3.EDirhamFeesAmount AS EDirhamFeesAmount,           
                       APT3.TotalAmount AS TotalAmount,           
                (          
                    SELECT APTD2.ServiceCode AS ServiceCode,           
                           SSC.ServiceDescriptionInEnglish AS EnglishDescription,           
                   SSC.ServiceDescriptionInArabic AS ArabicDescription,           
                           APTD2.Quantity AS Quantity,           
                           APTD2.Amount AS Amount          
                    FROM application.PaymentTransactionDetails APTD2          
                         LEFT JOIN service.ServiceCodes SSC ON SSC.ServiceCode = APTD2.ServiceCode          
                    WHERE APTD2.OrderId = APT3.OrderId FOR JSON PATH          
                ) AS Services   from application.PaymentTransactions APT3 WHERE APT3.OrderNumber = @ordernumber FOR JSON PATH) WHERE ApplicationStageId = @applicationstageid        
        
          
                            IF(@status = '0000')         
                                BEGIN         
                                    UPDATE application.ApplicationStages         
                                      SET           
                                          StageStatusId = @closestatus         
                                    WHERE Id = @applicationstageid;         
                                    IF EXISTS         
                                    (         
                                        SELECT 1         
                                        FROM service.Stages         
                                        WHERE ServiceId = @serviceId         
                                              AND id > @stageId         
                                    )         
                                        BEGIN         
                                            INSERT INTO application.ApplicationStages         
                                            ([ApplicationId],           
                                             [UserId],           
                                             [StageId],           
                                             [CreatedOn],           
                                             [StageStatusId],           
                                             [PreviousStageId]         
                                            )         
                                                   SELECT TOP 1 ApplicationId,           
                                                                UserId,           
                                                   (         
                                                       SELECT MIN(id)         
                                                       FROM service.Stages         
                                                       WHERE ServiceId = @serviceid         
                                                             AND id > @stageid         
                                                   ) AS StageId,           
                                                                GETDATE() AS CreatedOn,           
                                                                @openstatus AS StageStatusId,           
                                                                StageId AS PreviousStageId         
                                                   FROM application.ApplicationStages         
                                                   WHERE ApplicationId = @applicationId         
                                                   ORDER BY ID DESC;         
                                    END;         
                            END;         
                    END;         
            END;     
  
   IF(@uId = (SELECT CreatedBy FROM [application].[PaymentTransactions] WHERE OrderNumber = @ordernumber))  
   BEGIN  
            SELECT         
            (         
                SELECT DISTINCT           
                       --SS.Name AS ServiceName,
						dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId) AS ServiceName,              
                       AA.ApplicationNumber AS ApplicationNumber,           
                       SSS.Name AS StageName,           
                       APT1.OrderNumber AS OrderNumber,           
                       APT1.URN AS URN,           
                       APT1.CreatedDateTime AS PaymentDate,           
                       APT1.TaxAmount AS TaxAmount,           
                       APT1.EDirhamFeesAmount AS EDirhamFeesAmount,           
                       APT1.TotalAmount AS TotalAmount,           
                (         
                    SELECT APTD1.ServiceCode AS ServiceCode,

(Select 
'['+(Select @englanguageid AS langId, ServiceDescriptionInEnglish AS [value] FROM service.ServiceCodes WHERE ServiceCode = APTD1.ServiceCode  FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)+','+
(Select @arabiclanguageid AS langId, ServiceDescriptionInArabic AS [value] FROM service.ServiceCodes WHERE ServiceCode = APTD1.ServiceCode  FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)+ ']') AS ServiceCodeDescription,
           
                      --     SSC.ServiceDescriptionInEnglish AS EnglishDescription,           
                   			--SSC.ServiceDescriptionInArabic AS ArabicDescription,           
                           APTD1.Quantity AS Quantity,           
                           APTD1.Amount AS Amount         
                    FROM application.PaymentTransactionDetails APTD1         
                         LEFT JOIN service.ServiceCodes SSC ON SSC.ServiceCode = APTD1.ServiceCode         
                    WHERE APTD1.OrderId = APT1.OrderId FOR JSON PATH         
                ) AS Services,  
                 AAS.ApplicationId AS ApplicationId,  
     (CASE WHEN APT1.Paid IS NULL THEN 'Pending' WHEN APT1.Paid = 0 THEN 'Failed' ELSE 'Paid' END) AS PaymentStatus  
                FROM application.PaymentTransactions APT1         
                     INNER JOIN application.PaymentTransactionDetails APTD ON APTD.OrderId = APT1.OrderId         
                     INNER JOIN application.ApplicationStages AAS ON AAS.Id = APT1.ApplicationStageId         
                     INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId         
                     INNER JOIN service.Services SS ON SS.Id = AA.ServiceId         
                     INNER JOIN service.Stages SSS ON SSS.Id = AAS.StageId         
                WHERE APT1.OrderNumber = @ordernumber FOR JSON PATH, WITHOUT_ARRAY_WRAPPER         
            ) AS TransactionDetail,  
   @IsPermission AS IsPermission,  
            200 AS STATUS,           
            'Success' AS SuccessMessage;   
   END  
   ELSE  
   BEGIN  
   SET @IsPermission = 0  
   SELECT @IsPermission AS IsPermission  
   END  
            COMMIT TRANSACTION;         
        END TRY         
        BEGIN CATCH         
            ROLLBACK TRANSACTION;         
            SELECT NULL AS TransactionDetail,           
                   500 AS STATUS,           
                   ERROR_MESSAGE() AS ErrorMessage;         
        END CATCH;         
    END;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserApplicationCategories]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author: <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>      
-- exec sp_GetUserApplicationCategories '09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0'      
-- =============================================      
ALTER PROCEDURE [dbo].[sp_GetUserApplicationCategories] @userId NVARCHAR(100)    
AS    
    BEGIN    
    
        -- EXEC sp_GetUserId @userId          
    
        DECLARE @uId INT, @serviceTranslationKeyId INT = 11, @stageTranslationKeyId INT = 12, @statusesTranslationKeyId INT = 13;    
        EXEC @uId = sp_GetUserId     
             @userId;    
        DECLARE @applicationCategories NVARCHAR(MAX);    
        SET @applicationCategories =    
        (    
            SELECT S.Id AS serviceId,     
                   S.name,     
            (    
                SELECT ST.Value AS value,     
                       ST.LanguageId AS langId    
                FROM service.Translations ST    
                     INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId    
                     INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId    
                WHERE ST.ItemId = S.Id    
                      AND STK.Id = @serviceTranslationKeyId FOR JSON PATH    
            ) AS serviceName,     
            (    
                SELECT ss.id AS stageId,     
                       MAX(SS.Name) AS stageName,     
                (    
                    SELECT ST.Value AS value,     
                           ST.LanguageId AS langId    
                    FROM service.Translations ST    
                         INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId    
                         INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId    
                    WHERE ST.ItemId = ss.Id    
                          AND STK.Id = @stageTranslationKeyId FOR JSON PATH    
                ) AS stagesName,     
                (    
                    SELECT aass1.id AS stageStatusId,     
                           MAX(aass1.name) AS stageStatusName,     
                    --(    
                    --    SELECT ST.Value AS value,     
                    --           ST.LanguageId AS langId    
                    --    FROM service.Translations ST    
                    --         INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId    
                    --         INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId    
                    --    WHERE ST.ItemId = aass1.Id    
                    --          AND STK.Name = 'Statuses' FOR JSON PATH    
                    --) AS statusesName,     
     (        
             SELECT MAX(ST.Value) AS value,         
                    ST.LanguageId AS langId        
             FROM system.SystemTranslations ST        
                  INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId        
                  INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId        
             WHERE ST.ItemId = aass1.Id        
                   AND STK.Id = @statusesTranslationKeyId        
             GROUP BY ST.LanguageId     
    FOR JSON PATH        
         ) AS statusesName,    
                    (    
                        SELECT COUNT(DISTINCT(ASS6.Id))    
                        FROM application.Applications A6    
                             INNER JOIN application.ApplicationStages ASS6 ON A6.Id = ASS6.ApplicationId    
                             INNER JOIN lookups.StageStatuses aass ON ass6.StageStatusId = aass.id    
                             INNER JOIN service.Services SS1 ON SS1.Id = A6.ServiceId    
                        WHERE A6.CreatorId = @uId    
                              AND aass.id = aass1.Id    
                              AND ASS6.StageStatusId = aass1.Id    
                              AND A6.ServiceId = S.Id    
                              AND ASS6.StageId = ss.id    
                    ) AS StatusCount    
                    FROM lookups.StageStatuses aass1    
                    WHERE EXISTS    
                    (    
                        SELECT A2.id    
                        FROM application.Applications A2    
                             INNER JOIN application.ApplicationStages ASS2 ON A2.Id = ASS2.ApplicationId    
                        WHERE ass2.StageStatusId = aass1.id    
                              AND A2.CreatorId = @uId    
                              AND ASS2.StageId = ss.id    
                    )    
                    GROUP BY aass1.id    
                    HAVING    
                    (    
                        SELECT COUNT(DISTINCT(ASS6.Id))    
                        FROM application.Applications A6    
                             INNER JOIN application.ApplicationStages ASS6 ON A6.Id = ASS6.ApplicationId    
                             INNER JOIN lookups.StageStatuses aass ON ass6.StageStatusId = aass.id    
                             INNER JOIN service.Services SS1 ON SS1.Id = A6.ServiceId    
                        WHERE A6.CreatorId = @uId    
                              AND aass.id = aass1.Id    
                              AND ASS6.StageStatusId = aass1.Id    
                              AND A6.ServiceId = S.Id    
                              AND ASS6.StageId = ss.id    
                    ) > 0 FOR JSON PATH    
                ) AS stageStatuses    
                FROM service.Stages ss    
                     INNER JOIN application.ApplicationStages AAS7 ON AAS7.StageId = ss.Id    
                WHERE EXISTS    
                (    
                    SELECT A11.id    
                    FROM application.Applications A11    
                         INNER JOIN application.ApplicationStages AAS11 ON AAS11.ApplicationId = A11.Id    
                    WHERE A11.ServiceId = S.Id    
                          AND A11.CreatorId = @uId    
                )    
                GROUP BY ss.id    
     HAVING    
                    (    
                        SELECT COUNT(DISTINCT(ASS6.Id))    
                        FROM application.Applications A6    
                             INNER JOIN application.ApplicationStages ASS6 ON A6.Id = ASS6.ApplicationId    
                             INNER JOIN lookups.StageStatuses aass ON ass6.StageStatusId = aass.id    
                             INNER JOIN service.Services SS1 ON SS1.Id = A6.ServiceId    
                        WHERE A6.CreatorId = @uId    
                              AND A6.ServiceId = S.Id    
                              AND ASS6.StageId = ss.id    
                    ) > 0     
    FOR JSON PATH    
            ) AS stages    
            FROM service.Services S    
            WHERE EXISTS    
            (    
                SELECT A.id    
                FROM application.Applications A    
                WHERE A.ServiceId = S.Id    
                      AND A.CreatorId = @uId    
            ) FOR JSON PATH    
        );    
        SELECT '200' AS STATUS,     
               @applicationCategories AS ApplicationCategories;    
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserApplicationsDetail]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  Neeraj  
-- Create date: 02 Dec,2020   
-- Description: Get User Applications   
-- exec sp_GetUserApplicationsDetail 16,
-- =============================================    

ALTER PROCEDURE [dbo].[sp_GetUserApplicationsDetail] @applicationid AS INT,
@userId AS NVARCHAR(100)
AS
    BEGIN

DECLARE  @uId int , @serviceTranslationKeyId INT= 11, @stageTranslationKeyId INT= 12, @statusesTranslationKeyId INT= 13  
EXEC @uId= sp_GetUserId @userId  
--SELECT @uId;
--PRINT @uId
        SELECT TOP 1 AA.ApplicationNumber AS ApplicationNumber, 
                     --SST.Name AS StageName, 
					 JSON_QUERY(dbo.fn_multiLingualName(SST.Id, @stageTranslationKeyId)) AS StageName, 
                     AA.ServiceId AS ServiceId, 
                     --SS.Name AS ServiceName, 
					 JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId)) AS ServiceName,
                     --ASS.Name AS ApplicationStatus,
					 JSON_QUERY(dbo.fn_multiLingualName(ASS.Id, @statusesTranslationKeyId)) AS ApplicationStatus,
					 Null AS AssignedTo,
                     Null AS Notes,
                     Null AS Instructions
        FROM application.ApplicationStages APS
             INNER JOIN application.Applications AA ON AA.Id = APS.ApplicationId
             INNER JOIN service.Services SS ON SS.Id = AA.ServiceId
             INNER JOIN service.Stages SST ON SST.Id = APS.StageId
             INNER JOIN lookups.StageStatuses ASS ON ASS.Id = APS.StageStatusId
        WHERE APS.ApplicationId = @applicationid and APS.UserId = @uId
        ORDER BY APS.Id DESC;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserApplicationsList]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================        
-- Author:  Neeraj      
-- Create date: 02 Dec,2020       
-- Description: Get User Applications Result Detail     
-- exec sp_GetUserApplicationsList '52761bd1-bb91-40be-b713-44ca5c32e089',16,16,2,1,100,'2020-12-16','2020-12-17',null   
-- exec sp_GetUserApplicationsList '52761bd1-bb91-40be-b713-44ca5c32e089',16,16,2,1,100,null,null,null   
-- =============================================        

ALTER PROCEDURE [dbo].[sp_GetUserApplicationsList] @creatorid AS     NVARCHAR(100), 
                                                    @serviceid AS     INT, 
                                                    @stageid AS       INT, 
                                                    @stagestatusid AS INT, 
                                                    @pagenumber AS    INT, 
                                                    @pagesize AS      INT, 
                                                    @start AS         DATETIME, 
                                                    @end AS           DATETIME, 
                                                    @search AS        VARCHAR(100)  = NULL
AS
     DECLARE @uId INT, @statusTranslationKeyId INT= 13, @stageTranslationKeyId INT= 12;
     EXEC @uId = sp_GetUserId 
          @creatorid;
    BEGIN
        WITH CTE_Results
             AS (SELECT DISTINCT AAS.Id AS applicationStageId, 
                        AAS.ApplicationId AS applicationId, 
                        AA.ApplicationNumber AS applicationNumber,               
                        --ASS.Name StatusName,    
                 (
                     SELECT MAX(ST.Value) AS value, 
                            ST.LanguageId AS langId
                     FROM system.SystemTranslations ST
                          INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId
                          INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId
                     WHERE ST.ItemId = ASS.Id
                           AND STK.Id = @statusTranslationKeyId
                     GROUP BY ST.LanguageId FOR JSON PATH
                 ) AS StatusName, 
                        JSON_QUERY(dbo.fn_multiLingualName(SS.Id, @stageTranslationKeyId)) AS stageName,     
                 --SS.Name AS stageName,              
                        AAS.CreatedOn AS createdOn, 
                        AAS.UserId AS createdBy, 
                        NULL AS assignedTo, 
                        AAS.StageId AS StageId
                 FROM application.ApplicationStages AAS
                      INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
                      INNER JOIN lookups.StageStatuses ASS ON ASS.Id = AAS.StageStatusId
                      INNER JOIN service.Stages SS ON SS.Id = AAS.StageId
                 WHERE AAS.UserId = @uId
                       AND (@serviceid IS NULL
                            OR AA.ServiceId = @serviceid)
                       AND (@stagestatusid IS NULL
                            OR AAS.StageStatusId = @stagestatusid)
                       AND (@stageid IS NULL
                            OR AAS.StageId = @stageid)
                 ORDER BY AAS.ApplicationId
                 OFFSET @pageSize * (@pageNumber - 1) ROWS FETCH NEXT @pageSize ROWS ONLY),
             CTE_TotalRows
             AS (SELECT COUNT(AAS.Id) AS TotalRows
                 FROM application.ApplicationStages AAS
                      INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId
                 WHERE AAS.UserId = @uId
                       AND (@serviceid IS NULL
                            OR AA.ServiceId = @serviceid)
                       AND (@stagestatusid IS NULL
                            OR AAS.StageStatusId = @stagestatusid)
                       AND (@stageid IS NULL
                            OR AAS.StageId = @stageid)
                       AND (@start IS NULL
                            OR (@start IS NOT NULL
                                AND CONVERT(DATE, AAS.createdOn) >= @start))
                       AND (@end IS NULL
                            OR (@end IS NOT NULL
                                AND CONVERT(DATE, AAS.createdOn) <= @end)))
             SELECT *
             FROM CTE_Results temp, 
                  CTE_TotalRows
             WHERE(@start IS NULL
                   OR (@start IS NOT NULL
                       AND CONVERT(DATE, temp.createdOn) >= @start))
                  AND (@end IS NULL
                       OR (@end IS NOT NULL
                           AND CONVERT(DATE, temp.createdOn) <= @end))
                  AND ((@search IS NULL
                        OR temp.stageName LIKE '%' + ISNULL(@search, '') + '%')
                       OR (@search IS NULL
                           OR temp.StatusName LIKE '%' + ISNULL(@search, '') + '%')
                       OR (@search IS NULL
                           OR temp.applicationNumber LIKE '%' + ISNULL(@search, '') + '%')) OPTION(RECOMPILE);
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserId]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetUserId] 
@userId NVARCHAR(100)
AS
BEGIN

DECLARE @newId INT
	
	--BEGIN TRY
	--	BEGIN TRAN
			IF EXISTS (SELECT 1 FROM application.Users WHERE [ExternalId] = @userId)
			BEGIN
				
				SET @newId = (SELECT Id FROM application.Users WHERE [ExternalId] = @userId)
				Return @newId
			END
			ELSE
			BEGIN
				INSERT INTO application.Users([ExternalId]) VALUES(@userId)
				
				SET @newId = SCOPE_IDENTITY()    

				Return @newId  

			END

END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserPaymentList]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- sp_GetUserPaymentList '09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0',1,100,null,null,null    
-- sp_GetUserPaymentList '09a5a5f0-6b8f-4a33-bf1f-bd45aee6a9e0',1,100,'2021-01-15','2021-01-17',null     
-- =============================================    
ALTER PROCEDURE [dbo].[sp_GetUserPaymentList] @creatorid AS        NVARCHAR(100),              
            @pagenumber AS        INT,                 
            @pagesize AS      INT,           
            @start  AS DATETIME,            
            @end AS DATETIME,            
            @search AS Varchar(100) = null             
    
AS    
    
DECLARE  @uId int, @serviceTranslationKeyId INT = 11;                
EXEC @uId= sp_GetUserId @creatorid               
    BEGIN       
    
  WITH CTE_Results AS                  
 (                
        SELECT AA.ApplicationNumber AS ApplicationNumber,     
      PT.OrderNumber,    
      PT.CreatedDateTime AS Date,    
      PT.TotalAmount AS Amount,    
     CASE WHEN PT.Paid IS NULL     
     THEN 'Pending'    
     WHEN PT.Paid = 0    
     Then 'Failed'    
     ELSE     
     'Paid' END    
     AS Status,   
  --SS.Name AS ServiceName,   
  dbo.fn_multiLingualName(SS.Id, @serviceTranslationKeyId) AS ServiceName,
      PT.URN AS PaymentType         
   FROM application.PaymentTransactions PT    
   INNER JOIN application.ApplicationStages AAS ON AAS.Id = PT.ApplicationStageId    
   INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId       
   INNER JOIN service.Services SS ON SS.Id = AA.ServiceId                
      WHERE PT.CreatedBy = @uId          
          
        --ORDER BY AA.ApplicationNumber
		ORDER BY PT.OrderId DESC
   OFFSET @pageSize * (@pageNumber - 1) ROWS                
    FETCH NEXT @pageSize ROWS ONLY                
 ),           
  CTE_TotalRows AS                  
 (                
  SELECT Count(AA.ApplicationNumber) AS TotalRows FROM application.PaymentTransactions PT    
   INNER JOIN application.ApplicationStages AAS ON AAS.Id = PT.ApplicationStageId    
   INNER JOIN application.Applications AA ON AA.Id = AAS.ApplicationId                     
      WHERE PT.CreatedBy = @uId       
   AND (@start is null or (@start is not null and  convert(date,PT.CreatedDateTime)>=@start))    
   AND (@end is null or (@end is not null and convert(date,PT.CreatedDateTime)<=@end))    
 )    
    
 SELECT * FROM CTE_Results  temp       
 , CTE_TotalRows          
 WHERE      
   (@start is null or (@start is not null and  convert(date,temp.date)>=@start))    
   AND (@end is null or (@end is not null and convert(date,temp.date)<=@end))    
   AND    
   ((@search Is NUll Or temp.applicationNumber like '%'+isnull(@search,'')+'%') OR (@search Is NUll Or temp.OrderNumber like '%'+ISNULL(@search,'')+'%'))            
                
 OPTION (RECOMPILE)      
    
  END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserPermissionForService]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp_GetUserPermissionForService 34,90,'1a69f548-8029-4ae2-84f4-9243f91c915c','NAD Program Manager,Admin'
ALTER PROCEDURE [dbo].[sp_GetUserPermissionForService] @serviceid VARCHAR(100), 
											@stageActionId AS INT,
											@creatorid   NVARCHAR(100),
											@role NVARCHAR(100)
AS
    BEGIN

DECLARE  @uId int  ,  @roleId INT  

EXEC @uId= sp_GetUserId @creatorid 

DECLARE @IsOwner INT = 0, @NeedProfile INT;
   SELECT  @IsOwner = Id From Service.Roles Where Name = 'Owner';

DECLARE @temp TABLE(Id INT)
		INSERT INTO @temp
		EXEC sp_GetRoleId @role

Declare @Exist BIT = 0;  

IF(ISNULL(@stageActionId, 0)  > 0)
BEGIN
IF EXISTS(Select 1 From service.StageActionRoles Where StageActionId = @stageActionId AND (RoleId IN (Select Id From @temp) OR (@isOwner IN (Select Id From @temp))))
BEGIN
SET @Exist = 1;
END
END
ELSE
BEGIN
SET @Exist = 1;
END

  IF EXISTS (select ISNULL(ServiceId, 0) From service.ServiceProfiles Where ServiceId = @serviceid)
   BEGIN
   Set @NeedProfile = 1     
   END
   ELSE
   BEGIN
   Set @NeedProfile = 0     
   END

   SELECT @NeedProfile AS NeedProfile, @Exist AS Permission

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ReorderGroups]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  Neeraj    
-- Create date: 28th-Dec-2020    
-- Description: Reordering of groups.    
-- =============================================    
ALTER PROCEDURE [dbo].[sp_ReorderGroups] @GroupId         INT,   
                                  @PreviousOrderNo INT,   
                                  @NewOrderNo      INT  
AS  
    BEGIN  
        BEGIN TRY  
            BEGIN TRAN;  
            DECLARE @parentid AS INT= NULL;  
   SELECT @parentid = ParentId From service.Groups WHERE Id = @GroupId  
  
   IF(ISNULL(@parentid, 0 ) > 0)  
   BEGIN  
            IF(@PreviousOrderNo < @NewOrderNo)  
                BEGIN  
                    UPDATE service.Groups  
                      SET   
                          ORDERNUMBER = ORDERNUMBER - 1  
                    WHERE((OrderNumber > @PreviousOrderNo  
                           AND OrderNumber <= @NewOrderNo)  
                          AND ParentId = @parentid);  
            END;  
                ELSE  
                BEGIN  
                    UPDATE service.Groups  
                      SET   
                          ORDERNUMBER = ORDERNUMBER + 1  
                    WHERE((OrderNumber < @PreviousOrderNo  
                           AND OrderNumber >= @NewOrderNo)  
                          AND ParentId = @parentid);  
            END;  
  END  
  ELSE  
  BEGIN  
  IF(@PreviousOrderNo < @NewOrderNo)  
                BEGIN  
                    UPDATE service.Groups  
                      SET   
                          ORDERNUMBER = ORDERNUMBER - 1  
                    WHERE((OrderNumber > @PreviousOrderNo  
                           AND OrderNumber <= @NewOrderNo)  
                          AND ParentId IS NULL);  
            END;  
                ELSE  
                BEGIN  
                    UPDATE service.Groups  
                      SET   
                          ORDERNUMBER = ORDERNUMBER + 1  
                    WHERE((OrderNumber < @PreviousOrderNo  
                           AND OrderNumber >= @NewOrderNo)  
                          AND ParentId IS NULL);  
            END;  
  
  END  
  
  
  
            UPDATE service.Groups  
              SET   
                  OrderNumber = @NewOrderNo  
            WHERE Id = @GroupId  
                  AND OrderNumber = @PreviousOrderNo;  
  
   SELECT @GroupId AS Id,   
                   200 AS STATUS,   
                   'Success' AS Message;  
  
            COMMIT TRANSACTION;  
        END TRY  
        BEGIN CATCH  
            ROLLBACK TRANSACTION;  
            SELECT @GroupId AS Id,   
                   500 AS STATUS,   
                   ERROR_MESSAGE() AS Message;  
        END CATCH;  
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ReorderServices]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Neeraj
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_ReorderServices] @GroupId         INT, 
                                           @ServiceId       INT, 
                                           @PreviousOrderNo INT, 
                                           @NewOrderNo      INT
AS
    BEGIN
        BEGIN TRY
            BEGIN TRAN;
            IF(@PreviousOrderNo < @NewOrderNo)
                BEGIN
                    UPDATE service.Services
                      SET 
                          ORDERNUMBER = ORDERNUMBER - 1
                    WHERE(OrderNumber > @PreviousOrderNo
                          AND OrderNumber <= @NewOrderNo);
            END;
                ELSE
                BEGIN
                    UPDATE service.Services
                      SET 
                          ORDERNUMBER = ORDERNUMBER + 1
                    WHERE(OrderNumber < @PreviousOrderNo
                          AND OrderNumber >= @NewOrderNo);
            END;
            UPDATE service.Services
              SET 
                  OrderNumber = @NewOrderNo
            WHERE GroupId = @GroupId
                  AND Id = @ServiceId
                  AND OrderNumber = @PreviousOrderNo;
            SELECT @ServiceId AS Id, 
                   200 AS STATUS, 
                   'Success' AS Message;
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            SELECT @ServiceId AS Id, 
                   500 AS STATUS, 
                   ERROR_MESSAGE() AS Message;
        END CATCH;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ReorderStages]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  Neeraj      
-- Create date: 27th-Jan-2021     
-- Description: Reordering of Stages.      
-- =============================================      
ALTER PROCEDURE [dbo].[sp_ReorderStages] @ServiceId   INT,
											@StageId INT,     
											@PreviousOrderNo INT,     
											@NewOrderNo      INT    
AS    
    BEGIN    
        BEGIN TRY    
            BEGIN TRAN;    
  IF(@PreviousOrderNo < @NewOrderNo)    
                BEGIN    
                    UPDATE service.Stages    
                      SET     
                          ORDERNUMBER = ORDERNUMBER - 1    
                    WHERE((OrderNumber > @PreviousOrderNo    
                           AND OrderNumber <= @NewOrderNo)    
                          AND ServiceId = @ServiceId);    
            END;    
                ELSE    
                BEGIN    
                    UPDATE service.Stages    
                      SET     
                          ORDERNUMBER = ORDERNUMBER + 1    
                    WHERE((OrderNumber < @PreviousOrderNo    
                           AND OrderNumber >= @NewOrderNo)    
                          AND ServiceId = @ServiceId);    
            END;   
            UPDATE service.Stages    
              SET     
                  OrderNumber = @NewOrderNo    
            WHERE Id = @StageId    
               --   AND OrderNumber = @PreviousOrderNo;    
    
   SELECT @StageId AS Id,     
                   200 AS STATUS,     
                   'Success' AS Message;    
    
            COMMIT TRANSACTION;    
        END TRY    
        BEGIN CATCH    
            ROLLBACK TRANSACTION;    
            SELECT @StageId AS Id,     
                   500 AS STATUS,     
                   ERROR_MESSAGE() AS Message;    
        END CATCH;    
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_TranslationsCleanup]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_TranslationsCleanup]
AS
BEGIN

Delete t from service.Translations t left outer join service.Stages s on t.ItemId=s.Id where t.TranslationKeyId=12 and s.Id is null

Delete t from service.Translation t left outer join service.Services s on t.ItemId=s.Id where t.TranslationKeyId in (11,16) and s.Id is null

Delete t from service.Translation t left outer join service.Groups s on t.ItemId=s.Id where t.TranslationKeyId in (14,15) and s.Id is null

Delete t from service.Translation t left outer join service.StageActions s on t.ItemId=s.Id where t.TranslationKeyId =7 and s.Id is null

Delete t from service.Translation t left outer join service.Forms s on t.ItemId=s.Id where t.TranslationKeyId =2 and s.Id is null

END
GO
/****** Object:  StoredProcedure [dbo].[sp_UploadActionAttachments]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_UploadActionAttachments] @applicationId      INT,   
											@applicationStageId INT,
											@actionTypeId		INT,
											@appStageActionId   INT,  
											@creatorId          NVARCHAR(100), 
											@image              VARBINARY(MAX),
											@fileName           VARCHAR(100),  
											@extension          VARCHAR(20),   
											@size               DECIMAL(18, 0),
											@mimeType           VARCHAR(50),
											@itemIndex          INT


AS
BEGIN
	
	DECLARE @uId INT;  
        EXEC @uId = sp_GetUserId   
             @creatorid;  
        DECLARE @actionAttachmentId INT;  
        DECLARE @currentDate DATETIME;  
        SET @currentDate = GETDATE();  
        BEGIN TRY  
            BEGIN TRAN;  
            INSERT INTO application.ActionAttachments  
            (AppId, AppStageId, ActionTypeId, AppStageActionId, CreatorId, CreatedOn, FileContents, FileName, Extension, Size, MimeType, ItemIndex)  
            VALUES  
            (@applicationId, @applicationStageId, @actionTypeId, null, @uId, @currentDate, @image, @fileName, @extension, @size, @mimeType, @itemIndex);  
            SET @actionAttachmentId = SCOPE_IDENTITY();  
		    SELECT @actionAttachmentId AS Id,   
                   '200' AS STATUS,   
                   'Success' AS SuccessMessage;  
            COMMIT TRANSACTION;  
        END TRY  
		 BEGIN CATCH  
            ROLLBACK TRANSACTION;  
            SELECT @actionAttachmentId AS Id,   
                   '500' AS STATUS,   
                   ERROR_MESSAGE() AS ErrorMessage;  
        END CATCH;  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UploadAttachments]    Script Date: 01-02-2021 19:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
ALTER PROCEDURE [dbo].[sp_UploadAttachments] @applicationId      INT,   
                                             @applicationStageId INT,   
                                             @attachmentTypeId   INT,   
                                             @attachmentId       INT,   
                                             @creatorId          NVARCHAR(100),   
                                             @image              VARBINARY(MAX),   
                                             @fileName           VARCHAR(100),   
                                             @extension          VARCHAR(20),   
                                             @size               DECIMAL(18, 0),   
                                             @mimeType           VARCHAR(50),
											 @itemIndex           INT
AS  
    BEGIN  
        DECLARE @uId INT;  
        EXEC @uId = sp_GetUserId   
             @creatorid;  
        DECLARE @applicationattachmentId INT;  
        DECLARE @currentDate DATETIME;  
        SET @currentDate = GETDATE();  
        BEGIN TRY  
            BEGIN TRAN;  
            INSERT INTO application.ApplicationAttachments  
            (AppId,   
             AppStageId,   
             AttachmentId,   
             CreatorId,   
             CreatedOn,   
             FileContents,   
             FileName,   
             Extension,   
             Size,   
             MimeType,
			 ItemIndex  
            )  
            VALUES  
            (@applicationId,   
             @applicationStageId,   
             @attachmentId,   
             @uId,   
             @currentDate,   
             @image,   
             @fileName,   
             @extension,   
             @size,   
             @mimeType,
			 @itemIndex  
            );  
            SET @applicationattachmentId = SCOPE_IDENTITY();  
            SELECT @applicationattachmentId AS Id,   
                   '200' AS STATUS,   
                   'Success' AS SuccessMessage;  
            COMMIT TRANSACTION;  
        END TRY  
        BEGIN CATCH  
            ROLLBACK TRANSACTION;  
            DECLARE @message VARCHAR(4000);  
            SELECT @message = ERROR_MESSAGE();  
            SELECT @applicationattachmentId AS Id,   
                   500 AS STATUS,   
                   @message AS ErrorMessage;  
        END CATCH;  
    END;
GO
