estoque(5, 5).
requisitos(1, 1).
      
+!consultar_estoque: estoque(A, C)
  <-  .print("Consultar estoque de agua: ", A);
      .print("Consultar estoque de po de café: ", C);
      !consultar_requisitos.

+!atualizar_estoque: estoque(A, C) & requisitos(X, Y)
  <-  -estoque(A, C);
      +estoque(A-X, C-Y);
      .print("Atualizando estoque");
      .print("Quantidade restande de agua: ", (A-X));
      .print("Quantidade restande de cafe: ", (C-Y)).
      
+!consultar_requisitos: requisitos(A, C)
  <-  .print("Quantidade minima de agua: ", A);
      .print("Quantidade minima de cafe: ", C);
      !fazer_cafe.

+!fazer_cafe: estoque(A, C) & requisitos(X, Y) & A>X & C>Y
  <-  .print("Quantidades suficientes");
      .print("Preparando café ...");      
      .wait(1000);
      .print("Café pronto");
      !atualizar_estoque.

+!fazer_cafe: estoque(A, C) & requisitos(X, Y) & A<X
  <-  .print("Quantidade de agua insuficiente").

+!fazer_cafe: estoque(A, C) & requisitos(X, Y) & C<Y
  <-  .print("Quantidade de cafe insuficiente").

+!fazer_cafe: estoque(A, C) & requisitos(X, Y) & A<X & C<Y
  <-  .print("Estoque insuficiente").