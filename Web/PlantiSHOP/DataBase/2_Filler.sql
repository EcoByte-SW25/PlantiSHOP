USE plantishop_db;

-- Usuarios
INSERT INTO usuarios (nombre, correo, contrasena, descripcion, calificacion, es_admin)
VALUES 
('Ana Viveros', 'ana@correo.com', '1234hash', 'Amante de las plantas suculentas', 4.8, FALSE),
('Carlos Verde', 'carlos@correo.com', '5678hash', NULL, NULL, FALSE),
('Admin Root', 'admin@plantishop.com', 'adminhash', 'Administrador general', 5.0, TRUE);

-- Ubicaciones
INSERT INTO ubicaciones (estado, ciudad, municipio, codigo_postal)
VALUES 
('CDMX', 'Ciudad de México', 'Coyoacán', '04000'),
('CDMX', 'Ciudad de México', 'Benito Juárez', '03020');

-- Plantas
INSERT INTO plantas (id_usuario, nombre, especie, tipo, descripcion, imagen, precio, en_venta, cantidad_stock, luz_recomendada)
VALUES 
(1, 'Echeveria Elegans', 'Echeveria', 'suculenta', 'Fácil de cuidar y muy decorativa', 'echeveria.jpg', 100, TRUE, 5, 50),
(1, 'Sansevieria', 'Dracaena trifasciata', 'interior', 'Conocida como lengua de suegra', 'sansevieria.jpg', 150, TRUE, 3, 30);

-- Transacciones
INSERT INTO transacciones (id_usuario_vendedor, id_usuario_comprador, id_planta, fecha)
VALUES
(1, 2, 1, NOW());

-- Mensajes
INSERT INTO mensajes (id_usuario, fecha_envio, contenido, archivo)
VALUES 
(2, NOW(), 'Hola, ¿todavía tienes la echeveria?', NULL),
(1, NOW(), 'Sí, tengo 5 disponibles.', NULL);

-- Mensajes IA
INSERT INTO mensajes_ia (id_usuario, mensaje_ia, fecha_envio)
VALUES 
(2, '¿Cuál es la mejor planta para interiores con poca luz?', NOW());

-- Fotos IA
INSERT INTO fotos_ia (imagen, resultado)
VALUES 
('planta1.png', 'sansevieria');

-- Movimientos (log automático simulado)
INSERT INTO movimientos (id_usuario, fecha_mov, accion)
VALUES 
(1, NOW(), 'INSERT planta id=1'),
(2, NOW(), 'INSERT transaccion id=1');