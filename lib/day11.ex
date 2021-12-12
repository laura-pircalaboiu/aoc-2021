# defmodule Aoc2021.Day11 do
#   import Nx.Defn
#   defp parse(file) do
#     File.read!(file)
#     |> String.split("\n", trim: true)
#     |> Enum.map(
#         fn line ->
#             String.split(line, "", trim: true)
#             |> Enum.map(
#                 fn l ->
#                     String.to_integer(l)
#                 end
#             )
#         end)
#     |> Nx.tensor()
#   end

  
#   def inc_octopus(x, y, octopi)
#                     when y > Enum.count(octopi)
#                     or x > Enum.count(octopi[1])
#                     or x < 0
#                     or y < 0 do 
#     octopi = octopi[x][y] + 1
#     octopi = octopi[x-1][y-1] + 1

#   end

  
#   def part1(file \\ "input/day11_ex.txt") do
#     parse(file)
#     |> step(100)
#   end

#   def part2(file \\ "input/day11_ex.txt") do
#     parse(file)

#   end
# end
