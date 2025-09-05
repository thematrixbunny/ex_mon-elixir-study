defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.{Attack, Heal}

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computer -> Attack.attack_opponent(:player, move)
    end
  end # Função que realiza o ataque

  def heal() do
    case Game.turn() do
      :player -> Heal.heal_life(:player)
      :computer -> Heal.heal_life(:computer)
    end
  end # Função que realiza a cura

  def fetch_move(move) do
    Game.player()
    |> Map.get(:moves)
    |> find_move(move)
  end # Função que busca o movimento do jogador

  defp find_move(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {key, value} -> 
      if value == move, do: {:ok, key} 
    end)
  end # Função que encontra o movimento na lista de movimentos do jogador
end # Módulo de ações do jogo
