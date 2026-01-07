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
      x not in nodes -> []
      y not in nodes -> []
      !Enum.any?(edges, fn [from, _to] -> from == x end) -> []
      !Enum.any?(edges, fn [_from, to] -> to == y end) -> []
      true -> path_impl(graph, x, y, [])
    end
  end

  defp path_impl(graph, x, y, seen) do
    # skips possible loops
    [_nodes, edges] = graph

    Enum.reduce(edges, [], fn edge, acc ->
      [from_node, to_node] = edge

      if from_node != x do
        # skip
        acc
      else
        new_acc =
          if to_node == y do
            acc ++ [[edge]]
          else
            if edge in seen do
              # skip, loop?
              acc
            else
              new_vals = path_impl(graph, to_node, y, seen ++ [[from_node, to_node], [to_node, from_node]])

              Enum.reduce(new_vals, acc, fn x, new_acc ->
                new_acc = new_acc ++ [[edge | x]]
                new_acc
              end)
            end
          end

        new_acc
      end
    end)
  end
end
