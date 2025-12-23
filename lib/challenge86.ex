defmodule Challenge86 do
  @moduledoc """
  P86 (**) Node degree and graph coloration

    a) Write a function (degree graph node) that determines the degree of a given node.
    b) Write a function that generates a list of all nodes of a graph sorted according to decreasing degree.
    c) Use Welch-Powell's algorithm to paint the nodes of a graph in such a way that adjacent nodes have different colors.

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

  def degree(graph, node) do
    # here graph is of Graph Expression Form
    [_nodes, edges] = graph

    Enum.count(edges, fn [a, b] -> node == a or node == b end)
  end

  def all_nodes_sorted_by_decreasing_degree(graph) do
    # here graph is of Graph Expression Form
    [nodes, _edges] = graph

    Enum.sort(nodes, fn a, b ->
      degree(graph, a) >= degree(graph, b)
    end)
  end

  def paint(graph) do
    # here graph is of Graph Expression Form
    all_nodes_sorted = all_nodes_sorted_by_decreasing_degree(graph)
    paint_helper(graph, all_nodes_sorted, 1)
  end

  defp paint_helper(graph, nodes = [node_head | nodes_tail], color) do
    # here graph is of Graph Expression Form
    [_nodes, edges] = graph

    IO.inspect(nodes, label: "nodes to process")

    result_map =
      Enum.reduce(nodes_tail, %{node_head => color}, fn x, acc ->
        IO.inspect(x, label: "checking ...")
        if Enum.find(edges, fn edge -> edge == [node_head, x] or edge == [x, node_head] end) do
          IO.inspect(x, label: "found in edges, skipping")
          acc
        else
        IO.inspect(x, label: "not found, adding")
          Map.put(acc, x, color)
        end
      end)

    IO.inspect(result_map, label: "result_map")

    # find remaining nodes
    remaining_nodes = Enum.reject(nodes, fn cur_node -> Map.has_key?(result_map, cur_node) end)

    case remaining_nodes do
      [] ->
        result_map

      _ ->
        new_result_map = paint_helper(graph, remaining_nodes, color + 1)
        Map.merge(result_map, new_result_map)
    end
  end
end
