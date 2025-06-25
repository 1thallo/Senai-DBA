from flask import Flask, request, render_template
import psycopg2, json
from dotenv import load_dotenv
import os

load_dotenv()  # Carrega as variáveis do .env

app = Flask(__name__)

@app.route('/')
def home():
    return render_template("index.html")

@app.route('/item', methods=['POST'])
def post_item():
    data = request.get_json()
    sql = f"INSERT INTO todolist(item, status) VALUES('{data['item']}','{data['status']}') RETURNING \"_lineNumber\""
    lineNumber = banco(sql)
    data["_lineNumber"] = lineNumber
    return data

@app.route('/item', methods=['GET'])
def get_item():
    sql = "SELECT * FROM todolist ORDER BY 1"
    return banco(sql)

@app.route('/item/<int:lineNumber>', methods=['PATCH'])
def patch_item(lineNumber):
    data = request.get_json()
    sql = f"UPDATE todolist SET item = '{data['item']}', status = '{data['status']}' WHERE \"_lineNumber\" = {lineNumber}"
    banco(sql)
    return data

@app.route('/item/<int:lineNumber>', methods=['DELETE'])
def delete_item(lineNumber):
    sql = f"DELETE FROM todolist WHERE \"_lineNumber\" = {lineNumber}"
    banco(sql)
    return ""

@app.route('/login/<string:login>/<string:senha>', methods=['GET'])
def get_login(login,senha):
    sql = f"SELECT COUNT(*) ACESSO FROM usuario WHERE login = '{login}' AND senha = '{senha}';"
    print(sql)
    return banco(sql)

def banco(sql):
    resultado = ""
    try:
        conn = psycopg2.connect(
            host = os.getenv("DB_HOST"),
            port = os.getenv("DB_PORT"),
            dbname = os.getenv("DB_NAME"),
            user = os.getenv("DB_USER"),
            password = os.getenv("DB_PASSWORD")
        )
        cursor = conn.cursor()
        cursor.execute(sql)
        if sql[0:6] == "INSERT":
            resultado = cursor.fetchone()[0]
        elif sql[0:6] == "SELECT":
            resultado = cursor.fetchall()
            colunas = [desc[0] for desc in cursor.description]
            resultado = json.dumps([dict(zip(colunas, row)) for row in resultado])
            resultado = json.loads(resultado)
        cursor.close()
        conn.commit()
        conn.close()
    except psycopg2.Error as e:
        print("Erro na conexão do banco de dados:", e)
    return resultado


if __name__ == '__main__':
    app.run(debug=True)

