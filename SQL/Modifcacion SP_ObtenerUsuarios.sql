USE [bd_tercerizados]
GO
/****** Object:  StoredProcedure [dbo].[SP_ObtenerUsuarios]    Script Date: 31/03/2025 15:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_ObtenerUsuarios]
AS
BEGIN
    SELECT * FROM VW_Usuarios;
END;
