defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Player, Game}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Lucas", :chute, :soco, :cura)
      computer = Player.build("Enemy", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Lucas", :chute, :soco, :cura)
      computer = Player.build("Enemy", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        status: :started,
        player: %Player{
          name: "Lucas",
          life: 100,
          moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}
        },
        computer: %Player{
          name: "Enemy",
          life: 100,
          moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}
        },
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Lucas", :chute, :soco, :cura)
      computer = Player.build("Enemy", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        status: :started,
        player: %Player{
          name: "Lucas",
          life: 100,
          moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}
        },
        computer: %Player{
          name: "Enemy",
          life: 100,
          moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}
        },
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        status: :started,
        player: %Player{
          name: "Lucas",
          life: 85,
          moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}
        },
        computer: %Player{
          name: "Enemy",
          life: 50,
          moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}
        },
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns the player info" do
      player = Player.build("Lucas", :chute, :soco, :cura)
      computer = Player.build("Enemy", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %Player{
        name: "Lucas",
        life: 100,
        moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}
      }

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the current turn" do
      player = Player.build("Lucas", :chute, :soco, :cura)
      computer = Player.build("Enemy", :chute, :soco, :cura)

      Game.start(computer, player)

      assert :player == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "returns the player info" do
      player = Player.build("Lucas", :chute, :soco, :cura)
      computer = Player.build("Enemy", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %Player{
        name: "Lucas",
        life: 100,
        moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}
      }

      assert expected_response == Game.fetch_player(:player)
      assert expected_response != Game.fetch_player(:computer)
    end
  end
end
