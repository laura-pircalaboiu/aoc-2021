defmodule Aoc2021.Day09 do
  import Nx.Defn
  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(
        fn line ->
            String.split(line, "", trim: true)
            |> Enum.map(
                fn l ->
                    String.to_integer(l)
                end
            )
        end)
    |> Nx.tensor()
  end

  def part1(file \\ "input/day09.txt") do
    arr = parse(file)
    arr[0][5]
  end

  def part2(file \\ "input/day09.txt") do
    parse(file)
  end
end