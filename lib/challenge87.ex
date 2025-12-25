defmodule Challenge87 do
  @moduledoc """
  P87 (**) Depth-first order graph traversal (alternative solution)
    Write a function that generates a depth-first order graph traversal sequence.
    The starting point should be specified, and the output should be a list of nodes that are reachable from this
    starting point (in depth-first order).

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

  def graph_traversal_depth_first_order(graph, start_node) do
    # here graph is of Graph Expression Form
    [nodes, _edges] = graph

    if start_node in nodes do
      # Move start_node to the beginning
      nodes = [start_node] ++ Enum.reject(nodes, fn a -> a == start_node end)

      {result, _visited_nodes} =
        Enum.reduce(nodes, {[], []}, fn x, acc ->
          {cur_result, cur_visited_nodes} = acc

          {new_result, new_visited_nodes} =
            graph_traversal_depth_first_order_impl(graph, x, cur_visited_nodes)

          {cur_result ++ new_result, new_visited_nodes}
        end)

      result
    else
      raise("Node not found!")
    end
  end

  defp graph_traversal_depth_first_order_impl(graph, start_node, visited_nodes) do
    # here graph is of Graph Expression Form
    [_nodes, edges] = graph

    if start_node in visited_nodes do
      {[], visited_nodes}
    else
      next_nodes =
        Enum.filter(edges, fn [node_from, _node_to] ->
          node_from == start_node
        end)

      Enum.reduce(next_nodes, {[start_node], visited_nodes ++ [start_node]}, fn x, acc ->
        [_next_node_from, next_node_to] = x
        {cur_result, cur_visited_nodes} = acc

        if next_node_to in cur_visited_nodes do
          acc
        else
          {new_result, new_visited_nodes} =
            graph_traversal_depth_first_order_impl(
              graph,
              next_node_to,
              cur_visited_nodes
            )

          {cur_result ++ new_result, new_visited_nodes}
        end
      end)
    end
  end
end
