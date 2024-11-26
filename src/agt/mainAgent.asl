!inicializar_ambiente.

+!inicializar_ambiente
    <- .print("Iniciando o ajuste do ambiente ...");
    !!inicializar_camera;
    !!inicializar_fechadura;
    !!inicializar_AC;
    !!inicializar_lampada;
    !!inicializar_cortina.

+ajustar_ambiente
  <- .print("Ajustando o ambiente...");
     !!inicializar_AC;
     !!inicializar_lampada;
     !!inicializar_cortina.