
/****** Object:  UserDefinedFunction [dbo].[fn_FormFieldEntityExist]    Script Date: 12-02-2021 19:46:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date, ,>  
-- Description: <Description, ,>  
-- =============================================  
CREATE FUNCTION [dbo].[fn_FormFieldEntityExist]  
(  
@formId INT,
@entityFieldId INT 
)  
RETURNS VARCHAR(MAX)  
AS  
BEGIN  
 -- Declare the return variable here  
 DECLARE @relationType Varchar(50), @formEntityId INT, @relationFieldEntityId INT
 Select @formEntityId = EntityId from service.Forms Where Id = @formId
 Select @relationFieldEntityId = EntityId From service.EntityFields Where Id = @entityFieldId  
  
IF(@formEntityId = @relationFieldEntityId)
  SET @relationType = 'Single'
ELSE 
  SET @relationType = 'Multiple'
 -- Return the result of the function  
 RETURN @relationType  
  
END  