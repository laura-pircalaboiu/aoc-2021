defmodule Aoc2021.Day10 do
  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(
        fn line ->
            String.split(line, "", trim: true)
        end
    )
  end

#   def matches("{", "}"), do: true
#   def matches("[", "]"), do: true
#   def matches("<", ">"), do: true
#   def matches("(", ")"), do: true

#   def is_open(rb), do: rb in ["{", "<", "[", "("]

  def solve_line(line) do
    Enum.reduce_while(line, {0, []},
        fn(x, acc)->
            {num, st} = acc
            if num > 0 do
                {:halt, acc}
            else
                acc = build_stack(x, acc)
                {:cont, acc}
            end
        end
    )
  end

  def complete_line(line) do
    Enum.reduce(line, {0, []},
        fn(x, acc)->
            acc = build_stack(x, acc)
        end
    )
  end

  def build_stack(next, {n, [head | tail]}) 
                when (next == "}" and head == "{")
                or (next == ">" and head == "<")
                or (next == ")" and head == "(")
                or (next == "]" and head == "["), do: {n, tail}

  def build_stack(next, {n, bs}) when next in ["{", "<", "[", "("], do: {n, [next | bs]}
  def build_stack(next, {n, bs}) do
    case next do
        ")" -> {n + 3, bs}
        "]" -> {n + 57, bs}
        "}" -> {n + 1197, bs}
        ">" -> {n + 25137, bs}
    end
  end 

  def calc_score("("), do: 1
  def calc_score("["), do: 2
  def calc_score("{"), do: 3
  def calc_score("<"), do: 4

  def part1(file \\ "input/day10.txt") do
    parse(file)
    |> Enum.map(fn line ->
        solve_line(line)
    end)
    |> Enum.map(fn {a, b} -> a end)
    |> Enum.sum()
  end

  def part2(file \\ "input/day10.txt") do
    filtered = parse(file)
    |> Enum.map(fn line ->
        solve_line(line)
    end)
    |> Enum.filter(fn{a, b} -> a == 0 end)

    mid = round(Enum.count(filtered)/2)
    IO.inspect(mid)

    filtered
    |> Enum.map(fn{a, b} -> Enum.reduce(b, 0, 
            fn (x, acc)->
              acc * 5 + calc_score(x)
            end)
        end)
    |> Enum.sort()
    |> IO.inspect()
    |> Enum.fetch!(mid-1)
  end
end