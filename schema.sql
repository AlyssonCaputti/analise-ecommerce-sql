-- schema do banco de e-commerce (sqlite)
-- deixei tudo simples, sem foreign key formal - o objetivo aqui e praticar
-- as consultas, nao modelar um banco de producao.

DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS itens_pedido;

CREATE TABLE clientes (
    cliente_id    INTEGER PRIMARY KEY,
    nome          TEXT,
    email         TEXT,
    uf            TEXT,
    data_cadastro TEXT
);

CREATE TABLE produtos (
    produto_id INTEGER PRIMARY KEY,
    nome       TEXT,
    categoria  TEXT,
    preco      TEXT   -- veio como texto do csv (tem um com virgula), trato na query
);

CREATE TABLE pedidos (
    pedido_id   INTEGER PRIMARY KEY,
    cliente_id  INTEGER,
    data_pedido TEXT,
    status      TEXT   -- concluido / cancelado / pendente
);

CREATE TABLE itens_pedido (
    item_id        INTEGER PRIMARY KEY,
    pedido_id      INTEGER,
    produto_id     INTEGER,
    quantidade     INTEGER,
    preco_unitario TEXT   -- idem, texto por causa de 1 valor com virgula
);
