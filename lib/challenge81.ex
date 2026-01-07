defmodule Challenge81 do
  @moduledoc """
  P81 (**) Path from one node to another one
    Write a function (path g a b) to return an acyclic path from node a to node b in the graph g. The function should return all paths.

  Graph Expression Form:
  [
   ["b", "c", "d", "f", "g", "h", "k"],
   [["b", "c"], ["b", "f"], ["c", "f"], ["f", "k"], ["g", "h"]]
  ]

  Adjacency List Form:
  [
    ["b", ["c", "f"]],
    ["c", ["b", "f"]],
    ["d", []],
    ["f", ["b", "c", "k"]],
    ["g", ["h"]],
    ["h", ["g"]],
    ["k", ["f"]]
  ]
  """

  def path(_graph, x, y) when x == y, do: []

  def path(graph, x, y) do
    # here graph is of Graph Expression Form
    [nodes, edges] = graph

    cond do
      x not in nodes ->
        []

      y not in nodes ->
        []

      true ->
        paths = path_impl(graph, x, y, [])

        Enum.map(paths, fn path ->
          Enum.map(path, fn [a, b] ->
            if [a, b] in edges, do: [a, b], else: [b, a]
          end)
        end)
    end
  end

  defp path_impl(graph, x, y, seen) do
    [_nodes, edges] = graph

    Enum.reduce(edges, [], fn edge, acc ->
      [a, b] = edge

      if !(x in edge) do
        # skip
        acc
      else
        new_acc =
          if y in edge do
            acc ++ [[edge]]
          else
            if [a, b] in seen or [b, a] in seen do
              # skip, loop?
              acc
            else
              new_x = if a == x, do: b, else: a
              new_vals = path_impl(graph, new_x, y, [edge | seen])

              Enum.reduce(new_vals, acc, fn cur_val, new_acc ->
                new_acc ++ [[edge | cur_val]]
              end)
            end
          end

        new_acc
      end
    end)
  end
end
