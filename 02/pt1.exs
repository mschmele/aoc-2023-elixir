defmodule Cubes do
  def parse_single_game(game) do
    game
    |> String.split(",", trim: true)
    |> Enum.map(fn x ->  x |> String.split() |> Enum.reverse() end)
  end

  def input_line_to_struct(line) do
    game_number =
      line
      |> String.split(":", trim: true)
      |> Enum.at(0)
      |> String.replace(~r/[^\d]/, "")

    game_results =
      line
      |> String.split(":", trim: true)
      |> Enum.at(1)
      |> String.split(";", trim: true)
      |> Enum.map(fn game -> parse_single_game(game) end)

    dbg()
    games = %{game_number: game_number, game_results: game_results}
  end

  def parse_games(file) do
    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> input_line_to_struct(line) end)
  end

  def analyze_games_from_file(file) do
    parse_games(file)

    # TODO: this fn :)
  end
end

IO.puts(Cubes.analyze_games_from_file("smallinput.txt"))
