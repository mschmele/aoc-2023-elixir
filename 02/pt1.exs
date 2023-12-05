defmodule Cubes do
  def parse_single_game(game) do
    game
    |> String.split(",", trim: true)
    |> Enum.map(fn x ->
      x |> String.split() |> Enum.reverse() |> List.to_tuple()
    end)
    |> List.flatten()
  end

  def get_max_color(results, color) do
    filtered_results = Enum.filter(results, fn result -> result.key == color end)

    results
  end

  def input_line_to_struct(line) do
    [number, results] = String.split(line, ":", trim: true)

    processed_results =
      results
      |> String.split(";", trim: true)
      |> Enum.join(",")
      |> parse_single_game()

    %{
      game_number: number |> String.replace(~r/[^\d]/, ""),
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
    games = parse_games(file)
    dbg()
  end
end

Cubes.analyze_games_from_file("smallinput.txt")
