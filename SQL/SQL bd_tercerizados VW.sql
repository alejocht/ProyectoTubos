CREATE VIEW VW_Usuarios
AS
SELECT usuarios.id, usuario, id_tipo_usuario, tipos_usuarios.descripcion, usuarios.estado FROM usuarios
LEFT JOIN tipos_usuarios ON tipos_usuarios.id = id_tipo_usuario
WHERE usuarios.estado = 1;

