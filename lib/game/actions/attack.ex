defmodule ExMon.Game.Actions.Attack do
    alias ExMon.Game
    alias ExMon.Game.Status

    @move_avg_power 18..25
    @move_rnd_power 10..35

    def attack_opponent(opponent, move) do
        damage = calculate_power(move)

        opponent
        |> Game.fetch_player()
        |> Map.get(:life)
        |> calculate_total_life(damage)
        |> update_opponent_life(opponent, damage)
    end # Função para definir ataque do jogador

    defp calculate_power(:move_avg), do: Enum.random(@move_avg_power) # Função auxiliar para calcular ataque médio
    defp calculate_power(:move_rnd), do: Enum.random(@move_rnd_power) # Função auxiliar para calcular ataque 

    defp calculate_total_life(life, damage) when life - damage < 0, do: 0 # Calcula a vida total após o ataque, e se for menor que 0, torna 0
    defp calculate_total_life(life, damage), do: life - damage # Calcula a vida depois do ataque

    defp update_opponent_life(life, opponent, damage) do
        opponent
        |> Game.fetch_player()
        |> Map.put(:life, life)
        |> update_game(opponent, damage)
    end # Atualiza a vida do oponente

    defp update_game(player, opponent, damage) do
        Game.info()
        |> Map.put(opponent, player)
        |> Game.update()

        Status.print_move_message(opponent, :attack, damage)
    end # Atualiza o estado do jogo e imprime a mensagem de ataque
end # Módulo de ações de ataque do jogo