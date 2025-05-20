/*
03. function signo
Implemente uma função no MySQL chamada signo que receba como entrada uma data do tipo DATE e retorne o signo do zodíaco correspondente àquela data.

Requisitos:

A função deve ser determinística.
Utilize a função interna DATE_FORMAT para extrair o mês e o dia da data, no formato MMDD, para facilitar as comparações.
O retorno deve ser uma string do tipo VARCHAR(20) contendo o nome do signo em português.
Considere as seguintes faixas de datas para cada signo:
Áries: 21/03 a 19/04
Touro: 20/04 a 20/05
Gêmeos: 21/05 a 20/06
Câncer: 21/06 a 22/07
Leão: 23/07 a 22/08
Virgem: 23/08 a 22/09
Libra: 23/09 a 22/10
Escorpião: 23/10 a 21/11
Sagitário: 22/11 a 21/12
Capricórnio: 22/12 a 19/01
Aquário: 20/01 a 18/02
Peixes: 19/02 a 20/03
select signo('2024-04-01');
select signo('2024-05-01');
select signo('2024-06-01');
select signo('2024-07-01');
select signo('2024-08-01');
select signo('2024-09-01');
select signo('2024-10-01');
select signo('2024-11-01');
select signo('2024-12-01');
select signo('2024-01-01');
select signo('2024-02-01');
select signo('2024-03-01');
/*

