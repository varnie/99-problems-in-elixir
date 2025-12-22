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

  def path_impl(graph, x, y) do
    # here graph is of Graph Expression Form
    [_nodes, edges] = graph

    Enum.filter(edges, fn [from_node, _] -> from_node == x end)
    |>
    Enum.map(fn [from_node, to_node] ->
      if to_node == y do
        [x, y]
      else
        Enum.flat_map(path_impl(graph, to_node, y), fn new_item ->
          [from_node | new_item]
        end)
      end
    end)
    |> Enum.reject(fn item -> item == [] end)
  end
end
