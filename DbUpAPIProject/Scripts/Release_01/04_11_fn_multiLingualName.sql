
/****** Object:  UserDefinedFunction [dbo].[fn_multiLingualName]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date, ,>    
-- Description: <Description, ,>    
-- =============================================    
ALTER FUNCTION [dbo].[fn_multiLingualName]    
(@Id   INT,     
-- @Name VARCHAR(50)
@translationKeyId INT
)    
RETURNS NVARCHAR(MAX)    
AS    
     BEGIN  
         DECLARE @attachmentName AS NVARCHAR(MAX);    
         SET @attachmentName =    
         (    
             SELECT MAX(ST.Value) AS value,     
                    ST.LanguageId AS langId    
             FROM service.Translations ST    
                  INNER JOIN system.Languages SL ON SL.Id = ST.LanguageId    
                  INNER JOIN system.TranslationKeys STK ON STK.Id = ST.TranslationKeyId    
             WHERE ST.ItemId = @Id    
                  -- AND STK.Name = @Name   
				   AND STK.Id = @translationKeyId  
             GROUP BY ST.LanguageId 
			 FOR JSON PATH    
         );    
         RETURN @attachmentName;    
     END;
GO