configuracao_proprietario(50).

//!inicializar_cortina.

+!inicializar_cortina
  <- 	makeArtifact("cortina_quarto","artifacts.Cortina",[],D);
  	   	focus(D).
  	   	//!abrir_cortina.
  	   	
+ajuste_cortina 
  <-  !!verificar_ajuste.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!verificar_ajuste: nivel_abertura(N) 
 	<-  .print("Nível de abertura da cortina: ", N).
 	
+!abrir_cortina: nivel_abertura(N) & configuracao_proprietario(PN) & N \== PN
 	<- 	abrir;
 		+nivel_abertura(PN);
 		.print("Nivel de abertura DEPOIS ", PN).

+!ajustar_abertura(P): configuracao_proprietario(PN) 
 	<-  abrir;
      	.print(P, " está em casa, ajustando cortinas para nível ", PN);
      	!abrir_cortina.

+!fechar_cortinas
	<- 	fechar;
		+nivel_abertura(0);
		.print("Fechei as cortinas.").