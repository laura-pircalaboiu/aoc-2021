defmodule Aoc2021.Day01 do
  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part1(file \\ "input/day01.txt") do
    parse(file)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> a < b end)
  end

  def part2(file \\ "input/day01.txt") do
    parse(file)
    |> Enum.chunk_every(3, 1)
    |> Enum.map(&Enum.sum/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> a < b end)
  end
end
