defmodule Challenge89 do
  @moduledoc """
  P89 (**) Bipartite graphs
    Write a function that finds out whether a given graph is bipartite.

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

  def is_bipartite(graph) do
    # here graph is of Graph Expression Form
    [nodes, edges] = graph

    is_bipartite_impl(nodes, edges, [], [], false)
  end

  defp is_bipartite_impl([], _edges, _left_nodes, _right_nodes, last_status) do
    last_status
  end

  defp is_bipartite_impl([head_node | rest_nodes], edges, left_nodes, right_nodes, _last_status) do
    # here graph is of Graph Expression Form

    adjacent_edges = Enum.filter(edges, fn edge -> head_node in edge end)
    neighbour_nodes = Enum.map(adjacent_edges, fn [a, b] -> if a == head_node, do: b, else: a end)

    cond do
      neighbour_nodes == [] ->
        false

      head_node in right_nodes ->
        if Enum.any?(neighbour_nodes, fn test_node -> test_node in right_nodes end) do
          false
        else
          is_bipartite_impl(rest_nodes, edges, left_nodes, right_nodes, true)
        end

      true ->
        new_left_nodes = [head_node | left_nodes]
        new_right_nodes = right_nodes ++ neighbour_nodes
        is_bipartite_impl(rest_nodes, edges, new_left_nodes, new_right_nodes, true)
    end
  end
end
