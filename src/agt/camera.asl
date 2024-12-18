pessoa_presente("Jonas").
local("Quarto").

+!verificar_pessoa: pessoa_presente(P) & local("Ausente")
 	<-  .print("Ninguem está em casa").

+!verificar_pessoa: pessoa_presente("Jonas") & local(L)
 	<-  .print("Proprietario está no(a) ", L);
        .send(relogio, achieve, horario_atual).

+!verificar_pessoa: pessoa_presente(P) & local(L)
 	<-  .print("O proprietario não está em casa ").