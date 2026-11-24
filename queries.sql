-- A - Quantas tabelas o banco de dados possui?
show tables;
-- B - Quantos clientes cadastrados?
select * from clientes;
select count(*) from clientes;
select count(*) as `total de clientes` from clientes;
-- C - Quantas pizzas cadastradas?
select count(*) as `total de pizzas` from pizzas;
-- D - Quantas pizzas o pedido n° 3 possui?
select * from pedidos;
select * from Itens_Pedido;
select * from Itens_Pedido where pedido_id = 3;
select sum(quantidade) from Itens_Pedido where pedido_id = 3;
select sum(quantidade) as `total de pizzas` from Itens_Pedido where pedido_id = 3;
-- E - Qual o nome do cliente que fez o pedido n° 3?
select c.nome from pedidos p join clientes c on c.cliente_id = p.cliente_id where p.pedido_id = 3;
-- F - Quais os nomes das pizzas do pedido n° 3?
select * from itens_pedido where pedido_id = 3;
select p.nome from itens_pedido i join pizzas p on i.pizza_id = p.pizza_id where pedido_id = 3;

---------------------------
-- DESAFIO
-- A -  Crie um relatório que mostre todos os pedidos, itens, nome dos - clientes e nome das pizzas.
drop view if exists vw_relatorio;

create view vw_relatorio as
select
    p.pedido_id,
    pi.nome as nome_pizza,
    c.nome as nome_cliente
from Pedidos p
join Clientes c on c.cliente_id = p.cliente_id
join Itens_Pedido ip on p.pedido_id = ip.pedido_id
join Pizzas pi on pi.pizza_id = ip.pizza_id;

select * from vw_relatorio;
-- B - Acrescente uma coluna chamada subtotal que seja o calculo do preco - unitário da pizza vezes a quantidade
drop view if exists vw_calculo;

create view vw_calculo as
select
    p.pedido_id,
    pi.nome as nome_pizza,
    c.nome as nome_cliente,
    (ip.quantidade * ip.valor) as subtotal
from Pedidos p
join Clientes c on c.cliente_id = p.cliente_id
join Itens_Pedido ip on p.pedido_id = ip.pedido_id
join Pizzas pi on pi.pizza_id = ip.pizza_id;

select * from vw_calculo;
-- C - Agrupe os pedidos e calcule o valor total
drop view if exists vw_agrupamento;

create view vw_agrupamento as
select
    p.pedido_id,
    sum(ip.quantidade * ip.valor) as total
from Pedidos p
join Itens_Pedido ip on p.pedido_id = ip.pedido_id
group by p.pedido_id;

select * from vw_agrupamento;
-- D - Agrupe os pedidos e conte quantas pizzas cada pedido possui
drop view if exists vw_quantpizza;

create view vw_quantpizza as
select
    p.pedido_id,
    sum(ip.quantidade) as pizzas
from Pedidos p
join Itens_Pedido ip on p.pedido_id = ip.pedido_id
group by p.pedido_id;

select * from vw_quantpizza;
---------------------------
--Atividade 3
-- A - Novo cliente, telefone
insert into Clientes (nome, logradouro, numero, complemento, bairro, referencia) values
("Gaspar Oliveira", "Rua Alcides Postali", 21, NULL, "São Dimas", "Ao lado da igreja");
insert into Telefones (cliente_id, Telefone) values
(106, "19 99898-1141")
select * from Clientes;
select * from Telefones;
-- B - Nova pizza
insert into Pizzas (nome, descricao, valor) values
("A moda do chef", "Molho de tomate, palmito macio em rodelas, coberto com catupiry, frango desfiado, ovos, carne seca, oregano e azeitonas", 41.9)
-- C - Novo pedido
insert into Pedidos(cliente_id, data, hora, valor) values
(106, CURDATE(), CURTIME(), 83.80);
insert into Itens_Pedido(pedido_id, pizza_id, quantidade, valor) values
(27, 42, 2, 42.90);
-- D - Adicionar margherita
update Itens_Pedido set quantidade = 3 where pedido_id = 27;
insert into Itens_Pedido (pedido_id, pizza_id, quantidade, valor) values
(27, 22, 1, 41.90);
select * from Itens_Pedido;