-- Produtos e categorias mais vendidos.

-- top 10 produtos por quantidade vendida
SELECT
    pr.nome,
    pr.categoria,
    SUM(i.quantidade) AS unidades_vendidas
FROM itens_pedido i
JOIN produtos pr ON pr.produto_id = i.produto_id
GROUP BY pr.produto_id
ORDER BY unidades_vendidas DESC
LIMIT 10;

-- faturamento por categoria
SELECT
    pr.categoria,
    ROUND(SUM(i.quantidade * CAST(REPLACE(i.preco_unitario, ',', '.') AS REAL)), 2) AS faturamento
FROM itens_pedido i
JOIN produtos pr ON pr.produto_id = i.produto_id
GROUP BY pr.categoria
ORDER BY faturamento DESC;

-- categorias que passaram de R$ 5000 de faturamento (exemplo de HAVING)
SELECT
    pr.categoria,
    ROUND(SUM(i.quantidade * CAST(REPLACE(i.preco_unitario, ',', '.') AS REAL)), 2) AS faturamento
FROM itens_pedido i
JOIN produtos pr ON pr.produto_id = i.produto_id
GROUP BY pr.categoria
HAVING faturamento > 5000
ORDER BY faturamento DESC;
