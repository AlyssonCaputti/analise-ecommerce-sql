"""Cria o banco sqlite e carrega os CSVs. Roda com:  python carrega.py

Escolhi sqlite pra qualquer um conseguir rodar o projeto sem instalar banco
nenhum - o foco aqui e o SQL das consultas (pasta queries/).
"""
import csv
import sqlite3
from pathlib import Path

DB = "ecommerce.db"
DADOS = Path("dados")

TABELAS = {
    "clientes": ["cliente_id", "nome", "email", "uf", "data_cadastro"],
    "produtos": ["produto_id", "nome", "categoria", "preco"],
    "pedidos": ["pedido_id", "cliente_id", "data_pedido", "status"],
    "itens_pedido": ["item_id", "pedido_id", "produto_id", "quantidade", "preco_unitario"],
}


def main():
    con = sqlite3.connect(DB)
    con.executescript(Path("schema.sql").read_text(encoding="utf-8"))

    for tabela, cols in TABELAS.items():
        with open(DADOS / f"{tabela}.csv", encoding="utf-8") as f:
            reader = csv.reader(f)
            next(reader)  # header
            linhas = list(reader)
        placeholders = ",".join("?" * len(cols))
        con.executemany(f"INSERT INTO {tabela} VALUES ({placeholders})", linhas)
        print(f"{tabela}: {len(linhas)} linhas")

    con.commit()
    con.close()
    print(f"banco criado: {DB}")


if __name__ == "__main__":
    main()
