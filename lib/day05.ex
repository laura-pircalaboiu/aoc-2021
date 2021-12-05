defmodule Aoc2021.Day05 do
  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn(line)-> String.split(line, ["->"," "], trim: true) end)
    |> Enum.map( 
        fn(line) ->
            Enum.map(line, 
                fn tup -> 
                    tup = String.split(tup, ",", trim: true)
                end
            )
            |> Enum.map(
                fn([a, b]) -> 
                    {String.to_integer(a), String.to_integer(b)}
                end)
        end
    )
  end

  def sign(0), do: 0
  def sign(n), do: if(n > 0, do: 1, else: -1)

  def inc_point(m, p) do
    Map.put(m, p, Map.get(m, p, 0) + 1)
  end

  def put_lines([], m), do: m
  def put_lines([[{x1,y1}, {x2,y2}] | lines], m) do
    line_range = if x1 == x2 do
                    abs(y2 - y1)
                 else
                    abs(x2 - x1)
                end
    dir_x = sign(x2 - x1)
    dir_y = sign(y2 - y1)
    m = Enum.reduce(0..line_range, m, fn(i, m) ->  inc_point(m, {x1 + i * dir_x, y1 + i * dir_y}) end)
    put_lines(lines, m)
  end

  def part1(file \\ "input/day05.txt") do
    parse(file)
    |> Enum.filter(fn [{x1, y1}, {x2, y2}] -> x1 == x2 || y1 == y2 end)
    |> put_lines(%{})
    |> Map.values()
    |> Enum.filter(fn(x) -> x > 1 end)
    |> Enum.count()
  end

  def part2(file \\ "input/day05.txt") do
    parse(file)
    |> put_lines(%{})
    |> Map.values()
    |> Enum.filter(fn(x) -> x > 1 end)
    |> Enum.count()
  end
end