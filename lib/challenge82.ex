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

  #TODO: work with undirected graphs also pls?
  defp cycle_impl(graph, cur_node, dest, visited_edges \\ []) do
    # here graph is of Graph Expression Form
    [_nodes, edges] = graph

    Enum.reduce(edges, [], fn next_edge, acc ->
      [from_node, to_node] = next_edge

      if from_node != cur_node or next_edge in visited_edges do
        # skip
        acc
      else
        new_acc =
          if to_node == dest do
            acc ++ [[next_edge]]
          else
            new_visited_edges = visited_edges ++ [next_edge]
            new_vals = cycle_impl(graph, to_node, dest, new_visited_edges)

            Enum.reduce(new_vals, acc, fn x, new_acc ->
              new_acc = new_acc ++ [[next_edge | x]]
              new_acc
            end)
          end

        new_acc
      end
    end)
  end
end
