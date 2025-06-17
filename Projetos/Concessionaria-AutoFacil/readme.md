Atividade de Banco de Dados - Concessionária
Objetivo
Modelar e implementar um banco de dados relacional para controlar os veículos, clientes, vendas e vendedores de uma concessionária.

Parte 1 - Entendimento do Cenário
A concessionária "AutoFácil" vende veículos novos e usados. Cada venda envolve um cliente, um vendedor e um ou mais veículos. É necessário manter o registro dos clientes, veículos disponíveis, vendedores e as vendas realizadas.

Parte 2 - Modelagem (Entidades e Relacionamentos)
Tabelas:
Cliente: (ID, Nome, CPF, Telefone)
Vendedor: (ID, Nome, Matrícula, Telefone)
Veículo: (ID, Modelo, Marca, Ano, Preço, Status)
Status: "Disponível", "Vendido"
Venda: (ID, ID_Cliente, ID_Vendedor, Data)
ItemVenda: (ID_Venda, ID_Veiculo)
Desafio:
Crie um diagrama entidade-relacionamento (ER) representando essas tabelas e os relacionamentos entre elas.

Parte 3 - Criação das Tabelas (SQL)
Escreva os comandos SQL para criar as tabelas conforme a modelagem acima.

Parte 4 - Inserção de Dados
Insira os seguintes dados fictícios no banco:

3 clientes
2 vendedores
10 veículos (alguns com status "Disponível", outros "Vendido")
3 vendas com respectivos itens vendidos
Parte 5 - Consultas SQL
Crie comandos SQL para responder:

Liste todos os veículos disponíveis para venda.
Liste todas as vendas realizadas com nome do cliente, nome do vendedor e data.
Mostre os veículos vendidos em cada venda.
Liste o total de vendas (valor) por vendedor.
Mostre o total gasto por cada cliente.
Liste os veículos que ainda não foram vendidos.
Parte 6 - Entrega
Entregar arquivo projeto-concessionario.sql, com todos os comandos necessário para replicar toda a base e registros.
Parte 7 - Reflexão
O que aconteceria se não usássemos a tabela ItemVenda?
Por que é importante manter o campo "Status" do veículo atualizado após uma venda?

---

- **Físico - MySQL Workbench/**: Contém o script SQL para criação do banco de dados no MySQL, incluindo tabelas, chaves primárias, estrangeiras e restrições.
- **Lógico - Oracle Data Modeler/**: Contém o script DDL gerado pelo Oracle Data Modeler, representando o modelo lógico do banco de dados.
- **README.md**: Este arquivo de documentação.

---

## Modelagem do Banco de Dados

O projeto foi modelado em três níveis:

- **Modelo Conceitual**: Representação DER (Diagrama Entidade-Relacionamento) das entidades e seus relacionamentos.
- **Modelo Lógico**: Estrutura das tabelas, tipos de dados, chaves e restrições, conforme visto no Oracle Data Modeler.
- **Modelo Físico**: Scripts SQL prontos para execução no SGBD (MySQL ou Oracle).

### Entidades Principais

- **Cliente**: Armazena dados dos clientes (ID, Nome, CPF).
- **Vendedor**: Armazena dados dos vendedores (ID, Matrícula, Nome).
- **Veículo**: Armazena dados dos veículos (ID, Modelo, Marca, Ano, Preço, Status).
- **Venda**: Registra cada venda realizada, associando cliente e vendedor, com data.
- **Venda_Veículo**: Tabela associativa para registrar quais veículos foram vendidos em cada venda (permitindo vendas de múltiplos veículos).

### Relacionamentos

- Um cliente pode realizar várias vendas.
- Um vendedor pode participar de várias vendas.
- Uma venda pode envolver um ou mais veículos.
- Cada veículo pode ser vendido em apenas uma venda (após vendido, seu status muda para "Vendido").

---

## Scripts Disponíveis

- [`Físico - MySQL Workbench/AutoFacil-DDL_Workbench.sql`](Físico%20-%20MySQL%20Workbench/AutoFacil-DDL_Workbench.sql):  
  Script para criação do banco de dados no MySQL, incluindo todas as tabelas, chaves e restrições.

- [`Lógico - Oracle Data Modeler/AutoFacil-DDL_Logico.ddl`](Lógico%20-%20Oracle%20Data%20Modeler/AutoFacil-DDL_Logico.ddl):  
  Script DDL gerado pelo Oracle Data Modeler, compatível com Oracle Database.

---

## Como Utilizar

1. **Escolha o SGBD**:  
   - Para MySQL, utilize o script da pasta `Físico - MySQL Workbench`.
   - Para Oracle, utilize o script da pasta `Lógico - Oracle Data Modeler`.

2. **Crie o Banco de Dados**:  
   - Execute o script correspondente no seu SGBD para criar todas as tabelas e restrições.

3. **Popular o Banco (Opcional)**:  
   - Insira dados de exemplo para testar consultas e operações.

4. **Consultas e Relatórios**:  
   - Realize consultas SQL para extrair informações como vendas por cliente, veículos disponíveis, histórico de vendas, etc.

---

## Exemplos de Consultas

- Listar todos os veículos disponíveis:
  ```sql
  SELECT * FROM ATFTB003_VEICULO WHERE IC_STATUS = 'D';
  ```
