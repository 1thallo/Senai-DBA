# DB_CampeonatoBrasileiro

Este repositório contém os arquivos e scripts relacionados ao projeto de criação de uma base de dados para armazenar informações sobre o Campeonato Brasileiro. O projeto foi desenvolvido com base nos seguintes requisitos:

## Requisitos do Sistema

1. **Estádios**:  
    - Cadastro de estádios brasileiros com informações como nome, endereço e capacidade.

2. **Times**:  
    - Cadastro de times com dados como nome, cidade, estado, estádio e outras informações relevantes.

3. **Jogadores**:  
    - Cadastro de jogadores associados aos seus respectivos times, incluindo informações como nome, data de nascimento, posição e número da camisa.

4. **Partidas**:  
    - Registro de partidas entre os times, contendo informações sobre a rodada do campeonato, data, local (estádio), horário, resultado, time mandante e time visitante.

5. **Eventos**:  
    - Registro de eventos ocorridos nas partidas, como gols, cartões amarelos e vermelhos, com detalhes como jogador, partida, minuto do evento, entre outros.

---

## Estrutura do Projeto

O projeto foi dividido em três etapas principais, com os seguintes arquivos:

1. **Modelo Conceitual**:  
    - Criado no brModelo.  
    - Arquivo disponível no formato `.brM` e `.pdf`.

2. **Modelo Lógico**:  
    - Desenvolvido no MySQL Workbench.  
    - Arquivol disponível no formato `.pdf`.

3. **Modelo Físico**:  
    - Script DDL contendo a criação da base de dados, tabelas e relacionamentos.  
    - Arquivo disponível no formato `.sql`.

---

## Como Utilizar

1. **Modelo Conceitual**:  
    - Abra o arquivo `.brM` no brModelo para visualizar o diagrama conceitual.  
    - O arquivo `.pdf` pode ser usado para uma visualização rápida.

2. **Modelo Lógico**:  
    - O arquivo `.pdf` contém uma imagem do modelo lógico.

3. **Modelo Físico**:  
    - Execute o script `.sql` em um servidor MySQL para criar a base de dados e suas tabelas.

---

## Tecnologias Utilizadas

- **brModelo**: Para a criação do modelo conceitual.  
- **MySQL Workbench**: Para o desenvolvimento do modelo lógico.  
- **MySQL**: Para a implementação do modelo físico.


