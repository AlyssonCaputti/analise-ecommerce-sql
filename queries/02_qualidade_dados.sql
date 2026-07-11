-- Checagem de qualidade: achei umas coisas estranhas nos dados, deixei aqui
-- registrado o que encontrei (e no README explico o que fiz com cada uma).

-- 1) clientes sem email
SELECT COUNT(*) AS clientes_sem_email
FROM clientes
WHERE email = '' OR email IS NULL;

-- 2) UF com grafia baguncada (SP, S.P., "sao paulo"...)
SELECT uf, COUNT(*) AS qtd
FROM clientes
GROUP BY uf
ORDER BY qtd DESC;

-- 3) preco de item que nao da pra converter direto pra numero
--    (tem um cadastrado com virgula em vez de ponto)
SELECT item_id, preco_unitario
FROM itens_pedido
WHERE preco_unitario LIKE '%,%';

-- padronizacao de UF: normaliza pra sigla. faco isso com CASE mesmo,
-- que e o que eu sei fazer. da pra melhorar com uma tabela de-para depois.
SELECT
    CASE
        WHEN uf IN ('SP', 'S.P.', 'sao paulo') THEN 'SP'
        ELSE UPPER(uf)
    END AS uf_padrao,
    COUNT(*) AS qtd
FROM clientes
GROUP BY uf_padrao
ORDER BY qtd DESC;
