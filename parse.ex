defmodule Aoc2021.Parse do
  def parse_int_lines(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
