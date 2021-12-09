defmodule Aoc2021.Day08 do

  defp parse_part_2(file) do
    File.read!(file)
    |> String.split(["|","\n"], trim: true)
    |> Enum.chunk_every(2)
    |> Enum.map(
      fn line ->
        Enum.map(line, 
          fn io ->
            String.split(io, " ", trim: true)
          end
        )
      end
    )
  end

  defp parse_part_1(file) do
    File.read!(file)
    |> String.split(["|","\n"], trim: true)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [_, b] -> b end)
    |> Enum.flat_map(fn a -> String.split(a, " ", trim: true) end)
  end

  def make_signatures(n) do
    zero = MapSet.new(Enum.with_index([1, 1, 1, 0, 1, 1, 1]) |> Enum.map(fn {a, b} -> {b, a} end))
    one = MapSet.new(Enum.with_index([0, 0, 1, 0, 0, 1, 0])|> Enum.map(fn {a, b} -> {b, a} end))
    two = MapSet.new(Enum.with_index([1, 0, 1, 1, 1, 0, 1])|> Enum.map(fn {a, b} -> {b, a} end))
    three = MapSet.new(Enum.with_index([1, 0, 1, 1, 0, 1, 1])|> Enum.map(fn {a, b} -> {b, a} end))
    four = MapSet.new(Enum.with_index([0, 1, 1, 1, 0, 1, 0])|> Enum.map(fn {a, b} -> {b, a} end))
    five = MapSet.new(Enum.with_index([1, 1, 0, 1, 0, 1, 1])|> Enum.map(fn {a, b} -> {b, a} end))
    six = MapSet.new(Enum.with_index([1, 1, 0, 1, 1, 1, 1])|> Enum.map(fn {a, b} -> {b, a} end))
    seven = MapSet.new(Enum.with_index([1, 0, 0, 0, 1, 1, 0])|> Enum.map(fn {a, b} -> {b, a} end))
    eight = MapSet.new(Enum.with_index([1, 1, 1, 1, 1, 1, 1])|> Enum.map(fn {a, b} -> {b, a} end))
    nine = MapSet.new(Enum.with_index([1, 1, 1, 1, 0, 1, 1])|> Enum.map(fn {a, b} -> {b, a} end))
    numbers = Map.new([{0, zero}, {1, one}, {2, two}, {3, three}, {4, four}, {5, five}, {6, six}, {7, seven}, {8, eight}, {9, nine}])
    
    orig = Map.get(numbers, n)
    Enum.reduce(numbers, %{}, 
      fn({k, target}, signatures)->
        i = Enum.count(MapSet.intersection(target, orig) |> Enum.filter(fn{a, b} -> b == 1 end))
        d = Enum.count(MapSet.difference(target, orig) |> Enum.filter(fn{a, b} -> b == 1 end))
        forig = MapSet.new(Enum.filter(orig, fn{_, b} -> b == 1 end))
        ftarget = MapSet.new(Enum.filter(target, fn{_, b} -> b == 1 end))
        u = Enum.count(MapSet.union(ftarget, forig))
        signatures = Map.put(signatures, i * 100 + d * 10 + u, k)
      end
    )
  end
  
  def solve_line_1(input, output) do
    y = Enum.at(Enum.filter(input, fn x -> String.length(x) == 2 end), 0)
    if y != nil do
      y = String.split(y, "", trim: true)
      y = MapSet.new(y)
      sigs = make_signatures(1)
      Enum.map(output, 
        fn num ->
          num = String.split(num, "", trim: true)
          num = MapSet.new(num)
          Enum.count(MapSet.intersection(num, y)) * 100 + Enum.count(MapSet.difference(num, y)) * 10 + Enum.count(MapSet.union(num, y))
        end
      )
      |> Enum.map(&Map.get(sigs, &1))
    end
  end

  def solve_line_4(input, output) do
    y = Enum.at(Enum.filter(input, fn x -> String.length(x) == 4 end), 0)
    if y != nil do
      y = String.split(y, "", trim: true)
      y = MapSet.new(y)
      sigs = make_signatures(4)
      Enum.map(output, 
        fn num ->
          num = String.split(num, "", trim: true)
          num = MapSet.new(num)
          Enum.count(MapSet.intersection(num, y)) * 100 + Enum.count(MapSet.difference(num, y)) * 10 + Enum.count(MapSet.union(num, y))
        end
      )
      |> Enum.map(&Map.get(sigs, &1))
    end
  end


  def solve_line_7(input, output) do
    y = Enum.at(Enum.filter(input, fn x -> String.length(x) == 3 end), 0)
    if y != nil do
      y = String.split(y, "", trim: true)
      y = MapSet.new(y)
      sigs = make_signatures(7)
      Enum.map(output, 
        fn num ->
          num = String.split(num, "", trim: true)
          num = MapSet.new(num)
          Enum.count(MapSet.intersection(num, y)) * 100 + Enum.count(MapSet.difference(num, y)) * 10 + Enum.count(MapSet.union(num, y))
        end
      )
      |> Enum.map(&Map.get(sigs, &1))
    end
  end


  def part1(file \\ "input/day08.txt") do
    nums = parse_part_1(file)
    fours = Enum.count(nums, fn x -> String.length(x) == 4 end)
    ones = Enum.count(nums, fn x -> String.length(x) == 2 end)
    sevens = Enum.count(nums, fn x -> String.length(x) == 3 end)
    eights = Enum.count(nums, fn x -> String.length(x) == 7 end)
    fours + ones + sevens + eights
  end

  def part2(file \\ "input/day08.txt") do
    parse_part_2(file)
    |> Enum.map(
      fn [a, b] ->
        dec_one = solve_line_1(a, b)
        dec_four = solve_line_4(a, b)
        dec_sev = solve_line_7(a, b)
        IO.inspect({dec_sev, dec_one, dec_four})
      end
    )
  end
end
