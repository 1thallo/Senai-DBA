 --   >>>>>>>>>>>>>>>>>    JOIN  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- 11 Mostre o nome do jogador e o nome do time onde ele joga.
 select TJ.NO_JOGADOR as "Nome do jogador", TT.NO_TIME as "Nome do time"
 from snitb003_jogador TJ
 inner join snitb002_time TT on TT.id_time = TJ.id_time;
 
-- 12 Liste as partidas com o nome do time mandante e visitante.
 select TT.NO_TIME as "Time Mandante", TT2.NO_TIME as "Time Visitante", TP.nr_rodada, TP.nr_gol_mandante "Gol(s) do time mandannte", TP.nr_gol_visitante as "Gol(s) do time visitante"
 from snitb004_partida TP
 inner join snitb002_time TT on TT.ID_TIME = TP.id_mandante
 inner join snitb002_time TT2 on TT2.ID_TIME = TP.id_visitante;

-- 13 Exiba o nome do estádio e o nome dos times que têm esse estádio como casa.
select TE.NO_ESTADIO as "Nome do estádio", TT.NO_TIME as "Nome do time"
from snitb002_time TT
inner join snitb001_estadio TE on TE.ID_ESTADIO = TT.ID_ESTADIO;

-- 14 Mostre os eventos das partidas junto com o nome do jogador responsável.
select TEV.DS_EVENTO as "Evento", TJ.no_JOGADOR as "Jogador", TT.no_time as "Nome do time", TP.nr_rodada "Rodada", TE.no_estadio as "Estadio" 
from snitb005_evento TEV
inner join snitb003_jogador TJ on TJ.id_jogador = TEV.id_jogador
inner join snitb004_partida tp on tp.id_partida = tev.id_partida
inner join snitb001_estadio te on te.id_estadio = tp.id_estadio
inner join snitb002_time tt on tt.id_time = tp.id_mandante
order by tp.nr_rodada;


-- 15 Liste o nome das cidades e os estádios que estão localizados nelas.
select tt.no_cidade_time as Cidade, te.no_estadio  as "Nome do estadio"
from  snitb002_time tt
inner join snitb001_estadio te on te.id_estadio = tt.id_estadio
order by tt.no_cidade_time;

-- 16 Mostre os nomes dos jogadores e os estádios onde ocorreram partidas que eles participaram (via evento).
select sj.no_jogador as "Nome do jogador", se2.no_estadio as "Nome do estadio"
from snitb005_evento se 
inner join snitb003_jogador sj on sj.id_jogador = se.id_jogador
inner join snitb004_partida sp on sp.id_partida = se.id_partida
inner join snitb001_estadio se2 on se2.id_estadio  = sp.id_estadio;


-- 17 Exiba o nome do time, nome do estádio, e cidade onde está localizado o time.
select st.no_time as "Nome do time", se.no_estadio as Estadio, st.no_cidade_time as "Cidade do time"
from snitb002_time st
inner join snitb001_estadio se on se.id_estadio = st.id_estadio;

-- >>>>>>>>>>>>>  Agregação  <<<<<<<<<<<<<<<<<<<<<<<
-- 18 Conte quantos jogadores cada time possui.
select count(sj.id_jogador ), st.no_time
from snitb003_jogador sj
inner join snitb002_time st on st.id_time = sj.id_time
group by st.no_time;

-- 19 Calcule a média de gols marcados por time mandante.
select round(avg(nr_gol_mandante),2) as "Média de Gols (Mandante) por Partida"
from snitb004_partida;

-- 20 Mostre o total de partidas jogadas em cada estádio.
select count(sp.id_partida ) as "Partidas Jogadas", se.no_estadio as "Estádio"
from snitb004_partida sp
inner join snitb001_estadio se on se.id_estadio = sp.id_estadio
group by se.no_estadio;