/* Initial beliefs and rules */

temperatura_de_preferencia(jonas,25).

/* Initial goals */

!inicializar_AC.

+!inicializar_AC
  <- 	makeArtifact("ac_quarto","artifacts.ArCondicionado",[],D);
  	   	focus(D);
  	   	!definir_temperatura;
  	   	!!climatizar.

+alterado : temperatura_ambiente(TA) & temperatura_ac(TAC)
  <-  .drop_intention(climatizar);
  	  .print("Houve interação com o ar condicionado!");
  	  .print("Temperatura Ambiente: ", TA);
 	  .print("Temperatura Desejada: ", TAC);
  	  !!climatizar.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) 
 			& temperatura_de_preferencia(User,TP) & TP \== TD & ligado(false)
 	<-  definir_temperatura(TP);
 		.print("Definindo temperatura baseado na preferência do usuário ", User);
 		.print("Temperatura: ", TP).
 	
 +!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) & ligado(false)
 	<-  .print("Usando última temperatura");
 		.print("Temperatura: ", TAC).
 		
 		
 //situação em que a temperatura ambiente (TA) é diferente da temperatura do ar condicionado
 //(TAC) e o ar condicionado está desligado
 +!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA \== TAC & ligado(false)
 	<-   ligar;
 		.print("Ligando ar condicionado...");
 		.print("Temperatura Ambiente: ", TA);
 		.print("Temperatura Desejada: ", TAC);
 		.wait(1000);
 		!!climatizar.
 		
// situação em que o ar condicionado está ligado e as temperaturas ainda não
// foram igualadas (TA == TAC)
 +!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA \== TAC & ligado(true) 
 	<-  .print("Aguardando regular a temperatura de ", TA, " para ", TAC, "...");
 		.wait(4000);
 		!!climatizar.
 		 	
// temperatura ambiente já está igual à temperatura do ar condicionado (TA == TAC) e o ar
// condicionado está ligado
  +!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA == TAC & ligado(true) 
 	<-   desligar;
 		.print("Desligando ar condicionado...");
 		.print("Temperatura Ambiente: ", TA);
 		.print("Temperatura Desejada: ", TAC).

 +!climatizar 
 	<- 	.print("Não foram implementadas outras opções.");
 		.print("Temperatura regulada.").

+auto_climatizar(P): temperatura_ambiente(TA) & temperatura_de_preferencia(_, TP) & TA \== TP & ligado(false)
	<- ligar;
	.print(P, " está em casa, climatizando o ambiente.");
	.wait(1);
 	!!climatizar.