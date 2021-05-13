
/****** Object:  UserDefinedFunction [dbo].[fn_formSectionFieldConstraints]    Script Date: 21-01-2021 18:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date, ,>    
-- Description: <Description, ,>    
-- =============================================    
ALTER FUNCTION [dbo].[fn_formSectionFieldConstraints]     
(@Id INT,    
@formSectionConstraintTranslationKeyId INT   
)    
RETURNS NVARCHAR(MAX)    
AS    
     BEGIN    
         DECLARE @constraints AS NVARCHAR(MAX);    
         SET @constraints =    
         (    
             SELECT FCT.Id AS constraintTypeId,     
                    FCT.Name AS constraintName,     
                    SFFC.Settings AS Settings,     
                    JSON_QUERY(dbo.fn_textMessages(FCT.Name)) AS textMessages,     
                    JSON_QUERY(dbo.fn_multiLingualName(SFFC.Id,@formSectionConstraintTranslationKeyId)) AS constraintMessages    
             FROM service.FormFieldConstraints SFFC    
                             INNER JOIN lookups.FieldConstraintTypes FCT ON FCT.Id = SFFC.FieldConstraintTypeId    
                        WHERE SFFC.FormSectionFieldId = @Id FOR JSON PATH    
         );    
         RETURN @constraints;    
     END;  
GO