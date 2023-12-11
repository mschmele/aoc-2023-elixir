defmodule Cubes do
  def parse_single_game(game) do
    game
    |> String.split(",", trim: true)
    |> Enum.map(fn x -> String.split(x) end)
    |> Enum.into([], fn [left, right] -> %{num: String.to_integer(left), color: right} end)
  end

  def get_max_color(results, color) do
    results
    |> List.flatten()
    |> Enum.filter(fn result -> Map.get(result, :color) == color end)
    |> Enum.map(fn x -> Map.get(x, :num) end)
    |> Enum.max()
  end

  def input_line_to_struct(line) do
    [number, results] = String.split(line, ":", trim: true)

    processed_results =
      results
      |> String.split(";", trim: true)
      |> Enum.map(fn result -> parse_single_game(result) end)

    %{
      game_number: number |> String.replace(~r/[^\d]/, "") |> String.to_integer(),
      max_red: get_max_color(processed_results, "red"),
      max_green: get_max_color(processed_results, "green"),
      max_blue: get_max_color(processed_results, "blue")
    }
  end

  def parse_games(file) do
    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> input_line_to_struct(line) end)
  end

  def analyze_games_from_file(file) do
    red = 12
    green = 13
    blue = 14
    games = parse_games(file)

    possible_games =
      games
      |> Enum.filter(fn game ->
        game.max_red <= red &&
          game.max_green <= green &&
          game.max_blue <= blue
      end)

    id_sum = Enum.reduce(possible_games, 0, fn x, acc -> x.game_number + acc end)

    %{
      possible_games: possible_games,
      sum: id_sum
    }
  end
end

Cubes.analyze_games_from_file("input.txt")
