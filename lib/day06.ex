defmodule Aoc2021.Day06 do
  defp parse(file) do
    File.read!(file)
    |> String.split([",","\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def fill_map(m, 9), do: m
  def fill_map(m, n) do
    m = if is_nil(Map.get(m, n)) do
            Map.put_new(m, n, 0)
        else
            m
        end
    fill_map(m, n+1)
  end

  def iterating_fish(arr, 0), do: arr
  def iterating_fish([a, b, c, d, e, f, g, h, i], t) do
    iterating_fish([b, c, d, e, f, g, h + a, i, a], t-1)
  end

  def make_fish(fish, 0), do: fish
  def make_fish(fish, days_left) do
    fish = Enum.flat_map(fish, 
        fn(x) ->
            if x > 0 do
                [x-1]
            else
                [6, 8]
            end
        end
    )
    make_fish(fish, days_left-1)
  end
  
  def part1(file \\ "input/day06.txt") do
    parse(file)
    |> make_fish(80)
    |> Enum.count()
  end

  def part2(file \\ "input/day06.txt") do
    parse(file)
    |> Enum.frequencies()
    |> fill_map(0)
    |> Map.values()
    |> iterating_fish(256)
    |> Enum.sum()
    end
end
