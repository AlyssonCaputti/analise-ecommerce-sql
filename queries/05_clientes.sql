-- Analise de clientes.

-- top 10 clientes que mais gastaram (so pedidos concluidos)
SELECT
    c.cliente_id,
    c.nome,
    ROUND(SUM(i.quantidade * CAST(REPLACE(i.preco_unitario, ',', '.') AS REAL)), 2) AS total_gasto
FROM clientes c
JOIN pedidos p     ON p.cliente_id = c.cliente_id
JOIN itens_pedido i ON i.pedido_id = p.pedido_id
WHERE p.status = 'concluido'
GROUP BY c.cliente_id
ORDER BY total_gasto DESC
LIMIT 10;

-- numero de pedidos por UF (com a UF ja padronizada)
SELECT
    CASE WHEN c.uf IN ('SP','S.P.','sao paulo') THEN 'SP' ELSE UPPER(c.uf) END AS uf,
    COUNT(DISTINCT p.pedido_id) AS pedidos
FROM clientes c
JOIN pedidos p ON p.cliente_id = c.cliente_id
GROUP BY uf
ORDER BY pedidos DESC;

-- clientes que se cadastraram mas nunca fizeram pedido
-- (usei subquery com NOT IN; sei que da pra fazer com LEFT JOIN tb)
SELECT c.cliente_id, c.nome
FROM clientes c
WHERE c.cliente_id NOT IN (SELECT DISTINCT cliente_id FROM pedidos);
