IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'bd_tercerizados')
BEGIN
    CREATE DATABASE bd_tercerizados;
END
GO
USE bd_tercerizados
GO

CREATE TABLE tipos_usuarios(
	id int primary key identity(1,1),
	descripcion varchar(255) not null,
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

CREATE TABLE tipos_productos(
	id int primary key identity(1,1),
	descripcion varchar(255) not null unique,
	estado bit not null default 1
)

CREATE TABLE unidades_medida(
	id int primary key identity(1,1),
	descripcion varchar(255) not null unique,
	estado bit not null default 1
)

CREATE TABLE usuarios(
	id int primary key identity(1,1),
	usuario varchar(50) unique not null,
	pass varbinary(64) not null,
	id_tipo_usuario int not null foreign key references tipos_usuarios(id),
	estado bit not null default 1
)

CREATE TABLE depositos(
	id int primary key identity(1,1),
	nombre varchar(255) not null unique,
	descripcion varchar(255) null,
	id_tipo_deposito int not null foreign key references tipos_depositos(id),
	estado bit not null default 1
)

CREATE TABLE formulas(
	id int primary key identity(1,1),
	nombre varchar(255) not null unique,
	codigo varchar(255) not null unique,
	descripcion varchar(255) null,
	estado bit not null default 1
)

CREATE TABLE productos(
	id int primary key identity(1,1),
	nombre varchar(255) not null unique,
	codigo varchar(255) not null unique,
	descripcion varchar(255) null,
	id_unidad_medida int not null foreign key references unidades_medida(id),
	id_tipo_producto int not null foreign key references tipos_productos(id),
	estado bit not null default 1
)

CREATE TABLE tubos_detalle(
	id int primary key identity(1,1),
	id_producto int not null foreign key references productos(id),
	peso_x_metro decimal(10,4) null,
	estado bit not null default 1
)

CREATE TABLE muebles_detalle(
	id int primary key identity(1,1),
	id_producto int not null foreign key references productos(id),
	familia varchar(255) null,
	estado bit not null default 1
)

CREATE TABLE productos_x_formula(
	id_formula int not null foreign key references formulas(id),
	id_producto int not null foreign key references productos(id),
	cantidad decimal(10,4) not null,
	estado bit not null default 1,
	primary key(id_formula, id_producto)
)

CREATE TABLE productos_x_deposito(
	id_producto int not null foreign key references productos(id),
	id_deposito int not null foreign key references depositos(id),
	saldo decimal(10,4) not null default 0,
	estado bit not null default 1
	primary key(id_producto, id_deposito)
)

CREATE TABLE movimientos(
	id int primary key identity(1,1),
	fecha datetime not null,
	id_producto int not null foreign key references productos(id),
	cantidad decimal(10,4) not null,
	id_tipo_movimiento int not null foreign key references tipos_movimientos(id),
	id_deposito_origen int null foreign key references depositos(id),
	id_deposito_destino int not null foreign key references depositos(id),
	estado bit not null default 1
)

CREATE TABLE presentaciones_productos(
	id int primary key identity(1,1),
	id_producto int not null foreign key references productos(id),
	id_unidad_medida int not null foreign key references unidades_medida(id),
	cantidad_unidad_base decimal(10,4) not null,
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



