-- Faturamento e ticket medio.
-- o preco_unitario ta como texto (tem 1 com virgula), entao troco a virgula
-- por ponto e converto pra REAL antes de multiplicar pela quantidade.
--
-- IMPORTANTE: so conta pedido com status 'concluido'. na primeira versao eu
-- tinha somado tudo e o faturamento veio inflado pq entrava cancelado/pendente.

-- faturamento total (so concluido)
SELECT
    ROUND(SUM(i.quantidade * CAST(REPLACE(i.preco_unitario, ',', '.') AS REAL)), 2) AS faturamento
FROM itens_pedido i
JOIN pedidos p ON p.pedido_id = i.pedido_id
WHERE p.status = 'concluido';

-- faturamento por mes
SELECT
    SUBSTR(p.data_pedido, 1, 7) AS mes,
    ROUND(SUM(i.quantidade * CAST(REPLACE(i.preco_unitario, ',', '.') AS REAL)), 2) AS faturamento
FROM itens_pedido i
JOIN pedidos p ON p.pedido_id = i.pedido_id
WHERE p.status = 'concluido'
GROUP BY mes
ORDER BY mes;

-- ticket medio por pedido (so concluido)
SELECT
    ROUND(AVG(total_pedido), 2) AS ticket_medio
FROM (
    SELECT
        i.pedido_id,
        SUM(i.quantidade * CAST(REPLACE(i.preco_unitario, ',', '.') AS REAL)) AS total_pedido
    FROM itens_pedido i
    JOIN pedidos p ON p.pedido_id = i.pedido_id
    WHERE p.status = 'concluido'
    GROUP BY i.pedido_id
);
