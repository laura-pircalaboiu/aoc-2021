defmodule Aoc2021.Day01 do
  defp parse(file) do
    File.read!(file)
    |> String.split("\n\n")
  end

  def part1(file \\ "input/day01.txt") do
    nums = parse(file)
           |> Enum.at(1)

    tables = parse(file)
  end

  def part2(file \\ "input/day01.txt") do
    parse(file)
  end
end
