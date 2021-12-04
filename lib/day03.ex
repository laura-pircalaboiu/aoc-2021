defmodule Aoc2021.Day03 do
  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      String.split(s, "", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def transpose([]), do: []
  def transpose([[] | _]), do: []

  def transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end

  def part1(file \\ "input/day03.txt") do
    parse(file)
    |> transpose()
    |> Enum.map(&Enum.frequencies/1)
  end

  def helperCO2([x], _), do: x

  def helperCO2(xs, idx) do
    c = Enum.count(xs)

    res =
      transpose(xs)
      |> Enum.map(&Enum.sum/1)

    r =
      if IO.inspect(Enum.fetch!(res, idx)) < c / 2 do
        Enum.filter(xs, fn x -> Enum.fetch!(x, idx) == 1 end)
      else
        Enum.filter(xs, fn x ->  Enum.fetch!(x, idx) == 0 end)
      end
    helperCO2(r, idx + 1)
  end

  def helperOxy([x], _), do: x

  def helperOxy(xs, idx) do
    c = Enum.count(xs)

    res =
      transpose(xs)
      |> Enum.map(&Enum.sum/1)

    r =
      if IO.inspect(Enum.fetch!(res, idx)) >= c / 2 do
        Enum.filter(xs, fn x -> Enum.fetch!(x, idx) == 1 end)
      else
        Enum.filter(xs, fn x ->  Enum.fetch!(x, idx) == 0 end)
      end
    helperOxy(r, idx + 1)
  end

  def part2(file \\ "input/day03.txt") do
    xs = parse(file)
    Integer.undigits(helperOxy(xs, 0), 2) * Integer.undigits(helperCO2(xs, 0), 2)
  end
end
