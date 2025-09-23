import gleam/io
import gleam/list
import gleam/int

// Modelagens com ADTs (Algebraic Data Types)
pub type Treino {
  Treino (
    id: Int,
    titulo: String,
    descricao: String,
    data: String,
    status: Status
  )
}

pub type Status {
  Pendente
  EmAndamento
  Concluido
}

// Operações minimas 
pub fn criar_treino() -> List(Treino) {
  // Essa função cria os treinos individualmente e adiciona ao uma lista de treinos 
  // A função retorna uma lista de treinos
  let treino1 = Treino (
    0,
    "Treino de perna",
    "Pernas",
    "10/10/2025",
    Pendente
  )

  let treino2 = Treino (
    1,
    "Treino de braço",
    "Braço",
    "11/10/2025",
    EmAndamento
  )

  let treinos = [treino1, treino2]
  treinos
}

pub fn adicionar_treino() -> List(Treino) {
  // Essa função chama o criar_treino e retorna uma lista de treinos
  let treinos = criar_treino()
  treinos
}

pub fn atualizar_status(treinos: List(Treino)) -> List(Treino){
  io.println("Treinos atualizados \n")
  list.map(treinos, fn(treino) {
    case treino.status {
      Pendente -> Treino(..treino, status: EmAndamento)
      EmAndamento -> Treino(..treino, status: Concluido)
      Concluido -> remover_concluidos(treinos, treino.id)
    }
  })
}

pub fn filtrar_por_status(){}

pub fn remover_concluidos(treinos: List(Treino), idtreino: Int) -> List(Treino) {
  list.filter(treinos, fn(treino) {
    treino.id != idtreino
  })
}

pub fn visualizar_treinos(treinos: List(Treino)) {
  io.println("------ Lista de treinos --------\n")
  list.each(treinos, fn(treino) {
    case treino {
      Treino(id, titulo, descricao, data, status) -> {
        io.println("ID: " <> int.to_string(id))
        io.println("Título: " <> titulo)
        io.println("Descrição: " <> descricao)
        io.println("Data: " <> data)
        io.println("Status: " <> status_to_string(status))
        io.println("--------------------\n")
      }
    }
  })
}

// Operações derivadas
pub fn contar_por_status(){}

pub fn listar_proximas_data(){}

pub fn status_to_string(s: Status) -> String {
  case s {
    Pendente -> "Pendente"
    EmAndamento -> "Em andamento"
    Concluido -> "Concluído"
  }
}

// Principal
pub fn main(){
  io.println("Bem-vindo à academia Treinos Gleam")
  io.println("Iremos criar seu treino, só um minuto...\n")

  // Criando treinos
  let treinos1 = adicionar_treino()

  // Vizualizacao
  io.println("Seu treino foi criado com sucesso!")
  visualizar_treinos(treinos1)

  // Atualização
  let treinos1 = atualizar_status(treinos1)
  visualizar_treinos(treinos1)
}




