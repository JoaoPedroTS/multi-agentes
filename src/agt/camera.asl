// Objetivo
// ! indica um objetico que o agente deseja alcançar
!inicializar_camera.

+!inicializar_camera
  <- 	makeArtifact("camera_quarto","artifacts.Camera",[],D);
  	   	focus(D).
  	   	
+movimento 
  <-  !!verificar_pessoa.
      
+closed  <-  .print("Close event from GUIInterface").

+!verificar_pessoa: pessoa_presente("Jonas") & local("entrada")
 	<-  .print("Proprietario reconhecida no local entrada");
  !!liberar_acesso(P,L).

+!verificar_pessoa: pessoa_presente(P) & local("saida")
 	<-  .print("Pessoa: ", P, " reconhecida no local saída");
  !!saida(P,L).

+!verificar_pessoa <- .print("Ultimo plano").
   
+!liberar_acesso(P,L): acessou_entrada(P, L) 
  <- .send(fechadura, achieve, destrancar_porta);
  .send(ar_condicionado, tell, auto_climatizar(P));
  .send(cortina, achieve, ajustar_abertura(P));
  .send(lampada, achieve, ligar_lampada).

+!saida(P,L): acessou_saida(P,L)
  <- .print(P, " saiu de casa");
      .send(fechadura, achieve, fechar_porta);
      .send(cortina, achieve, fechar_cortinas);
      .send(lampada, achieve, desligar_lampada).