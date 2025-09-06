defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "Lucas",
      }

      assert expected_response == ExMon.create_player("Lucas", :punch, :kick, :heal)
    end
  end

  describe "start_game/1" do
    test "prints the game start message" do
      player = Player.build("Lucas", :chute, :soco, :cura)

      messages =
      capture_io(fn ->
        assert ExMon.start_game(player) == :ok
      end)

      assert messages =~ "The game is started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Lucas", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)
      # {:ok, player: player}
      :ok
    end

    test "when the move is valid, do the move and the cmputer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "The Player attacked the computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "Invalid move: wrong"
    end
  end

  # Criar os testes dos módulos remanescentes
  describe "game_over" do
    setup do
      player = Player.build("Lucas", :chute, :soco, :cura)
      capture_io(fn -> ExMon.start_game(player) end)
      :ok
    end

    test "prints the game over message when a player loses all life" do
      # Simula movimentos até o jogo acabar
      # Forçando a vida do computador chegar a zero
      ExMon.Game.info()
      |> Map.update!(:computer, fn comp -> %{comp | life: 0} end)
      |> ExMon.Game.update()

      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "status: :game_over"
      assert messages =~ "The game is over"
    end
  end # Teste de game_over
end
