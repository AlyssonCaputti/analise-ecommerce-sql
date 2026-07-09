-- Exploracao inicial: so pra saber o que tem em cada tabela antes de analisar.

-- quantas linhas em cada tabela
SELECT 'clientes' AS tabela, COUNT(*) AS linhas FROM clientes
UNION ALL
SELECT 'produtos', COUNT(*) FROM produtos
UNION ALL
SELECT 'pedidos', COUNT(*) FROM pedidos
UNION ALL
SELECT 'itens_pedido', COUNT(*) FROM itens_pedido;

-- quais status de pedido existem e quantos de cada
SELECT status, COUNT(*) AS qtd
FROM pedidos
GROUP BY status
ORDER BY qtd DESC;

-- periodo dos pedidos (menor e maior data)
SELECT MIN(data_pedido) AS primeiro, MAX(data_pedido) AS ultimo
FROM pedidos;
