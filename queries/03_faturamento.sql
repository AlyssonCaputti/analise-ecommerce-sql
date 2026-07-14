-- Faturamento e ticket medio.
-- o preco_unitario ta como texto (tem 1 com virgula), entao troco a virgula
-- por ponto e converto pra REAL antes de multiplicar pela quantidade.

-- faturamento total
SELECT
    ROUND(SUM(quantidade * CAST(REPLACE(preco_unitario, ',', '.') AS REAL)), 2) AS faturamento
FROM itens_pedido;

-- faturamento por mes
SELECT
    SUBSTR(p.data_pedido, 1, 7) AS mes,
    ROUND(SUM(i.quantidade * CAST(REPLACE(i.preco_unitario, ',', '.') AS REAL)), 2) AS faturamento
FROM itens_pedido i
JOIN pedidos p ON p.pedido_id = i.pedido_id
GROUP BY mes
ORDER BY mes;

-- ticket medio por pedido
SELECT
    ROUND(AVG(total_pedido), 2) AS ticket_medio
FROM (
    SELECT
        i.pedido_id,
        SUM(i.quantidade * CAST(REPLACE(i.preco_unitario, ',', '.') AS REAL)) AS total_pedido
    FROM itens_pedido i
    GROUP BY i.pedido_id
);
