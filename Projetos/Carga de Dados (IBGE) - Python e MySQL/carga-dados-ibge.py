import requests # > pip install requests
import pymysql  # > pip install pymysql

def banco(sql):
    conexao = pymysql.connect(
        host='localhost',
        database='dbgeral',
        user='root',
        password='senai@123'
    )
    cursor = conexao.cursor()
    cursor.execute(sql)
    conexao.commit()
    cursor.close()
    conexao.close()

def carga_regiao():
    url = 'https://servicodados.ibge.gov.br/api/v1/localidades/regioes'
    response = requests.get(url)
    lista = response.json()
    i = 0
    while i < len(lista):
        id = lista[i]['id']
        sigla = lista[i]['sigla']
        nome = lista[i]['nome']
        i = i + 1
        banco(f"INSERT INTO regiao (id, sigla, nome) VALUES ('{id}', '{sigla}', '{nome}')")

# carga_regiao()

def carga_estado():
    url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados'
    response = requests.get(url)
    lista = response.json()
    i = 0
    while i < len(lista):
        id = lista[i]['id']
        sigla = lista[i]['sigla']
        nome = lista[i]['nome']
        regiao_id = lista[i]['regiao']['id']
        i = i + 1
        banco(f"INSERT INTO estado (id, sigla, nome, regiao_id) VALUES ('{id}', '{sigla}', '{nome}',{regiao_id})")

#carga_estado()

def carga_municipio():
    url = 'https://servicodados.ibge.gov.br/api/v1/localidades/municipios'
    response = requests.get(url)
    lista = response.json()
    i = 0
    
    while i < len(lista):
        id = lista[i]['id']
        nome = lista[i]['nome']
        try:
            estado_id = lista[i]['microrregiao']['mesorregiao']['UF']['id']
        except Exception as e:
            estado_id = lista[i]['regiao-imediata']['regiao-intermediaria']['UF']['id']
        i = i + 1
        banco(f"INSERT INTO municipio (id, nome, estado_id) VALUES ('{id}', '{nome.replace("'","''")}',{estado_id})")

#carga_municipio()