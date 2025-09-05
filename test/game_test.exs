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
              player: %Player{name: "Lucas", life: 100, moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}},
              computer: %Player{name: "Enemy", life: 100, moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}},
              turn: :player
            }

        assert expected_response == Game.info()
      end
    end

    describe "update/1" do
      test "returns the game state updated"
    end
end
