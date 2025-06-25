# CRUD To-Do List Flask + PostgreSQL

## Sobre o Projeto

Este projeto é um sistema web de **Lista de Afazeres (To-Do List)**, desenvolvido em Python com Flask e utilizando PostgreSQL hospedado no Render como banco de dados. O sistema permite cadastrar, listar, editar e remover tarefas, com interface web responsiva e API RESTful.

---

## :star: Funcionalidades

- Adicionar novos itens à lista de tarefas
- Visualizar todos os itens cadastrados
- Editar itens existentes (alterar descrição e status)
- Remover itens da lista
- Interface web responsiva (Bootstrap)
- API RESTful para integração com outros sistemas

---

## :hammer_and_wrench: Tecnologias Utilizadas

- **Python 3**
- **Flask** (backend web)
- **PostgreSQL** (banco de dados relacional)
- **psycopg2** (driver PostgreSQL para Python)
- **Bootstrap 5** (frontend)
- **Render** (hospedagem do banco de dados PostgreSQL)
- **python-dotenv** (variáveis de ambiente)

---

## :open_file_folder: Estrutura do Projeto

```plaintext
CRUD-ToDoList/
├── app.py                  # Código principal Flask
├── db.sql                  # Script de criação da tabela no PostgreSQL
├── requirements.txt        # Dependências do projeto
├── .env.example            # Exemplo de variáveis de ambiente
├── comandos.sh             # Exemplos de comandos curl para testar a API
├── static/
│   └── script.js           # Lógica JS para interação frontend
├── templates/
│   └── index.html          # Página principal da aplicação
└── readme.md               # Este arquivo de documentação
```

---

## :gear: Configuração do Ambiente

1. **Clone o repositório**

    ```bash
    git clone <url-do-repositorio>
    cd CRUD-ToDoList
    ```

2. **Crie um arquivo `.env` na raiz do projeto, baseado no `.env.example`:**

    ```env
    DB_HOST=seu_host
    DB_PORT=5432
    DB_NAME=seu_banco
    DB_USER=seu_usuario
    DB_PASSWORD=sua_senha
    ```

3. **Instale as dependências**

    ```bash
    pip install -r requirements.txt
    ```

4. **Configure o banco de dados**
    - Execute o script `db.sql` no seu banco PostgreSQL para criar a tabela.

5. **Execute a aplicação**

    ```bash
    python app.py
    ```

---

## :link: Endpoints da API

- **GET `/item`**  
  Lista todos os itens da lista.

- **POST `/item`**  
  Adiciona um novo item.  
  **Exemplo de payload:**

  ```json
  {
     "item": "Comprar pão",
     "status": "Em Fila"
  }
  ```

- **PATCH `/item/{lineNumber}`**  
  Atualiza um item existente.

- **DELETE `/item/{lineNumber}`**  
  Remove um item da lista.

---

## :computer: Exemplos de Uso via cURL

```bash
# Adicionar item
curl -X POST http://127.0.0.1:5000/item -H "Content-Type: application/json" -d '{"item":"Comprar", "status":"Em Fila"}'

# Listar itens
curl -X GET http://127.0.0.1:5000/item

# Atualizar item
curl -X PATCH http://127.0.0.1:5000/item/1 -H "Content-Type: application/json" -d '{"item":"Estudar", "status":"Iniciado"}'

# Remover item
curl -X DELETE http://127.0.0.1:5000/item/1
```

---

> Projeto desenvolvido para fins educacionais no **SENAI**.
