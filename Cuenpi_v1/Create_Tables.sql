CREATE TABLE Cliente(
	IdCliente INT PRIMARY KEY IDENTITY(1, 1),
	Nombre VARCHAR(50) NOT NULL,
	Alias VARCHAR(25) NOT NULL,
	Telefono VARCHAR(15) NOT NULL,
	Direccion VARCHAR(120)
)

CREATE TABLE MetodoPago(
	 IdMetodoPago INT PRIMARY KEY IDENTITY (1, 1),
	 Nombre VARCHAR(25)
)

CREATE TABLE Abono(
	IdAbono INT PRIMARY KEY IDENTITY(1, 1),
	IdCliente INT NOT NULL,
	Monto DECIMAL(7, 2) NOT NULL,
	Fecha DATE NOT NULL,
	CONSTRAINT FK_IdCliente FOREIGN KEY (IdCliente) 
	REFERENCES Cliente (IdCliente)
)

ALTER TABLE Abono 
ADD IdMetodoPago INT NOT NULL

ALTER TABLE Abono
ADD CONSTRAINT FK_IdMetodoPago FOREIGN KEY (IdMetodoPago)
REFERENCES MetodoPago (IdMetodoPago)

CREATE TABLE Marca(
	IdMarca INT PRIMARY KEY IDENTITY(1, 1),
	Nombre VARCHAR(25) NOT NULL
)

CREATE TABLE Categoria(
	IdCategoria INT PRIMARY KEY IDENTITY(1, 1),
	Nombre VARCHAR(80) NOT NULL
)

CREATE TABLE Caracteristica(
	IdCaracteristica INT PRIMARY KEY IDENTITY(1, 1),
	Nombre VARCHAR(100) NOT NULL
)

CREATE TABLE Categoria_Caracteristica(
	IdCategoria INT,
	IdCaracteristica INT,
	CONSTRAINT FK_IdCategoria_Caracteristica FOREIGN KEY (IdCategoria)
	REFERENCES Categoria (IdCategoria),
	CONSTRAINT FK_IdCaracteristica_Categoria FOREIGN KEY (IdCaracteristica)
	REFERENCES Caracteristica (IdCaracteristica)
)

CREATE TABLE Producto(
	IdProducto INT PRIMARY KEY IDENTITY(1, 1),
	IdMarca INT NOT NULL,
	IdCategoria INT NOT NULL,
	Codigo VARCHAR(30) NOT NULL,
	Nombre VARCHAR(50) NOT NULL,
	Precio_Compra DECIMAL(7, 2) NOT NULL,
	CONSTRAINT FK_IdMarca_Producto FOREIGN KEY (IdMarca)
	REFERENCES Marca (IdMarca),
	CONSTRAINT FK_IdCategoria_Producto FOREIGN KEY (IdCategoria)
	REFERENCES Categoria (IdCategoria)
)

ALTER TABLE Producto
ADD Cantidad TINYINT NOT NULL

CREATE TABLE Producto_Caracteristica(
	IdProducto INT NOT NULL,
	IdCaracteristica INT NOT NULL,
	Valor VARCHAR(100) NOT NULL
	CONSTRAINT FK_IdProducto_Caracteristica FOREIGN KEY (IdProducto)
	REFERENCES Producto (IdProducto),
	CONSTRAINT FK_IdCaracteristica_Producto FOREIGN KEY (IdCaracteristica)
	REFERENCES Caracteristica (IdCaracteristica)
)

CREATE TABLE Estado(
	IdEstado INT PRIMARY KEY IDENTITY(1, 1),
	Nombre VARCHAR(30) NOT NULL
)

CREATE TABLE Compra(
	IdCompra INT PRIMARY KEY IDENTITY(1, 1),
	Fecha DATE NOT NULL,
	Nota VARCHAR(100) NOT NULL
)

CREATE TABLE Compra_Producto(
	IdCompra INT NOT NULL,
	IdProducto INT NOT NULL,
	Cantidad TINYINT NOT NULL,
	CONSTRAINT FK_IdCompra_Producto FOREIGN KEY (IdCompra)
	REFERENCES Compra (IdCompra),
	CONSTRAINT FK_IdProducto_Compra FOREIGN KEY (IdProducto)
	REFERENCES Producto (IdProducto)
)

ALTER TABLE Compra_Producto
ADD CONSTRAINT PK_Compra_Producto PRIMARY KEY (IdCompra, IdProducto)

CREATE TABLE Cambio_Estado_Compra(
	IdEstado INT NOT NULL,
	IdCompra INT NOT NULL,
	IdProducto INT NOT NULL,
	FechaCambio DATE NOT NULL,
	CONSTRAINT FK_IdEstado_Cambio_Estado_Compra FOREIGN KEY (IdEstado)
	REFERENCES Estado (IdEstado),
	CONSTRAINT FK_IdCompra_Cambio_Estado_Compra FOREIGN KEY (IdCompra, IdProducto)
	REFERENCES Compra_Producto (IdCompra, IdProducto)
)

ALTER TABLE Cambio_Estado_Compra
ADD CONSTRAINT PK_Cambio_Estado_Compra PRIMARY KEY (IdEstado, IdCompra, IdProducto)

CREATE TABLE Orden(
	IdOrden INT PRIMARY KEY IDENTITY(1, 1),
	IdCliente INT NOT NULL,
	Fecha DATE NOT NULL,
	CONSTRAINT FK_IdCliente_Orden FOREIGN KEY (IdCliente)
	REFERENCES Cliente (IdCliente)
)

CREATE TABLE Orden_Producto(
	IdOrden INT NOT NULL,
	IdProducto INT NOT NULL,
	Cantidad TINYINT NOT NULL,
	Precio_Compra DECIMAL(7, 2) NOT NULL,
	CONSTRAINT FK_IdOrden_Orden_Producto FOREIGN KEY (IdOrden)
	REFERENCES Orden (IdOrden),
	CONSTRAINT FK_IdProducto_Orden_Producto FOREIGN KEY (IdProducto)
	REFERENCES Producto (IdProducto)
)

ALTER TABLE Orden_Producto
ADD CONSTRAINT PK_Orden_Producto PRIMARY KEY (IdOrden, IdProducto)

CREATE TABLE Cambio_Estado_Orden(
	IdEstado INT NOT NULL,
	IdOrden INT NOT NULL,
	IdProducto INT NOT NULL,
	Fecha_Cambio DATE NOT NULL,
	CONSTRAINT FK_IdEstado_Cambio_Estado_Orden FOREIGN KEY (IdEstado)
	REFERENCES Estado (IdEstado),
	CONSTRAINT FK_IdOrden_Cambio_Estado_Orden FOREIGN KEY (IdOrden, IdProducto)
	REFERENCES Orden_Producto (IdOrden, IdProducto)
)

ALTER TABLE Cambio_Estado_Orden
ADD CONSTRAINT PK_IdCambio_Estado_Orden PRIMARY KEY (IdEstado, IdOrden, IdProducto)