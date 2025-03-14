IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'bd_tercerizados')
BEGIN
    CREATE DATABASE bd_tercerizados;
END
GO
USE bd_tercerizados

CREATE TABLE tipos_usuarios(
	id int primary key identity(1,1),
	descripcion varchar(255) not null,
	estado bit not null default 1
)

CREATE TABLE usuarios(
	id int primary key identity(1,1),
	usuario varchar(50) unique not null,
	pass varbinary(64) not null,
	id_tipo_usuario int not null foreign key references tipos_usuarios(id),
	estado bit not null default 1
)

CREATE TABLE tipos_muebles(
	id int primary key identity(1,1),
	descripcion varchar(255) not null unique,
	estado bit not null default 1
)

CREATE TABLE tipos_depositos(
	id int primary key identity(1,1),
	descripcion varchar(255) not null unique,
	estado bit not null default 1
)

CREATE TABLE tipos_movimientos(
	id int primary key identity(1,1),
	descripcion varchar(255) not null unique,
	estado bit not null default 1
)

CREATE TABLE tubos(
	id int primary key identity(1,1),
	nombre varchar(255) not null unique,
	peso_x_metro decimal(10,4) not null,
	observacion varchar(255) null,
	estado bit not null default 1
)

CREATE TABLE proveedores(
	id int primary key identity(1,1),
	nombre varchar(255) not null unique,
	direccion varchar(255) null,
	telefono varchar(40) null,
	observacion varchar(255) null,
	estado bit not null default 1
)

CREATE TABLE depositos(
	id int primary key identity(1,1),
	nombre varchar(255) not null unique,
	observacion varchar(255) null,
	id_tipo_deposito int not null foreign key references tipos_depositos(id),
	estado bit not null default 1
)

CREATE TABLE muebles(
	id int primary key identity(1,1),
	nombre varchar(255) not null,
	codigo varchar(255) not null unique,
	observacion varchar(255) null,
	id_tipo_mueble int not null foreign key references tipos_muebles(id),
	estado bit not null default 1
)

CREATE TABLE pedidos(
	id int primary key identity(1,1),
	nro_pedido varchar(255) not null unique,
	observacion varchar(255) null,
	id_proveedor int not null foreign key references proveedores(id),
	fecha_solicitud date not null,
	fecha_estimada_llegada date null,
	fecha_llegada date null,
	llego bit not null default 0,
	estado bit not null default 1
)

CREATE TABLE movimientos(
	id int primary key identity(1,1),
	fecha datetime not null,
	id_tipo_movimiento int not null foreign key references tipos_movimientos(id),
	observacion varchar(255) null,
	estado bit not null default 1
)

CREATE TABLE tubos_x_pedido(
	id int primary key identity(1,1),
	id_pedido int not null foreign key references pedidos(id),
	id_tubo int not null foreign key references tubos(id),
	cant_kilos decimal(10,4) not null,
	observacion varchar(255) null,
	estado bit not null default 1
)

CREATE TABLE tubos_x_deposito(
	id_tubo int not null foreign key references tubos(id),
	id_deposito int not null foreign key references depositos(id),
	saldo decimal(10,4) not null default 0,
	estado bit not null default 1,
	primary key(id_tubo, id_deposito)
)

CREATE TABLE muebles_x_deposito(
	id_mueble int not null foreign key references muebles(id),
	id_deposito int not null foreign key references depositos(id),
	saldo decimal(10,4) not null default 0,
	estado bit not null default 1,
	primary key(id_mueble, id_deposito)
)

CREATE TABLE tubos_x_movimiento(
	id int primary key identity(1,1),
	id_tubo int not null foreign key references tubos(id),
	id_movimiento int not null foreign key references movimientos(id),
	cant_kilos decimal(10,4) not null,
	observacion varchar(255) null,
	id_deposito_origen int null foreign key references depositos(id),
	id_deposito_destino int not null foreign key references depositos(id),
	id_pedido_asociado int null foreign key references pedidos(id),
	estado bit not null default 1
)

CREATE TABLE tubos_x_mueble(
	id int primary key identity(1,1),
	id_tubo int not null foreign key references tubos(id),
	id_mueble int not null foreign key references muebles(id),
	cant_kilos decimal(10,4) not null,
	observacion varchar(255) null,
	estado bit not null default 1
)

create table auditoria(
	id INT PRIMARY KEY IDENTITY(1,1),
    tabla_afectada VARCHAR(50),
    id_registro_afectado INT not null,
    accion VARCHAR(10),
    fecha DATETIME2(3) DEFAULT GETDATE(),
	id_usuario int not null foreign key references usuarios(id)
)



