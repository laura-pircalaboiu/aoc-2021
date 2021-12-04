defmodule Aoc2021.Day04 do
  defp parse(file) do
    parsed = File.read!(file)
    |> String.split("\n\n", trim: true)
    nums = parsed
           |> Enum.at(0)
           |> String.split(",", trim: true)
           |> Enum.map(&String.to_integer/1)

    tables = parsed 
           |> Enum.drop(1)
           |> Enum.map(&String.split(&1, "\n", trim: true))
           |> Enum.map(&Enum.map(&1, fn(row) -> String.split(row, " ", trim: true) end))
           |> Enum.map(fn board -> 
                Enum.map(board, fn row -> 
                        Enum.map(row, fn el -> 
                                String.to_integer(el)
                        end)
                end)
           end) 
           #|> Enum.map(&Enum.map(&1, Enum.map(&1, 
           #             fn(elem) -> String.to_integer(elem) end)))    
    {nums, tables}
  end
  
  def transpose([]), do: []
  def transpose([[] | _]), do: []

  def transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end

  def is_solved_one_way(tab), do: 
        Enum.any?(tab, &Enum.all?(&1,  
                fn(x) -> 
                        x == -1
                end))

  def is_solved(tab) do
    is_solved_one_way(tab) || is_solved_one_way(transpose(tab)) 
    end

  def called(n, tab) do
    Enum.map(tab, &Enum.map(&1, fn(x) -> 
       if x == n do
          -1
       else
          x
       end
    end))
  end

  def called_all([n | ns], tabs) do
    tabs = Enum.map(tabs, &called(n, &1)) 
    x = Enum.reject(tabs, &is_solved/1) 
    if length(x) != 1 do
        called_all(ns, x)
    else
        {hd(x), n}
    end
  end

  def part1(file \\ "input/day04.txt") do
    {num, tabs} = parse(file)
    {wtab, wn} = called_all_pt1(num, tabs)
    wtab
    |> Enum.map(&Enum.map(&1, fn
        -1 -> 0
        e -> e
      end    
    )) 
    |> Enum.map(&Enum.sum()/1) 
    |> Enum.sum()
    |> then(&(&1 * wn))
  end

  def called_all_pt1([n | ns], tabs) do
    Enum.map(tabs, &Enum.map(&1, fn(x) -> 
       if x == n do
          -1
       else
          x
       end
      end))
    if (x = Enum.find(tabs, &is_solved/1)) == nil do
        called_all_pt1(ns, tabs)
    else
        {x, n}
    end
  end

  def part2(file \\ "input/day04_example.txt") do
    {num, tabs} = parse(file)
    {wtab, n} = called_all(num, tabs)
    IO.inspect({n, wtab})
    called_all_pt1(num, wtab)
  end
end
