
CREATE TABLE pacientes (
                id_paciente SERIAL NOT NULL,
                cedula VARCHAR(18) NOT NULL,
                nombre VARCHAR(300) NOT NULL,
                direccion VARCHAR(200) NOT NULL,
                codigo_postal VARCHAR(30) NOT NULL,
                telefono VARCHAR(20) NOT NULL,
                genero VARCHAR(12) NOT NULL,
                fecha_nacimiento DATE NOT NULL,
                email VARCHAR(50) NOT NULL,
                CONSTRAINT pacientes_pk PRIMARY KEY (id_paciente)
);


CREATE TABLE citas (
                id_cita SERIAL NOT NULL,
                id_paciente INTEGER NOT NULL,
                fecha DATE NOT NULL,
                hora_inicio TIME NOT NULL,
                hora_fin TIME NOT NULL,
                estado VARCHAR(45) NOT NULL,
                motivo VARCHAR(100) NOT NULL,
                CONSTRAINT citas_pk PRIMARY KEY (id_cita)
);


CREATE TABLE usuario (
                id_usuario SERIAL NOT NULL,
                usuario VARCHAR(45) NOT NULL,
                password VARCHAR(250) NOT NULL,
                estado VARCHAR(45) NOT NULL,
                CONSTRAINT usuario_pk PRIMARY KEY (id_usuario)
);


CREATE TABLE usuarios_token (
                id_token SERIAL NOT NULL,
                id_usuario INTEGER NOT NULL,
                token VARCHAR(250) NOT NULL,
                estado VARCHAR(45) NOT NULL,
                fecha TIMESTAMP NOT NULL,
                CONSTRAINT usuarios_token_pk PRIMARY KEY (id_token)
);


ALTER TABLE citas ADD CONSTRAINT pacientes_citas_fk
FOREIGN KEY (id_paciente)
REFERENCES pacientes (id_paciente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE usuarios_token ADD CONSTRAINT usuario_usuarios_token_fk
FOREIGN KEY (id_usuario)
REFERENCES usuario (id_usuario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;