defmodule ExMon do
  alias ExMon.{Player, Game}
  alias ExMon.Game.{Actions,Status}

  @computer_name "Enemy"
  @computer_moves [:move_avg, :move_rnd, :move_heal]

  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.build(name, move_rnd, move_avg, move_heal)
  end # Função que cria o jogador

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message(Game.info())
  end # Função que inicia o jogo

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end # Função que realiza a jogada

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info()) # Se o jogo acabar, imprime a mensagem de fim de jogo

  defp handle_status(_other, move) do 
    move
    |> Actions.fetch_move()
    |> do_move()

    computer_move(Game.info())
  end # Função que lida com o status do jogo

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move) # Se o movimento for inválido, imprime a mensagem de erro

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end # Realiza a ação de ataque ou cura

    Status.print_round_message(Game.info())
  end # Função que executa o movimento

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computer_moves)}
    do_move(move)
  end # Função que realiza o movimento do computador
  
  defp computer_move(_), do: :ok
end # Módulo principal do jogo


# player = ExMon.create_player("Juseh", :chute, :soco, :cura)