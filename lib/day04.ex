defmodule Aoc2021.Day04 do
  defp parse(file) do
    parsed = File.read!(file)
    |> String.split("\n\n", trim: true)
    

  def part1(file \\ "input/day04.txt") do
    nums = parse(file)
           |> Enum.at(0)
           |> String.split(",", trim: true)
           |> Enum.map(&String.to_integer/1)

    tables = parse(file) 
           |> Enum.drop(1
           |> String.split("\n"))
           |> String.split(" ")
           |> Enum.map(&String.to_integer/1)

  end

  def part2(file \\ "input/day04.txt") do
    parse(file)
  end
end
