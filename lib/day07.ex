defmodule Aoc2021.Day07 do
  defp parse(file) do
    File.read!(file)
    |> String.split(["\n", ","], trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def median([]), do: nil
  def median(list) do
    len = length(list)
    sorted = Enum.sort(list)
    mid = div(len, 2)
    if rem(len,2) == 0, do: (Enum.at(sorted, mid-1) + Enum.at(sorted, mid)) / 2,
                      else: Enum.at(sorted, mid)
  end 

  def avg(list), do: Float.floor(Enum.sum(list)/Enum.count(list))

  def part1(file \\ "input/day07.txt") do
    crabs = parse(file)
    crab_pos = median(crabs)
    Enum.reduce(crabs, 0, 
        fn(x, acc) ->
            abs(x - crab_pos) + acc
        end
    )
  end

  def part2(file \\ "input/day07.txt") do
    crabs = parse(file)
    crab_pos = avg(crabs)
    Enum.reduce(crabs, 0, 
        fn(x, acc) ->
            n = abs(x - crab_pos)
            (n * (n+1))/2 + acc
        end
    ) 
    #|> round()
  end
end
