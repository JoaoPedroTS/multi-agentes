
!inicializar_cafeteira.

+!inicializar_cafeteira
  <-  makeArtifact("cafeteira","artifacts.Cafeteira",[],D);
      focus(D).
      !ligar_cafeteira.

+interuptor
  <- !!verificar_cafeteira.

+bip <- .print("cafeteira bipou").
      
+cafe_pronto 
  <-  .print("Café pronto! Aproveite!").

+!ligar_cafeteira
  <- .print("Cafeteira ligada").

+!verificar_cafeteira: ligada(true)
  <- .print("Alguem desligou a cafeteira").
      
// +!preparar_cafe: ligada & agua_disponivel & cafe_disponivel
//   <-  .print("Iniciando o preparo do café...");
//       .send(cafeteira, achieve, iniciar_preparo);
//       .wait(5000);  % Aguarda 5 segundos simulando o preparo
//       !!finalizar_preparo.

// +!preparar_cafe: not ligada
//   <-  .print("A cafeteira está desligada. Por favor, ligue-a antes de preparar o café.").

// +!preparar_cafe: not agua_disponivel
//   <-  .print("Não há água suficiente para preparar o café. Reabasteça.").

// +!preparar_cafe: not cafe_disponivel
//   <-  .print("Não há pó de café disponível. Por favor, adicione mais.").

// +!finalizar_preparo
//   <-  .print("O preparo do café foi concluído.");
//       .send(cafeteira, tell, parar_preparo);
//       !!notificar_usuario.

// +!notificar_usuario
//   <-  .send(interface, tell, cafe_pronto).