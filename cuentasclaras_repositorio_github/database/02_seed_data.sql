-- =========================================================================
-- DATOS SEMILLA: 5 TIENDAS PILOTO DE EL PEÑÓN, SANTANDER (TRL 5)
-- =========================================================================

INSERT INTO tiendas (id_tienda, nombre_comercial, nit_rut, telefono, municipio) VALUES
(1, 'Tienda La Esperanza', '901234567-1', '3104567890', 'El Peñón, Santander'),
(2, 'Abarrotes El Progreso', '901234567-2', '3128901234', 'El Peñón, Santander'),
(3, 'Minimercado El Vecino', '901234567-3', '3143322110', 'El Peñón, Santander'),
(4, 'Tienda Donde Beto', '901234567-4', '3209876543', 'El Peñón, Santander'),
(5, 'Autoservicio San Cayetano', '901234567-5', '3156677889', 'El Peñón, Santander')
ON CONFLICT (id_tienda) DO NOTHING;

-- Clientes representativos de prueba
INSERT INTO clientes (id_cliente, id_tienda, documento_identidad, nombre_completo, telefono_celular, acepta_habeas_data) VALUES
(101, 1, '109817001', 'Martha Cecilia Ortiz', '3104567890', TRUE),
(102, 1, '109817002', 'Carlos Julio Rueda', '3128901234', TRUE),
(103, 1, '109817003', 'Ana Mercedes Forero', '3143322110', TRUE)
ON CONFLICT (id_cliente) DO NOTHING;

-- Cuentas de cartera
INSERT INTO cuentas_cartera (id_cuenta, id_cliente, cupo_maximo, saldo_actual, plazo_dias, estado_cartera) VALUES
(101, 101, 80000.00, 45000.00, 15, 'EN_MORA'),
(102, 102, 100000.00, 85000.00, 15, 'POR_VENCER'),
(103, 103, 50000.00, 12000.00, 15, 'AL_DIA')
ON CONFLICT (id_cuenta) DO NOTHING;
