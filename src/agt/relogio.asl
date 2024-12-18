horario("6:00").
horario_programaado("6:00").

+!horario_atual: horario(H)
    <- .print("Horario atual: ", H);
        !horario_programado_cafe.

+!horario_programado_cafe: horario(H) & horario_programaado(HP) & (H == HP)
    <-  .print("Horario de fazer cafe");
        .send(cafeteira, achieve, consultar_estoque).

+!horario_programado_cafe: horario(H) & horario_programaado(HP) & (H \== HP)
    <-  .print("Ainda não está na hora do cafe").