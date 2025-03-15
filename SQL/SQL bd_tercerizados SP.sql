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

CREATE PROCEDURE SP_AgregarTubo(
@usuario_input int, @nombre_input varchar(255),
@peso_x_metro_input decimal(10,4), @observacion_input varchar(255) = null
)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY

			insert into tubos(nombre, peso_x_metro, observacion) values (@nombre_input, @peso_x_metro_input, @observacion_input);
			declare @idAgregado int
			set @idAgregado = SCOPE_IDENTITY()
			exec SP_InsertarAuditoria 'tubos',@idAgregado ,'INSERT', @usuario_input;
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW;
		END CATCH
END

GO

CREATE PROCEDURE SP_AgregarUsuario(@usuario_input varchar(50) , @contrasenia_input varchar(255), @id_tipo_usuario_input int)
AS
BEGIN
	DECLARE @contrasenia_hash VARBINARY(64);
	SET @contrasenia_hash = HASHBYTES('SHA2_256', CONVERT(VARCHAR(255), @contrasenia_input));
	insert into usuarios(usuario, pass, id_tipo_usuario) values (@usuario_input, @contrasenia_hash, @id_tipo_usuario_input)	
END;

GO

CREATE PROCEDURE SP_AgregarProveedor(
@nombre_input varchar(255), @direccion_input varchar(255),
@telefono_input varchar(40), @observacion_input varchar(255),
@id_usuario int
)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO proveedores (@nombre_input, @direccion_input, @telefono_input, @observacion);
			declare @id_inserted int
			set @id_inserted = SCOPE_IDENTITY()
			exec SP_InsertarAuditoria 'proveedores', @id_inserted,'INSERT', @id_usuario;
			COMMIT TRANSACTION
		END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
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

CREATE PROCEDURE SP_AgregarMueble(@nombre_input varchar(255), @codigo_input varchar(255), @observacion_input varchar(255), @id_tipo_mueble int, @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO muebles(nombre, codigo, observacion, id_tipo_mueble) values (@nombre_input,@codigo_input,@observacion_input,@id_tipo_mueble)
			declare @id_inserted int
			set @id_inserted = SCOPE_IDENTITY()
			exec SP_InsertarAuditoria 'muebles', @id_inserted,'INSERT', @id_usuario;
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			THROW
		END CATCH
END
GO

CREATE PROCEDURE SP_AgregarPedido(@nro_pedido_input int, @observacion varchar(255), @id_proveedor_input int, @fecha_solicitud datetime,@id_usuario int, @fecha_estimada_llegada datetime = 0, @fecha_llegada datetime = 0)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO pedidos(nro_pedido, observacion, id_proveedor, fecha_solicitud, fecha_estimada_llegada, fecha_llegada) values (@nro_pedido_input,@observacion,@id_proveedor_input,@fecha_solicitud,@fecha_estimada_llegada,@fecha_llegada)
		declare @id_inserted int
		set @id_inserted = SCOPE_IDENTITY()
		exec SP_InsertarAuditoria 'muebles', @id_inserted,'INSERT', @id_usuario;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		THROW
	END CATCH
END
GO

CREATE PROCEDURE SP_AgregarMovimiento(@fecha_input datetime, @id_tipo_movimiento_input int, @observacion varchar(255), @id_usuario int)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO movimientos(fecha, id_tipo_movimiento, observacion) values (@fecha_input,@id_tipo_movimiento_input,@observacion)
			declare @id_inserted int
			set @id_inserted = SCOPE_IDENTITY()
			exec SP_InsertarAuditoria 'movimientos', @id_inserted,'INSERT', @id_usuario;
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			THROW
		END CATCH
END
GO

CREATE PROCEDURE SP_AgregarTipoUsuario(@descripcion varchar(255), @id_usuario int)
AS
BEGIN
    INSERT INTO tipos_usuarios (descripcion) VALUES (@descripcion);
END;
GO

CREATE PROCEDURE SP_AgregarTipoMueble(@descripcion varchar(255))
AS
BEGIN
    INSERT INTO tipos_muebles (descripcion) VALUES (@descripcion);
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

CREATE PROCEDURE SP_AgregarTuboXPedido(@id_pedido int, @id_tubo int, @cant_kilos decimal(10,4), @observacion varchar(255), @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO tubos_x_pedido (id_pedido, id_tubo, cant_kilos, observacion) VALUES (@id_pedido, @id_tubo, @cant_kilos, @observacion);
        DECLARE @id_inserted int = SCOPE_IDENTITY();
        EXEC SP_InsertarAuditoria 'tubos_x_pedido', @id_inserted, 'INSERT', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_AgregarTuboXDeposito(@id_tubo int, @id_deposito int, @saldo decimal(10,4), @id_usuario int)
AS
BEGIN
    INSERT INTO tubos_x_deposito (id_tubo, id_deposito, saldo) VALUES (@id_tubo, @id_deposito, @saldo);
    EXEC SP_InsertarAuditoria 'tubos_x_deposito', @id_tubo, 'INSERT', @id_usuario;
END;
GO

CREATE PROCEDURE SP_AgregarMuebleXDeposito(@id_mueble int, @id_deposito int, @saldo decimal(10,4), @id_usuario int)
AS
BEGIN
    INSERT INTO muebles_x_deposito (id_mueble, id_deposito, saldo) VALUES (@id_mueble, @id_deposito, @saldo);
    EXEC SP_InsertarAuditoria 'muebles_x_deposito', @id_mueble, 'INSERT', @id_usuario;
END;
GO

CREATE PROCEDURE SP_AgregarTuboXMovimiento(@id_tubo int, @id_movimiento int, @cant_kilos decimal(10,4), @observacion varchar(255), @id_deposito_origen int, @id_deposito_destino int, @id_pedido_asociado int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO tubos_x_movimiento (id_tubo, id_movimiento, cant_kilos, observacion, id_deposito_origen, id_deposito_destino, id_pedido_asociado) 
        VALUES (@id_tubo, @id_movimiento, @cant_kilos, @observacion, @id_deposito_origen, @id_deposito_destino, @id_pedido_asociado);
        DECLARE @id_inserted int = SCOPE_IDENTITY();
        EXEC SP_InsertarAuditoria 'tubos_x_movimiento', @id_inserted, 'INSERT', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_AgregarTuboXMueble(@id_tubo int, @id_mueble int, @cant_kilos decimal(10,4), @observacion varchar(255), @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO tubos_x_mueble (id_tubo, id_mueble, cant_kilos, observacion) VALUES (@id_tubo, @id_mueble, @cant_kilos, @observacion);
        DECLARE @id_inserted int = SCOPE_IDENTITY();
        EXEC SP_InsertarAuditoria 'tubos_x_mueble', @id_inserted, 'INSERT', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
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

CREATE PROCEDURE SP_ModificarProveedor(@id int, @nombre varchar(255), @direccion varchar(255), @telefono varchar(40), @observacion varchar(255), @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE proveedores SET nombre = @nombre, direccion = @direccion, telefono = @telefono, observacion = @observacion WHERE id = @id;
        EXEC SP_InsertarAuditoria 'proveedores', @id, 'UPDATE', @id_usuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE SP_EliminarProveedor(@id int, @id_usuario int)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE proveedores SET estado = 0 WHERE id = @id;
        EXEC SP_InsertarAuditoria 'proveedores', @id, 'DELETE', @id_usuario;
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