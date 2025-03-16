USE bd_tercerizados

GO
-- AGREGAR TIPOS
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

CREATE PROCEDURE SP_AgregarTipoProducto(@descripcion varchar(255))
AS
BEGIN
    INSERT INTO tipos_productos(descripcion) VALUES (@descripcion);
END;
GO

CREATE PROCEDURE SP_AgregarUnidadDeMedida(@descripcion varchar(255))
AS
BEGIN
	INSERT INTO unidades_medida(descripcion) values (@descripcion);
END;
GO

-- AGREGAR AUDITORIA
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

--AGREGAR MAESTROS

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

CREATE PROCEDURE SP_AgregarFormula(@nombre varchar(255), @codigo varchar(255), @descripcion varchar(255), @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
	INSERT INTO formulas(nombre, codigo, descripcion) values (@nombre, @codigo, @descripcion);
	DECLARE @id_inserted int
	SET @id_inserted = SCOPE_IDENTITY()
	EXEC SP_InsertarAuditoria 'formulas', @id_inserted, 'INSERT', @id_usuario;
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION
	THROW
	END CATCH
END;
GO

CREATE PROCEDURE SP_AgregarProducto(@nombre varchar(255), @codigo varchar(255), @descripcion varchar(255), @id_unidad_medida int, @id_tipo_producto int, @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
	INSERT INTO productos(nombre,codigo,descripcion,id_unidad_medida,id_tipo_producto) VALUES (@nombre, @codigo, @descripcion, @id_unidad_medida, @id_tipo_producto);
	DECLARE @id_inserted INT
	SET @id_inserted = SCOPE_IDENTITY()
	EXEC SP_InsertarAuditoria 'productos',@id_inserted,'INSERT',@id_usuario;
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION
	THROW
	END CATCH
END;
GO

CREATE PROCEDURE SP_AgregarTuboDetalle(@id_producto int, @peso_x_metro decimal(10,4), @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
	INSERT INTO tubos_detalle(id_producto, peso_x_metro) VALUES (@id_producto, @peso_x_metro);
	DECLARE @id_inserted INT
	SET @id_inserted = SCOPE_IDENTITY()
	EXEC SP_InsertarAuditoria 'tubos_detalle', @id_inserted, 'INSERT', @id_usuario;
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION
	THROW
	END CATCH
END;
GO

CREATE PROCEDURE SP_AgregarMuebleDetalle(@id_producto int, @familia varchar(255), @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
	INSERT INTO muebles_detalle(id_producto, familia) VALUES (@id_producto, @familia);
	DECLARE @id_inserted INT
	SET @id_inserted INT
	SET @id_inserted = SCOPE_IDENTITY()
	EXEC SP_InsertarAuditoria 'muebles_detalle', @id_inserted, 'INSERT', @id_usuario;
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION
	THROW
	END CATCH
END;
GO

-- MODIFICAR TIPOS

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

CREATE PROCEDURE SP_ModificarTipoDeposito(@id int, @descripcion varchar(255), @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE tipos_depositos SET descripcion = @descripcion WHERE id = @id;
        EXEC SP_InsertarAuditoria 'tipos_depositos', @id, 'UPDATE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_ModificarUnidadDeMedida(@id int, @descripcion varchar(255), @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE unidades_medida SET descripcion = @descripcion WHERE id = @id;
        EXEC SP_InsertarAuditoria 'unidades_medida', @id, 'UPDATE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_ModificarTiposMovimientos(@id int, @descripcion varchar(255), @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		UPDATE tipos_movimientos SET descripcion = @descripcion WHERE id = @id;
		EXEC SP_InsertarAuditoria 'tipos_movimientos', @id, 'UPDATE', @id_usuario
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		THROW
	END CATCH
END;
GO

CREATE PROCEDURE SP_ModificarTiposProductos(@id int, @descripcion varchar(255), @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		UPDATE tipos_productos SET descripcion = @descripcion WHERE id = @id;
		EXEC SP_InsertarAuditoria 'tipos_productos', @id, 'UPDATE', @id_usuario
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		THROW
	END CATCH
END;
GO

-- MODIFICAR MAESTROS

CREATE PROCEDURE SP_ModificarProducto(@id int, @nombre varchar(255), @codigo varchar(255), @descripcion varchar(255), @id_unidad_medida int, @id_tipo_producto int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE productos SET nombre = @nombre, codigo = @codigo, descripcion = @descripcion, id_unidad_medida = @id_unidad_medida, id_tipo_producto = @id_tipo_producto WHERE id = @id;
        EXEC SP_InsertarAuditoria 'productos', @id, 'UPDATE', @id_usuario;
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

CREATE PROCEDURE SP_ModificarDeposito(@id int, @nombre varchar(255), @descripcion varchar(255), @id_tipo_deposito int , @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		UPDATE depositos SET nombre = @nombre, descripcion = @descripcion, id_tipo_deposito = @id_tipo_deposito WHERE id = @id
		EXEC SP_InsertarAuditoria 'depositos', @id, 'UPDATE', @id_usuario;
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		THROW
	END CATCH
END;
GO

CREATE PROCEDURE SP_ModificarFormula(@id int, @nombre varchar(255), @codigo varchar(255), @descripcion varchar(255), @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		UPDATE formulas SET nombre = @nombre, codigo = @codigo, descripcion = @descripcion where id = @id
		EXEC SP_InsertarAuditoria 'formulas', @id, 'UPDATE', @id_usuario;
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		THROW
	END CATCH
END;
GO

CREATE PROCEDURE SP_ModificarTubosDetalle(@id int, @id_producto int, @peso_x_metro decimal(10,4), @id_usuario int )
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		UPDATE tubos_detalle SET id_producto = @id_producto, peso_x_metro = @peso_x_metro where id = @id
		EXEC SP_InsertarAuditoria 'tubos_detalle', @id, 'UPDATE',@id_usuario
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		THROW
	END CATCH
END;
GO

CREATE PROCEDURE SP_ModificarMueblesDetalle(@id int, @id_producto int, @familia varchar(255), @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		UPDATE muebles_detalle SET id_producto = @id_producto, familia = @familia where id = @id
		EXEC SP_InsertarAuditoria 'muebles_detalle', @id, 'UPDATE', @id_usuario
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		THROW
	END CATCH
END;
GO

-- ELIMINAR TIPOS
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

CREATE PROCEDURE SP_EliminarTipoDeposito(@id int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE tipos_depositos SET estado = 0 WHERE id = @id;
        EXEC SP_InsertarAuditoria 'tipos_depositos', @id, 'DELETE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_EliminarUnidadDeMedida(@id int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE unidades_medida SET estado = 0 WHERE id = @id;
        EXEC SP_InsertarAuditoria 'unidades_medida', @id, 'DELETE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_EliminarTiposProducto(@id int, @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE tipos_productos SET estado = 0 WHERE id = @id;
        EXEC SP_InsertarAuditoria 'tipos_productos', @id, 'DELETE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;	
END;
GO

CREATE PROCEDURE SP_EliminarTiposMovimiento(@id int, @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE tipos_movimientos SET estado = 0 WHERE id = @id;
        EXEC SP_InsertarAuditoria 'tipos_movimientos', @id, 'DELETE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- ELIMINAR MAESTROS
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

CREATE PROCEDURE SP_EliminarProducto(@id int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE productos SET estado = 0 WHERE id = @id;
        EXEC SP_InsertarAuditoria 'productos', @id, 'DELETE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_EliminarDeposito(@id int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE depositos SET estado = 0 WHERE id = @id;
        EXEC SP_InsertarAuditoria 'depositos', @id, 'DELETE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_EliminarFormula(@id int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE formulas SET estado = 0 WHERE id = @id;
        EXEC SP_InsertarAuditoria 'formulas', @id, 'DELETE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_EliminarTuboDetalle(@id int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE tubos_detalle SET estado = 0 WHERE id = @id;
        EXEC SP_InsertarAuditoria 'tubos_detalle', @id, 'DELETE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_EliminarMuebleDetalle(@id int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE muebles_detalle SET estado = 0 WHERE id = @id;
        EXEC SP_InsertarAuditoria 'muebles_detalle', @id, 'DELETE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- SELECCION TIPOS
CREATE PROCEDURE SP_ObtenerTiposUsuarios
AS
BEGIN
    SELECT * FROM tipos_usuarios WHERE estado = 1;
END;
GO

CREATE PROCEDURE SP_ObtenerTiposDepositos
AS
BEGIN
    SELECT * FROM tipos_depositos WHERE estado = 1;
END;
GO

CREATE PROCEDURE SP_ObtenerUnidadesDeMedida
AS
BEGIN
    SELECT * FROM unidades_medida WHERE estado = 1;
END;
GO

-- SELECCION MAESTROS
CREATE PROCEDURE SP_ObtenerProductos
AS
BEGIN
    SELECT * FROM productos WHERE estado = 1;
END;
GO

CREATE PROCEDURE SP_ObtenerUsuarios
AS
BEGIN
    SELECT * FROM usuarios WHERE estado = 1;
END;
GO



