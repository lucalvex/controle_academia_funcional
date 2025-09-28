import gleam/int
import gleam/io
import gleam/list
import gleam/string

// Modelagens com ADTs (Algebraic Data Types)
pub type Treino {
  Treino(
    id: Int,
    titulo: String,
    descricao: String,
    data: String,
    status: Status,
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
  let treino1 = Treino(0, "Treino de perna", "Pernas", "11/11/2025", Pendente)
  let treino2 = Treino(0, "Treino de perna", "Pernas", "10/11/2025", EmAndamento)
  let treinos = [treino1, treino2]
  treinos
}

pub fn adicionar_treino() -> List(Treino) {
  // Essa função chama o criar_treino e retorna uma lista de treinos
  let treinos = criar_treino()
  treinos
}

// Atualiza status dos treinos
// Se for concluido remove da lista chamanando a funcao remover_concluidos
pub fn atualizar_status(treinos: List(Treino)) -> List(Treino) {
  io.println("Treinos atualizados \n")
  list.map(treinos, fn(treino) {
    case treino.status {
      Pendente -> Treino(..treino, status: EmAndamento)
      EmAndamento -> Treino(..treino, status: Concluido)
      Concluido -> Treino(..treino, status: Concluido)
    }
  })
}

pub fn filtrar_por_status (
  treinos: List(Treino),
  status_filtro: Status,
) -> List(Treino) {
  list.filter(treinos, fn(treino) { treino.status == status_filtro })
}

// Remover treinos concluidos

pub fn remover_concluidos(treinos: List(Treino)) -> List(Treino) {
  list.filter(treinos, fn(treino) { treino.status != Concluido })
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
pub fn contar_por_status(treinos: List(Treino), status: Status) -> Int {
  treinos
  |> filtrar_por_status(status)
  |> list.length()
}

pub fn listar_proximas_data(treinos: List(Treino)) -> List(Treino) {
  list.sort(treinos, fn(a, b) { string.compare(a.data, b.data) })
}

pub fn status_to_string(s: Status) -> String {
  case s {
    Pendente -> "Pendente"
    EmAndamento -> "Em andamento"
    Concluido -> "Concluído"
  }
}

// Principal
pub fn main() {
  io.println("Bem-vindo à academia Treinos Gleam")
  io.println("Iremos criar seu treino, só um minuto...\n")

  // Criando treinos
  let treinos1 = adicionar_treino()

  // Vizualizacao
  io.println("Seu treino foi criado com sucesso!")
  io.println("Seus treinos estão ordenados pro data:\n")
  let prox_treino = listar_proximas_data(treinos1)
  visualizar_treinos(prox_treino)

  // Atualização
  let treinos1 = atualizar_status(treinos1)
  io.println("Seus treinos foram atualizados com sucesso!\n")
  visualizar_treinos(treinos1)
  
  let treinos_concluidos = filtrar_por_status(treinos1, Concluido)
  // Remover treinos concluidos
  case treinos_concluidos  {
    [] -> io.println("Nenhum treino concluído.\n")
    _ -> {
      let treinos1 = remover_concluidos(treinos1)
      io.println("Treinos concluídos removidos da lista.\n")
      visualizar_treinos(treinos1)
      let count_concluidos = contar_por_status(treinos_concluidos, Concluido)
      io.println("Total de treinos concluídos: " <> int.to_string(count_concluidos) <> "\n")
    }
  }

  
}
