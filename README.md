# 📌 Projeto: Controle de Treinos em Gleam

Este projeto foi desenvolvido como parte do trabalho da disciplina de **Programação Funcional**, utilizando a linguagem **Gleam**.

O objetivo é implementar um sistema simples de **controle de treinos** (sessões de exercício), aplicando os conceitos de **tipos algébricos de dados (ADTs)**, **listas imutáveis** e **pattern matching**.

---

## 🔹 Funcionalidades Implementadas

### Modelagem com ADTs
- **Tipo principal**: `Treino`
  - `id: Int`
  - `titulo: String`
  - `descricao: String`
  - `data: String`
  - `status: Status`

- **Tipo soma**: `Status`
  - `Pendente`
  - `EmAndamento`
  - `Concluido`

### Operações básicas
- `criar_treino` → Cria um treino válido.
- `adicionar_treino` → Adiciona um treino a uma lista imutável.
- `atualizar_status` → Atualiza o status de um treino pelo `id`.
- `filtrar_por_status` → Filtra os treinos com determinado status.
- `remover_concluidos` → Remove treinos concluídos da lista.

### Operações derivadas
- `contar_por_status` → Conta quantos treinos existem em cada status.
- `percentual_concluidos` → Calcula a porcentagem de treinos concluídos.
- *(extra)* `listar_proximas_datas` → Lista os treinos em ordem de data.

---

## 🔹 Estrutura do Projeto
