import mysql.connector #>pip install mysql-connector-python

def banco(sql):
    conexao = mysql.connector.connect(
        host='localhost',
        database='espetaria',
        user='root',
        password='senai@123'
    )
    cursor = conexao.cursor()
    cursor.execute(sql)
    conexao.commit()
    cursor.close()
    conexao.close()
    
banco("insert into produto(nome, descricao, preco) values('','',0)")

# print('Olá Mundo')