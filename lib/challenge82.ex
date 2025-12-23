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

    if a not in nodes do
      []
    else
      cycle_impl(graph, a, a)
    end
  end

  def cycle_impl(graph, cur_node, dest, visited_nodes \\ []) do
    # here graph is of Graph Expression Form
    [_nodes, edges] = graph

    Enum.reduce(edges, [], fn next_node, acc ->
      [from_node, to_node] = next_node

      if from_node != cur_node or next_node in visited_nodes do
        # skip
        acc
      else
        new_acc =
          if to_node == dest do
            acc ++ [[next_node]]
          else
            new_visited_nodes = visited_nodes ++ [next_node]
            new_vals = cycle_impl(graph, to_node, dest, new_visited_nodes)

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
