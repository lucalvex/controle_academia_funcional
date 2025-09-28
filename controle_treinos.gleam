import gleam/int
import gleam/io
import gleam/list
import gleam/string
import sgleam/check

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

pub fn atualizar_status(treinos: List(Treino)) -> List(Treino) {
  // Atualiza status dos treinos
  // Recebe como entrada uma lista de Treino
  // Se for concluido remove da lista chamanando a funcao remover_concluidos
  // Retorna uma lista de treinos com os status atualizados
  // Utiliza a funcao map para atualizar o status dos treinos
  io.println("Treinos atualizados \n")
  list.map(treinos, fn(treino) {
    case treino.status {
      Pendente -> Treino(..treino, status: EmAndamento)
      EmAndamento -> Treino(..treino, status: Concluido)
      Concluido -> Treino(..treino, status: Concluido)
    }
  })
}

pub fn filtrar_por_status (treinos: List(Treino), status_filtro: Status) -> List(Treino) {
  // Filtrar treinos por status
  // Recebe como entrada uma lista de Treino e status a ser filtrado
  // Retorna uma lista de treinos com o status especificado
  // Utiliza a funcao filter para filtrar os treinos com o status especificado
  list.filter(treinos, fn(treino) { treino.status == status_filtro })
}

pub fn remover_concluidos(treinos: List(Treino)) -> List(Treino) {
  // Remover treinos concluidos
  // Recebe como entrada uma lista de Treino
  // Retorna uma lista de treinos sem os treinos concluidos
  // Utiliza a funcao filter para filtrar os treinos que nao estao concluidos
  list.filter(treinos, fn(treino) { treino.status != Concluido })
}

pub fn visualizar_treinos(treinos: List(Treino)) {
  // Visualiza os treinos
  // Recebe como entrada uma lista de Treino
  // Imprime os detalhes dos treinos na tela
  // Utiliza a funcao each para iterar sobre a lista de treinos
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
  // Conta quantos treinos tem o status especificado
  // Recebe como entrada uma lista de Treino e o status a ser contado
  // Retorna um inteiro com a quantidade de treinos com o status especificado
  // Utiliza a funcao filtrar_por_status para filtrar os treinos com o status especificado
  treinos
  |> filtrar_por_status(status)
  |> list.length()
}

pub fn listar_proximas_data(treinos: List(Treino)) -> List(Treino) {
  // Lista os treinos ordenados por data
  // Recebe como entrada uma lista de Treino
  // Retorna uma lista de treinos ordenados por data
  // Utiliza a funcao sort para ordenar os treinos por data
  list.sort(treinos, fn(a, b) { string.compare(a.data, b.data) })
}

pub fn status_to_string(s: Status) -> String {
  // Converte o status para string
  // Recebe como entrada o Status a ser convertido
  // Retorna uma string com o status
  case s {
    Pendente -> "Pendente"
    EmAndamento -> "Em andamento"
    Concluido -> "Concluído"
  }
}

// Principal
pub fn main() {
  main_example()

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

// Examples
pub fn criar_treino_example() {
  check.eq(
    criar_treino(), 
    [
      Treino(0, "Treino de perna", "Pernas", "11/11/2025", Pendente),
      Treino(0, "Treino de perna", "Pernas", "10/11/2025", EmAndamento)
    ]
  )
}
pub fn adicionar_treino_example() {
  check.eq(
    adicionar_treino(), 
    [
      Treino(0, "Treino de perna", "Pernas", "11/11/2025", Pendente),
      Treino(0, "Treino de perna", "Pernas", "10/11/2025", EmAndamento)
    ]
  )
}
pub fn atualizar_status_example() {
  check.eq(
    atualizar_status(
      [
        Treino(1, "A", "Desc A", "01/01/2024", Pendente),
        Treino(2, "B", "Desc B", "02/01/2024", EmAndamento),
        Treino(3, "C", "Desc C", "03/01/2024", Concluido)
      ]
    ), 
    [
      Treino(1, "A", "Desc A", "01/01/2024", EmAndamento),
      Treino(2, "B", "Desc B", "02/01/2024", Concluido),
      Treino(3, "C", "Desc C", "03/01/2024", Concluido)
    ]
  )
}
pub fn filtrar_por_status_example() {
  check.eq(
    filtrar_por_status(
      [
        Treino(1, "A", "Desc A", "01/01/2024", Concluido),
        Treino(2, "B", "Desc B", "02/01/2024", Pendente)
      ], Concluido
    ), [Treino(1, "A", "Desc A", "01/01/2024", Concluido)]
  )
  check.eq(
    filtrar_por_status(
      [
        Treino(1, "A", "Desc A", "01/01/2024", Concluido),
        Treino(2, "B", "Desc B", "02/01/2024", Pendente)
      ], Pendente
    ), [Treino(2, "B", "Desc B", "02/01/2024", Pendente)]
  )
}
pub fn remover_concluidos_example() {
  check.eq(
    remover_concluidos(
      [
        Treino(1, "A", "Desc A", "01/01/2024", Concluido),
        Treino(2, "B", "Desc B", "02/01/2024", Pendente)
      ]
    ), [Treino(2, "B", "Desc B", "02/01/2024", Pendente)]
  )
}
pub fn contar_por_status_example(){
  check.eq(
    contar_por_status(
      [
        Treino(1, "A", "Desc A", "01/01/2024", Concluido),
        Treino(2, "B", "Desc B", "02/01/2024", Pendente)
      ], Concluido
    ), 1
  )
  check.eq(
    contar_por_status(
      [
        Treino(1, "A", "Desc A", "01/01/2024", Concluido),
        Treino(2, "B", "Desc B", "02/01/2024", Pendente)
      ], Pendente
    ), 1
  )
  check.eq(
    contar_por_status(
      [
        Treino(1, "A", "Desc A", "01/01/2024", EmAndamento),
        Treino(2, "B", "Desc B", "02/01/2024", EmAndamento)
      ], EmAndamento
    ), 2
  )
}
pub fn listar_proximas_data_example() {
  check.eq(
    listar_proximas_data(
      [
        Treino(1, "A", "Desc A", "02/01/2024", EmAndamento),
        Treino(2, "B", "Desc B", "01/01/2024", EmAndamento)
      ],
    ), 
    [
      Treino(2, "B", "Desc B", "01/01/2024", EmAndamento),
      Treino(1, "A", "Desc A", "02/01/2024", EmAndamento)
    ]
  )
}
pub fn status_to_string_example() {
  check.eq(status_to_string(Pendente), "Pendente")
  check.eq(status_to_string(EmAndamento), "Em andamento")
  check.eq(status_to_string(Concluido), "Concluído")
}

pub fn main_example() {
  criar_treino_example()
  adicionar_treino_example()
  atualizar_status_example()
  filtrar_por_status_example()
  remover_concluidos_example()
  contar_por_status_example()
  listar_proximas_data_example()
  status_to_string_example()

  io.println("Todos os testes passaram!")
}
