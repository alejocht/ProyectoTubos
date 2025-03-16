USE bd_tercerizados

GO

CREATE PROCEDURE SP_InsertarAuditoria(
    @tabla_afectada VARCHAR(50),
    @id_registro_afectado INT,
    @accion VARCHAR(10),
    @id_usuario INT
)
AS
BEGIN
    INSERT INTO dbo.auditoria(tabla_afectada, id_registro_afectado, accion, fecha, id_usuario) 
    VALUES (@tabla_afectada, @id_registro_afectado, @accion, GETDATE(), @id_usuario);
END;

GO

CREATE PROCEDURE SP_AgregarUsuario(@usuario_input varchar(50) , @contrasenia_input varchar(255), @id_tipo_usuario_input int)
AS
BEGIN
	DECLARE @contrasenia_hash VARBINARY(64);
	SET @contrasenia_hash = HASHBYTES('SHA2_256', CONVERT(VARCHAR(255), @contrasenia_input));
	insert into usuarios(usuario, pass, id_tipo_usuario) values (@usuario_input, @contrasenia_hash, @id_tipo_usuario_input)	
END;

GO

CREATE PROCEDURE SP_AgregarDeposito(@nombre_input varchar(255), @observacion varchar(255), @id_tipo_deposito int, @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO depositos (nombre, observacion, id_tipo_deposito) values (@nombre_input, @observacion, @id_tipo_deposito)
			declare @id_inserted int
			set @id_inserted = SCOPE_IDENTITY()
			exec SP_InsertarAuditoria 'depositos', @id_inserted,'INSERT', @id_usuario;
			COMMIT TRANSACTION
		END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH;
END
			
GO

CREATE PROCEDURE SP_AgregarTipoUsuario(@descripcion varchar(255), @id_usuario int)
AS
BEGIN
    INSERT INTO tipos_usuarios (descripcion) VALUES (@descripcion);
END;
GO

CREATE PROCEDURE SP_AgregarTipoDeposito(@descripcion varchar(255))
AS
BEGIN
    INSERT INTO tipos_depositos (descripcion) VALUES (@descripcion);
END;
GO

CREATE PROCEDURE SP_AgregarTipoMovimiento(@descripcion varchar(255))
AS
BEGIN
    INSERT INTO tipos_movimientos (descripcion) VALUES (@descripcion);
END;
GO

CREATE PROCEDURE SP_ModificarTipoUsuario(@id int, @descripcion varchar(255), @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE tipos_usuarios SET descripcion = @descripcion WHERE id = @id;
        EXEC SP_InsertarAuditoria 'tipos_usuarios', @id, 'UPDATE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_ModificarUsuario(@id int, @usuario varchar(50), @id_tipo_usuario int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE usuarios SET usuario = @usuario, id_tipo_usuario = @id_tipo_usuario WHERE id = @id;
        EXEC SP_InsertarAuditoria 'usuarios', @id, 'UPDATE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_EliminarUsuario(@id int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE usuarios SET estado = 0 WHERE id = @id;
        EXEC SP_InsertarAuditoria 'usuarios', @id, 'DELETE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_EliminarTipoUsuario(@id int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE tipos_usuarios SET estado = 0 WHERE id = @id;
        EXEC SP_InsertarAuditoria 'tipos_usuarios', @id, 'DELETE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_ObtenerTiposUsuarios
AS
BEGIN
    SELECT * FROM tipos_usuarios WHERE estado = 1;
END;
GO

CREATE PROCEDURE SP_ObtenerUsuarios
AS
BEGIN
    SELECT * FROM usuarios WHERE estado = 1;
END;
GO

CREATE PROCEDURE SP_ObtenerProveedores
AS
BEGIN
    SELECT * FROM proveedores WHERE estado = 1;
END;
GO