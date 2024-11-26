// Agent sample_agent in project main

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true
    <- .date(Y,M,D); .time(H,Min,Sec,MilSec); // get current date & time
       +started(Y,M,D,H,Min,Sec).             // add a new belief

{ include("$jacamo/templates/common-cartago.asl") }
{ include("$jacamo/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moise/asl/org-obedient.asl") }

// // Crenças iniciais
// // Lista de tarefas pendentes e capacidade do agente
// +task("limpar casa").
// +task("fazer compras").
// +task("estudar Jason").
// +max_capacity(2). // Máximo de tarefas que o agente pode executar no momento

// // Regra: Condição para definir que o agente está ocupado
// busy :- .count(task(_), X) & max_capacity(Y) & X >= Y.

// // Plano para iniciar o dia
// +!iniciar : not busy <- 
//     .print("Iniciando o dia e analisando tarefas...");
//     !executar_tarefas.

// // Plano para executar tarefas enquanto não estiver ocupado
// +!executar_tarefas : not busy & task(T) <- 
//     .print("Executando tarefa:", T);
//     -task(T); // Remove a tarefa da lista
//     !executar_tarefas. // Continua com a próxima tarefa

// // Plano alternativo para quando o agente está ocupado
// +!executar_tarefas : busy <- 
//     .print("Muitas tarefas. Preciso priorizar ou delegar.");
//     !priorizar_tarefas.

// // Plano para priorizar tarefas
// +!priorizar_tarefas <- 
//     .print("Reorganizando tarefas...");
//     +task("descansar"); // Adiciona uma tarefa para gerenciar o tempo
//     .print("Tarefas priorizadas:", .myBeliefs).

// // Evento para quando uma nova tarefa é adicionada
// +task(NewTask) <- 
//     .print("Nova tarefa adicionada:", NewTask).

+!iniciar
    <- .send(remetente, destinatario).