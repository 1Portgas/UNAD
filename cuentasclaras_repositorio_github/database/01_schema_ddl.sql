-- =========================================================================
-- CUENTASCLARAS: SCRIPT DDL OFICIAL POSTGRESQL 16
-- Normalización: 3FN | Propiedades: ACID
-- =========================================================================

CREATE TABLE IF NOT EXISTS tiendas (
    id_tienda BIGSERIAL PRIMARY KEY,
    nombre_comercial VARCHAR(150) NOT NULL,
    nit_rut VARCHAR(30) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(200),
    municipio VARCHAR(100) DEFAULT 'El Peñón, Santander',
    fecha_registro TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario BIGSERIAL PRIMARY KEY,
    id_tienda BIGINT NOT NULL REFERENCES tiendas(id_tienda) ON DELETE RESTRICT,
    nombre_completo VARCHAR(150) NOT NULL,
    correo VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(30) DEFAULT 'TENDERO_ADMIN',
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS clientes (
    id_cliente BIGSERIAL PRIMARY KEY,
    id_tienda BIGINT NOT NULL REFERENCES tiendas(id_tienda) ON DELETE RESTRICT,
    documento_identidad VARCHAR(25) NOT NULL,
    nombre_completo VARCHAR(150) NOT NULL,
    telefono_celular VARCHAR(20) NOT NULL,
    direccion_residencia VARCHAR(200),
    acepta_habeas_data BOOLEAN NOT NULL DEFAULT FALSE,
    fecha_consentimiento TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_registro TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_cliente_tienda_doc UNIQUE (id_tienda, documento_identidad),
    CONSTRAINT chk_habeas_data_legal CHECK (acepta_habeas_data = TRUE)
);

CREATE TABLE IF NOT EXISTS cuentas_cartera (
    id_cuenta BIGSERIAL PRIMARY KEY,
    id_cliente BIGINT NOT NULL UNIQUE REFERENCES clientes(id_cliente) ON DELETE RESTRICT,
    cupo_maximo NUMERIC(12,2) NOT NULL DEFAULT 50000.00,
    saldo_actual NUMERIC(12,2) NOT NULL DEFAULT 0.00,
    plazo_dias INT NOT NULL DEFAULT 15,
    estado_cartera VARCHAR(20) DEFAULT 'AL_DIA',
    version BIGINT NOT NULL DEFAULT 0,
    fecha_actualizacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_saldo_no_negativo CHECK (saldo_actual >= 0.00),
    CONSTRAINT chk_cupo_no_negativo CHECK (cupo_maximo >= 0.00)
);

CREATE TABLE IF NOT EXISTS movimientos_transaccionales (
    id_movimiento BIGSERIAL PRIMARY KEY,
    id_cuenta BIGINT NOT NULL REFERENCES cuentas_cartera(id_cuenta) ON DELETE RESTRICT,
    tipo_movimiento VARCHAR(25) NOT NULL,
    monto NUMERIC(12,2) NOT NULL,
    saldo_anterior NUMERIC(12,2) NOT NULL,
    saldo_posterior NUMERIC(12,2) NOT NULL,
    descripcion VARCHAR(255),
    fecha_hora TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_tipo_movimiento CHECK (tipo_movimiento IN ('CARGO_FIADO', 'ABONO_PAGO')),
    CONSTRAINT chk_monto_positivo CHECK (monto > 0.00)
);

CREATE INDEX IF NOT EXISTS idx_clientes_tienda ON clientes(id_tienda);
CREATE INDEX IF NOT EXISTS idx_movimientos_cuenta_fecha ON movimientos_transaccionales(id_cuenta, fecha_hora DESC);
