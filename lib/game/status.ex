defmodule ExMon.Game.Status do

  def print_round_message(%{status: :started} = info) do
    IO.puts("\n===== The game is started! =====\n")
    IO.inspect(info)
    IO.puts("--------------------------------")
  end # Função que imprime a mensagem de início do jogo

  def print_round_message(%{status: :continue, turn: player} = info ) do
    IO.puts("\n===== It's #{player} turn. =====\n")
    IO.inspect(info)
    IO.puts("--------------------------------")
  end # Função que imprime a mensagem de continuação do jogo

  def print_round_message(%{status: :game_over} = info) do
    IO.puts("\n===== The game is over. =====\n")
    IO.inspect(info)
    IO.puts("--------------------------------")
  end # Função que imprime a mensagem de fim do jogo

  def print_wrong_move_message(move) do
    IO.puts("\n===== Invalid move: #{move} =====\n")
  end  # Função que imprime a mensagem de movimento inválido

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n===== The Player attacked the computer dealing #{damage} damage. =====\n")
  end # Função que imprime a mensagem de ataque ou cura

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n===== The Computer attacked the player dealing #{damage} damage. =====\n")
  end # Função que imprime a mensagem de ataque ou cura

  def print_move_message(player, :heal, life) do
    IO.puts("\n===== The #{player} healed itself to #{life} life points. =====\n")
  end # Função que imprime a mensagem de ataque ou cura
end # Módulo de status do jogo
