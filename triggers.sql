-- trigger
DROP TRIGGER IF EXISTS atualiza_pedido;

DELIMITER //

CREATE TRIGGER atualiza_pedido
AFTER INSERT ON Itens_Pedido
FOR EACH ROW
BEGIN
    UPDATE Pedidos
    SET valor = (
        SELECT SUM(quantidade * valor)
        FROM Itens_Pedido
        WHERE pedido_id = NEW.pedido_id
    )
    WHERE pedido_id = NEW.pedido_id;
END//

DELIMITER ;

-- informacoes

INSERT INTO Pedidos (cliente_id, data, hora) VALUES
("14", curdate(), curtime());
INSERT INTO Pedidos (cliente_id, data, hora) VALUES
("23", curdate(), curtime());
INSERT INTO Pedidos (cliente_id, data, hora) VALUES
("27", curdate(), curtime());

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor) 
VALUES (27, 3, 2, (SELECT valor FROM Pizzas WHERE pizza_id = 3));

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor) 
VALUES (27, 16, 1, (SELECT valor FROM Pizzas WHERE pizza_id = 16));

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor) 
VALUES (28, 39, 2, (SELECT valor FROM Pizzas WHERE pizza_id = 39));

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor) 
VALUES (28, 20, 1, (SELECT valor FROM Pizzas WHERE pizza_id = 20));

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor) 
VALUES (29, 11, 1, (SELECT valor FROM Pizzas WHERE pizza_id = 11));

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor) 
VALUES (29, 22, 2, (SELECT valor FROM Pizzas WHERE pizza_id = 22));


-- teste
SELECT 
    p.pedido_id,
    c.nome AS cliente,
    p.valor AS valor_calculado_pelo_trigger
FROM Pedidos p
JOIN Clientes c ON p.cliente_id = c.cliente_id
ORDER BY p.pedido_id DESC
LIMIT 3;