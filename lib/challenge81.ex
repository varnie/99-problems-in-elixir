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
    [nodes, _edges] = graph

    if x not in nodes or y not in nodes do
      []
    else
      path_impl(graph, x, y)
    end
  end

  defp path_impl(graph, x, y) do
    [_nodes, edges] = graph

    Enum.reduce(edges, [], fn next_node, acc ->
      [from_node, to_node] = next_node

      if from_node !== x do
        # skip
        acc
      else
        new_acc =
          if to_node == y do
            acc ++ [[next_node]]
          else
            new_vals = path_impl(graph, to_node, y)
            Enum.reduce(new_vals, acc, fn x, new_acc ->
              new_acc = new_acc ++ [[next_node | x]]
              new_acc
            end)
          end

        new_acc
      end
    end)
  end
end
