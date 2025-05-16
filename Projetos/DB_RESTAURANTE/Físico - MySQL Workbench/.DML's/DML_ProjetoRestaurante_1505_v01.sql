INSERT INTO RSTTB003_PRODUTO (NO_PRODUTO, DS_PRODUTO, VL_PRODUTO, QT_ESTOQUE, IC_DISPONIVEL) VALUES
('Espetinho de Carne', 'Espetinho com carne bovina temperada', 10.00, 50, 'D'),
('Espetinho de Frango', 'Espetinho com peito de frango grelhado', 9.00, 60, 'D'),
('Coca-Cola 350ml', 'Refrigerante lata', 5.00, 30, 'D'),
('Guaraná 1L', 'Refrigerante PET 1 litro', 7.00, 20, 'D'),
('Cerveja 600ml', 'Cerveja pilsen 600ml', 8.50, 40, 'D');

-- Comanda para Mesa 1 - João
INSERT INTO RSTTB001_COMANDA (NR_MESA, NO_CLIENTE, DH_ABERTURA, DH_FECHAMENTO, IC_SITUACAO)
VALUES (1, 'João', NOW(), NOW() + INTERVAL 2 HOUR, 'A');

-- Comanda para Mesa 2 - Maria
INSERT INTO RSTTB001_COMANDA (NR_MESA, NO_CLIENTE, DH_ABERTURA, DH_FECHAMENTO, IC_SITUACAO)
VALUES (2, 'Maria', NOW(), NOW() + INTERVAL 1 HOUR, 'A');

-- Pedido 1 para a Comanda de João
INSERT INTO RSTTB002_PEDIDO (ID_COMANDA, DH_PEDIDO, IC_PEDIDO)
VALUES (1, NOW(), 'PE');

-- Pedido 2 para a Comanda de Maria
INSERT INTO RSTTB002_PEDIDO (ID_COMANDA, DH_PEDIDO, IC_PEDIDO)
VALUES (2, NOW(), 'PE');

-- João pediu 2 espetinhos de carne e 1 Coca-Cola
INSERT INTO RSTTB004_PRODUTO_PEDIDO (ID_PEDIDO, ID_PRODUTO, QT_PRODUTO) VALUES
(1, 1, 2),  -- Espetinho de Carne
(1, 3, 1);  -- Coca-Cola 350ml

-- Maria pediu 1 Espetinho de Frango e 1 Guaraná 1L
INSERT INTO RSTTB004_PRODUTO_PEDIDO (ID_PEDIDO, ID_PRODUTO, QT_PRODUTO) VALUES
(2, 2, 1),  -- Espetinho de Frango
(2, 4, 1);  -- Guaraná 1L

INSERT INTO RSTTB003_PRODUTO (NO_PRODUTO, DS_PRODUTO, VL_PRODUTO, IC_DISPONIVEL)
VALUES ('Suco Natural de Laranja', 'Suco fresco feito na hora', 6.00, 'D');

-- Comanda da Mesa 3 (sem nome de cliente)
INSERT INTO RSTTB001_COMANDA (NR_MESA, DH_ABERTURA, DH_FECHAMENTO, IC_SITUACAO)
VALUES (3, NOW() - INTERVAL 1 HOUR, NOW(), 'F');

-- Pedido da comanda 3, status finalizado
INSERT INTO RSTTB002_PEDIDO (ID_COMANDA, DH_PEDIDO, IC_PEDIDO)
VALUES (3, NOW() - INTERVAL 50 MINUTE, 'FI');

-- Associa produto (Espetinho de Frango)
INSERT INTO RSTTB004_PRODUTO_PEDIDO (ID_PEDIDO, ID_PRODUTO, QT_PRODUTO)
VALUES (3, 2, 1);

-- Comanda da Mesa 4, cancelada (com nome do cliente)
INSERT INTO RSTTB001_COMANDA (NR_MESA, NO_CLIENTE, DH_ABERTURA, DH_FECHAMENTO, IC_SITUACAO)
VALUES (4, 'Carlos', NOW() - INTERVAL 30 MINUTE, NOW(), 'C');

-- Comanda aberta para mesa 5
INSERT INTO RSTTB001_COMANDA (NR_MESA, NO_CLIENTE, DH_ABERTURA, DH_FECHAMENTO)
VALUES (5, 'Fernanda', NOW(), NOW() + INTERVAL 1 HOUR);

-- Pedido da Fernanda (em preparação)
INSERT INTO RSTTB002_PEDIDO (ID_COMANDA, DH_PEDIDO, IC_PEDIDO)
VALUES (5, NOW(), 'PR');

-- Pedido: 1 Cerveja 600ml e 1 Espetinho de Carne
INSERT INTO RSTTB004_PRODUTO_PEDIDO (ID_PEDIDO, ID_PRODUTO, QT_PRODUTO)
VALUES 
(4, 5, 1),  -- Cerveja
(4, 1, 1);  -- Espetinho de Carne
