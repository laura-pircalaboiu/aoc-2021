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
  
  def make_better_fish(fish, 9, 0), do: fish
  def make_better_fish(fish, 0, days_left) do
    fish = List.replace_at(fish, 6, Enum.fetch!(fish, 6) + Enum.fetch!(fish, 0))
    fish = List.replace_at(fish, 8, Enum.fetch!(fish, 8) + Enum.fetch!(fish, 0))
    make_better_fish(fish, 1, days_left)
  end
  def make_better_fish(fish, 9, days_left), do: make_better_fish(fish, 0, days_left - 1)
  def make_better_fish(fish, idx, days_left) do
    fish = List.replace_at(fish, idx-1, Enum.fetch!(fish, idx))
    make_better_fish(fish, idx+1, days_left)
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

  def part2(file \\ "input/day06_ex.txt") do
    parse(file)
    |> Enum.frequencies()
    |> fill_map(0)
    |> Map.values()
    |> make_better_fish(0, 18)
    |> IO.inspect()
    |> Enum.sum()
    end
end
