defmodule Aoc2021.Day12 do
  defp parse(file) do
    edges = File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(
        fn line -> 
            [a, b] = String.split(line, "-", trim: true)
            {a, b}
        end)
    Graph.new(type: :undirected) |> Graph.add_edges(edges)
  end

  def dfs(g, s, e, visited, path) when s == e do 
    IO.puts("word")
  end

  def dfs(g, s, e, visited, path) do
    path = [s | path]
    visited = Map.replace(visited, s, 1)
    neighbors = Graph.out_neighbors(g, s)
    Enum.each(neighbors, 
      fn n ->
        if (Map.get(visited, n) == 0) || (Map.get(visited, n) != 0 && String.upcase(n) == n) do
              dfs(g, n, e, visited, path)
        end
      end
    )
    [s | tail] = path
    path = tail
    visited = Map.replace(visited, s, 0)
  end

  def dfs2(g, s, e, visited, path) when s == e do 
    IO.puts("yeet")
  end

  def dfs2(g, s, e, visited, path) do
    path = [s | path]
    visited = Map.update(visited, s, 0, fn x -> if String.upcase(s) != s do Map.get(visited, s) + 1 else  Map.get(visited, s) end end)
    neighbors = Graph.out_neighbors(g, s)
    Enum.each(neighbors, 
      fn n ->
        if (Map.get(visited, n) == 0) || (Map.get(visited, n) == 1 && n != "start" && (Enum.count(Map.values(visited), fn x -> x == 2 end) == 0)) || (String.upcase(n) == n) do
              dfs2(g, n, e, visited, path)
        end
      end
    )
    [s | tail] = path
    path = tail
    visited = Map.update(visited, s, 0, fn x -> if String.upcase(s) != s do Map.get(visited, s) - 1 else  Map.get(visited, s) end end)
  end

  def print_all_paths(g, s, e) do
    m = Enum.reduce(Graph.vertices(g), %{}, fn(x, acc)-> Map.put(acc, x, 0) end)
    dfs(g, s, e, m, [])
  end

  def print_all_paths2(g, s, e) do
    m = Enum.reduce(Graph.vertices(g), %{}, fn(x, acc)-> Map.put(acc, x, 0) end)
    dfs2(g, s, e, m, [])
  end

  def part1(file \\ "input/day12.txt") do
  #   parse(file)
  #   |> print_all_paths("start", "end")
  end

  def part2(file \\ "input/day12.txt") do
    parse(file)
    |> print_all_paths2("start", "end")
  end
end
