defmodule Challenge82 do
  @moduledoc """
  P82 [*] Cycle from a given node
    Write a function [cycle g a] to find a closed path [cycle] starting at a given node a in the graph g. The function should return all cycles.

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

  def cycle(graph, a) do
    # here graph is of Graph Expression Form
    [nodes, _edges] = graph

    if a in nodes do
      cycle_impl(graph, a, a)
    else
      []
    end
  end

  defp cycle_impl(graph, cur_node, dest_node, visited_edges \\ []) do
    # here graph is of Graph Expression Form
    [_nodes, edges] = graph

    relevant_edges =
      Enum.filter(edges, fn edge -> cur_node in edge and !(edge in visited_edges) end)

    Enum.reduce(relevant_edges, [], fn next_edge, acc ->
      [a, b] = next_edge

      new_acc =
        if dest_node in next_edge and cur_node != dest_node do
          acc ++ [[next_edge]]
        else
          new_visited_edges = visited_edges ++ [next_edge]
          new_from_node = if a == cur_node, do: b, else: a
          new_vals = cycle_impl(graph, new_from_node, dest_node, new_visited_edges)

          Enum.reduce(new_vals, acc, fn x, new_acc ->
            new_acc = new_acc ++ [[next_edge | x]]
            new_acc
          end)
        end

      new_acc
    end)
  end
end
