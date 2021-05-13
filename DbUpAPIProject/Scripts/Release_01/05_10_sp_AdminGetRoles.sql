
/****** Object:  StoredProcedure [dbo].[sp_AdminGetRoles]    Script Date: 21-01-2021 18:39:41 ******/
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