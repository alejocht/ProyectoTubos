
CREATE PROCEDURE SP_AgregarTubo(@usuario_input int, @nombre_input varchar(255), @peso_x_metro_input decimal(10,4), @observacion_input varchar(255) = null)
AS
BEGIN
	insert into tubos(nombre, peso_x_metro, observacion) values (@nombre_input, @peso_x_metro_input, @observacion_input);
	insert into dbo.auditoria(tabla_afectada, id_registro_afectado, accion, fecha, id_usuario) values ('tubos', SCOPE_IDENTITY(),'INSERT',GETDATE(), @usuario_input);
END;

CREATE PROCEDURE SP_AgregarUsuario(@usuario_input varchar(50) , @contrasenia_input varchar(255), @id_tipo_usuario_input int)
AS
BEGIN
	DECLARE @contrasenia_hash VARBINARY(64);
	SET @contrasenia_hash = HASHBYTES('SHA2_256', CONVERT(VARCHAR(255), @contrasenia_input));
	insert into usuarios(usuario, pass, id_tipo_usuario) values (@usuario_input, @contrasenia_hash, @id_tipo_usuario_input)	
END