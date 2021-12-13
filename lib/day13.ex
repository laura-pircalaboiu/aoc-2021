defmodule Aoc2021.Day13 do
  defp parse(file) do
    inp = File.read!(file)
    |> String.split("\n\n", trim: true)
    fst = inp 
    |> Enum.at(0)
    |> String.split("\n", trim: true)
    |> Enum.map(
        fn(line) -> 
            [a, b] = String.split(line, ",", trim: true)
            {{String.to_integer(a), String.to_integer(b)}, 1}
        end)
    |> Map.new()
    snd = inp
    |> Enum.at(1)
    |> String.split("\n", trim: true)
    |> Enum.map(
        fn line -> 
            [a, b] = String.split(line, ["fold along ", "="], trim: true)
            {a, String.to_integer(b)}
        end)
    {fst, snd}
  end

  def update_point({x, y}, m, {"x", l}) when x > l do
    diff = x-l
    m = Map.delete(m, {x, y})
    |> Map.put({x-2*diff, y}, 1)
  end

  def update_point({x, y}, m, {"y", l}) when y > l do
    diff = y-l
    m = Map.delete(m, {x, y})
    |>  Map.put({x, y-2*diff}, 1)
  end

  def update_point(_, m, _) do
    m
  end

  def keep_folding(points, []), do: points
  def keep_folding(points, [f | folds]) do
    points
    |> Enum.reduce(points, 
        fn({p, v}, acc)->
            acc = update_point(p, acc, f)
        end
    ) 
    |> keep_folding(folds)
  end

  def part1(file \\ "input/day13.txt") do
    {points, folds} = parse(file)
    f = Enum.fetch!(folds, 0)
    points
    |> Enum.reduce(points, 
        fn({p, v}, acc)->
            acc = update_point(p, acc, f)
        end
    )
    |> Enum.count()
  end

  def part2(file \\ "input/day13.txt") do
    {points, folds} = parse(file)
    f = Enum.fetch!(folds, 0)
    keep_folding(points, folds)
    |> draw_answer()
  end

  def draw_answer(pts) do
    Enum.each(0..20,
      fn x -> 
        Enum.each(0..50,
          fn y -> 
            if Map.has_key?(pts, {y, x}) do
              IO.write("█")
            else
              IO.write(" ")
            end
          end
        )
        IO.write("\n")
      end
    )
  end
end
