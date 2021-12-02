defmodule Aoc2021.Day02 do
  defp parse(file) do
    File.read!(file)
    |> String.split([" ","\n"], trim: true)
  end

  def part1(file \\ "input/day02.txt") do
    x = 0;
    y = 0;
    parse(file)
    |> Enum.chunk_every(2)
    |> IO.inspect()
    |> Enum.reduce({0, 0},fn([a, b], acc) ->
        case a do
          "forward" ->
                acc = {elem(acc, 0) + String.to_integer(b), elem(acc, 1)}
                IO.inspect(acc)
          "backward" ->
                acc = {elem(acc, 0) - String.to_integer(b), elem(acc, 1)}
          "up" ->
                acc = {elem(acc, 0), elem(acc, 1) - String.to_integer(b)}
          "down" ->
                acc = {elem(acc, 0), elem(acc, 1) + String.to_integer(b)}
        end
      end
    )
    |> Tuple.product()
  end

  def part2(file \\ "input/day02.txt") do
    5
  end
end
