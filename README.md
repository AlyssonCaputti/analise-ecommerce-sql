# Análise de e-commerce com SQL

Projeto de estudo de análise de dados: um pequeno banco de e-commerce e um
conjunto de consultas SQL respondendo perguntas de negócio (faturamento,
produtos mais vendidos, clientes, etc).

Usei **SQLite** pra qualquer pessoa conseguir rodar sem instalar banco nenhum.
O foco do projeto são as consultas na pasta `queries/`.

## Como rodar

Precisa só de Python (o `sqlite3` já vem junto):

```bash
python carrega.py        # cria ecommerce.db e carrega os CSVs
```

Depois é só abrir o banco e rodar as queries. Ex. no terminal:

```bash
sqlite3 ecommerce.db < queries/03_faturamento.sql
```

Ou abrir o `ecommerce.db` no [DB Browser for SQLite](https://sqlitebrowser.org/)
e colar as consultas.

## Dados

Dataset fictício que eu gerei (`dados/*.csv`) simulando uma loja online:

| Tabela | Linhas | O que é |
|---|---|---|
| `clientes` | 50 | cadastro dos clientes |
| `produtos` | 16 | catálogo, 4 categorias |
| `pedidos` | 300 | pedidos (status: concluído / cancelado / pendente) |
| `itens_pedido` | 767 | itens de cada pedido |

Deixei alguns "problemas" de propósito, que são coisas que aparecem em dado
real e que as consultas tratam:

- alguns clientes **sem e-mail**;
- a UF vem com grafia diferente pra mesma coisa (`SP`, `S.P.`, `sao paulo`);
- um preço cadastrado com **vírgula** em vez de ponto (`199,90`);
- pedidos **cancelados/pendentes** que não podem entrar no faturamento.

## Consultas

| Arquivo | O que responde |
|---|---|
| `queries/01_exploracao.sql` | contagem por tabela, status, período |
| `queries/02_qualidade_dados.sql` | acha os problemas acima e padroniza a UF |
| `queries/03_faturamento.sql` | faturamento total, por mês e ticket médio |
| `queries/04_produtos_categorias.sql` | produtos e categorias mais vendidos (com `HAVING`) |
| `queries/05_clientes.sql` | clientes que mais gastaram, pedidos por UF |

## O que pratiquei aqui

`JOIN`, `GROUP BY`, `HAVING`, `CASE`, subquery, agregações e um pouco de
tratamento de dado sujo direto no SQL. Próximo passo que quero estudar:
window functions e criar views pra não repetir os `CAST`/`REPLACE`.
