defmodule ExMon.Game do
  alias ExMon.Player

  use Agent

  def start(computer, player) do
    initial_value = %{computer: computer, player: player, turn: :player, status: :started}
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end # Função para iniciar o jogo

  def info do
    Agent.get(__MODULE__, & &1)
  end # Função para exibir informações do jogo e players

  def update(state) do
    Agent.update(__MODULE__, fn _ -> update_game_status(state) end)
  end # Função para atualizar o status do jogo

  def player, do: Map.get(info(), :player) # Funções auxiliares para info e update
  def turn, do: Map.get(info(), :turn) # Funções auxiliares para info e update
  def fetch_player(player), do: Map.get(info(), player) # Busca info do jogador

  defp update_game_status(%{player: %Player{life: player_life}, computer: %Player{life: computer_life}} = state)
    when player_life == 0 or computer_life == 0, 
    do: Map.put(state, :status, :game_over)

  defp update_game_status(state) do
    state
    |> Map.put(:status, :continue)
    |> update_turn()
  end # Função para atualizar o status do jogo

  defp update_turn(%{turn: :player} = state), do: Map.put(state, :turn, :computer)
  defp update_turn(%{turn: :computer} = state), do: Map.put(state, :turn, :player)

end # Módulo do jogo