defmodule ExMon.Game.Actions.Heal do
    alias ExMon.Game
    alias ExMon.Game.Status

    @heal_power 18..25
    
    def heal_life(player) do
        player
        |> Game.fetch_player()
        |> Map.get(:life)
        |> calculate_total_life()
        |> set_life(player)
    end # Função que realiza a cura

    defp calculate_total_life(life), do: Enum.random(@heal_power) + life # Calcula a vida total após a cura

    defp set_life(life, player) when life > 100, do: update_player_life(player, 100) # Garante que a vida não ultrapasse 100
    defp set_life(life, player), do: update_player_life(player, life) # Atualiza a vida do jogador

    defp update_player_life(player, life) do
        player
        |> Game.fetch_player()
        |> Map.put(:life, life)
        |> update_game(player, life)
    end # Atualiza o jogador no estado do jogo

    defp update_game(player_data, player, life) do
        Game.info()
        |> Map.put(player, player_data)
        |> Game.update()

        Status.print_move_message(player, :heal, life)
    end # Atualiza o estado do jogo e imprime a mensagem de cura
end # Módulo de ações de cura do jogo