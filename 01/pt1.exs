defmodule Trebuchet do
  #                                .`.
  #                             / `.`.
  #      ______________________/____`_`____________________________
  #     / .''.  _        _           _          _           __..--->.
  #     \ '()'       _       .''.        _       ____...---'       .'
  #      |_||______.`.__  .' .'______......-----'                 /
  #       .||-||-./ `.`.' .'   \/_/  `./   /`.`.                .'
  #     .'_||__.'/ (O)`.`.    \/_/     `./   /`.`.             /
  #     |_ -  _|/\     /`.`. \/_/        `./   /`.`.          /
  #     | - _  /\   ./   /`.`. /___________`./   /`.`._     .'
  #     '-----/\  \/ `./   /`.`._____________`._____` .|   /
  #          /\  \/_/  `./   /`.`.________________.'.'.' .'
  #         /\  \/_/   .-`./   /`.`.---------.''.-----.-'
  #        /\  \/_/  .'~ _ `./   /`.`. _ ~   '..'`._.'
  #     .'/\  \/_/  '--------`./   /`.`.-----------'
  #   .' /\  \/ /______________`./   /`.`..'.'.'
  # .'__/____/___________________`._____` .'.'
  # |____________________________________|.' LGB

  def lines_to_calibration_values(lines) do
    Enum.map(
      lines,
      fn line ->
        num_string = String.replace(line, ~r/[^\d]/, "")
        num_size = String.length(num_string)
        first_char = String.first(num_string)
        last_char = String.last(num_string)

        cond do
          num_size >= 1 ->
            [first_char, last_char]
            |> Enum.join()
            |> String.to_integer()

          num_size < 1 ->
            nil
        end
      end
    )
  end

  def calibrate_the_treb(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> lines_to_calibration_values
    |> Enum.sum()
  end
end

IO.puts(Trebuchet.calibrate_the_treb("input1.txt"))
