# Projeto de Banco de Dados - Concessionária AutoFácil

Este projeto foi desenvolvido como parte do curso de **Administrador de Banco de Dados** do SENAI, com o objetivo de modelar, normalizar e implementar um banco de dados relacional para uma concessionária fictícia chamada **AutoFácil**.

---

## Objetivo

O sistema visa informatizar e organizar a gestão de clientes, vendedores, veículos e vendas, promovendo a correta normalização dos dados e facilitando consultas, relatórios e integrações futuras.

---

## Ferramentas Utilizadas

- **brModelo**: Utilizado para a modelagem conceitual (DER - Diagrama Entidade Relacionamento).
- **Oracle Data Modeler**: Utilizado para a modelagem lógica e geração de scripts DDL compatíveis com Oracle.
- **MySQL Workbench**: Utilizado para a modelagem física, execução dos scripts e testes no SGBD MySQL.

---

## Estrutura do Projeto

```plaintext
Projetos/
└── Concessionaria-AutoFacil/
    ├── Lógico - Oracle Data Modeler/
    │   ├── AutoFacil-DDL_Logico.ddl
    │   ├── AutoFacil-IMG.pdf
    |   └── DMD_Logico-AutoFacil.dmd
    ├── Físico - MySQL Workbench/
    │   ├── AutoFacil-DDL_Workbench.sql
    │   ├── AutoFacil-DML_Workbench.sql
    │   ├── AutoFacil-Triggers.sql
    |   ├── AutoFacil-DQL_Parte05.sql
    |   └── AutoFacil-ScriptCompleto.sql
    └── README.md
```

**Lógico - Oracle Data Modeler/**: Contém o script DDL gerado a partir do modelo lógico, com nomenclatura padronizada (ATFTBxxx) e comentários detalhados.

- **Físico - MySQL Workbench/**: Scripts para criação das tabelas, inserção de dados de exemplo e triggers para manter a integridade dos dados no MySQL.
- **README.md**: Documentação do projeto.

---

## Modelagem e Normalização

### Modelagem Conceitual

O DER foi elaborado no **brModelo**, identificando as principais entidades e seus relacionamentos:

- **Cliente** (ID, Nome, CPF, Telefones)
- **Vendedor** (ID, Matrícula, Nome, Telefones)
- **Veículo** (ID, Modelo, Marca, Ano, Preço, Status)
- **Venda** (ID, Cliente, Vendedor, Data)
- **ItemVenda** (Venda, Veículo)

### Normalização

Para garantir a correta normalização (3FN), os telefones de clientes e vendedores foram separados em tabelas específicas:

- **ATFTB101_TELEFONE_CLIENTE**: Permite múltiplos telefones por cliente, com indicação do tipo (Pessoal, Comercial, Trabalho).
- **ATFTB102_TELEFONE_VENDEDOR**: Permite múltiplos telefones por vendedor, com indicação do tipo (Pessoal, Trabalho).

Essa abordagem elimina redundâncias e facilita a manutenção dos dados.

---

## Nomenclatura

- **ATFTBxxx**: Prefixo padrão para todas as tabelas, facilitando a identificação e organização.
- **PK_ / FK_ / CC_ / UK_**: Prefixos para constraints (Primary Key, Foreign Key, Check, Unique).
- **Campos em MAIÚSCULO**: Seguindo padrão corporativo e facilitando leitura.
- **Comentários**: Todas as tabelas e colunas possuem comentários explicativos.

---

## Scripts Disponíveis

- **AutoFacil-DDL_Logico.ddl**: Script DDL gerado pelo Oracle Data Modeler, compatível com Oracle Database.
- **AutoFacil-DDL_Workbench.sql**: Script de criação do banco de dados e tabelas no MySQL, incluindo constraints e comentários.
- **AutoFacil-DML_Workbench.sql**: Script de inserção de dados fictícios para testes (clientes, vendedores, veículos, vendas e telefones).
- **AutoFacil-Triggers.sql**: Triggers para atualização automática do status dos veículos conforme venda ou remoção de venda.

---

## Exemplo de Dados Inseridos

- **Clientes**: 4 clientes fictícios, cada um podendo ter múltiplos telefones.
- **Vendedores**: 2 vendedores fictícios, cada um podendo ter múltiplos telefones.
- **Veículos**: 10 veículos, com status "Disponível" ou "Vendido".
- **Vendas**: 3 vendas, cada uma podendo envolver um ou mais veículos.
- **Telefones**: Telefones associados corretamente a clientes e vendedores, conforme a normalização.

---

## Consultas Exemplares

- Listar todos os telefones de um cliente:

  ```sql
  SELECT c.NO_CLIENTE, t.NR_TELEFONE, t.IC_TIPO_TELEFONE
    FROM ATFTB001_CLIENTE c
    JOIN ATFTB101_TELEFONE_CLIENTE t ON c.ID_CLIENTE = t.ID_CLIENTE
   WHERE c.NO_CLIENTE = 'Ithallo';
  ```

- Listar todos os veículos disponíveis:

  ```sql
  SELECT * FROM ATFTB003_VEICULO WHERE IC_STATUS = 'D';
  ```

- Listar vendas de um vendedor específico:

  ```sql
  SELECT v.ID_VENDA, v.DT_VENDA, c.NO_CLIENTE
    FROM ATFTB004_VENDA v
    JOIN ATFTB001_CLIENTE c ON v.ID_CLIENTE = c.ID_CLIENTE
   WHERE v.ID_VENDEDOR = 1;
  ```

Projeto desenvolvido para fins didáticos no curso de Administrador de Banco de Dados - SENAI.
