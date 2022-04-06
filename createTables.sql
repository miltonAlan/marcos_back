drop table if exists movimiento;
drop table if exists cuenta;
drop table if exists cliente;
drop table if exists tipo_cuenta;

CREATE TABLE cliente
(
  num_cedula character varying(255) NOT NULL,
  apellidos character varying(255),
  clave character varying(255),
  nombres character varying(255),
  usuario character varying(255),
  CONSTRAINT cliente_pkey PRIMARY KEY (num_cedula)
);


CREATE TABLE tipo_cuenta
(
  cod_cuenta character(1) NOT NULL,
  nom_cuenta character varying(255),
  CONSTRAINT tipo_cuenta_pkey PRIMARY KEY (cod_cuenta)
);

CREATE TABLE cuenta
(
  num_cuenta bigint NOT NULL,
  val_saldo double precision,
  cod_cuenta character(1),
  num_cedula character varying(255),
  CONSTRAINT cuenta_pkey PRIMARY KEY (num_cuenta),
  CONSTRAINT fk_cuenta_cod_cuenta FOREIGN KEY (cod_cuenta)
      REFERENCES tipo_cuenta (cod_cuenta) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_cuenta_num_cedula FOREIGN KEY (num_cedula)
      REFERENCES cliente (num_cedula) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE movimiento
(
  num_movimiento bigint NOT NULL,
  fecha_mov timestamp without time zone,
  val_credito double precision,
  val_debito double precision,
  num_cedula character varying(255),
  num_cuenta bigint,
  CONSTRAINT movimiento_pkey PRIMARY KEY (num_movimiento),
  CONSTRAINT fk_movimiento_num_cedula FOREIGN KEY (num_cedula)
      REFERENCES cliente (num_cedula) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_movimiento_num_cuenta FOREIGN KEY (num_cuenta)
      REFERENCES cuenta (num_cuenta) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
