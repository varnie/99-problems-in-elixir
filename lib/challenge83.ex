defmodule Challenge83 do
  @moduledoc """
  P83 (**) Construct all spanning trees
    Write a function (s-tree graph) to construct (by backtracking) all spanning trees of a given graph. With this
    function, find out how many spanning trees there are for the graph depicted to the left.
    The data of this example graph can be found in the file p83.dat.
    When you have a correct solution for the s-tree function, use it to define two other useful
    functions: (is-tree graph) and (is-connected graph). Both are five-minutes tasks!

  Graph Expression Form:
  [
   ["b", "c", "f", "k"],
   [["b", "c"], ["b", "f"], ["c", "f"], ["f", "k"]]
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

  def s_tree(graph) do
    # here graph is of Graph Expression Form
    [_nodes, edges] = graph

    if !is_connected?(graph) do
      raise("Graph should be connected!")
    else
      s_trees_list = s_tree_impl(graph, edges)
      [_, edges] = Enum.min_by(s_trees_list, fn [_n, e] -> length(e) end)
      min_length = length(edges)
      Enum.filter(s_trees_list, fn [_n, e] -> length(e) == min_length end) |> Enum.uniq()
    end
  end

  defp s_tree_impl(graph, last_run_edges) do
    # here graph is of Graph Expression Form
    [nodes, _] = graph

    Enum.reduce(last_run_edges, [], fn x, acc ->
      edge_to_remove = x
      rest_edges = Enum.reject(last_run_edges, &(&1 == edge_to_remove))

      new_graph = [nodes, rest_edges]

      if is_connected?(new_graph) do
        Enum.concat(acc, s_tree_impl(new_graph, rest_edges))
      else
        [[nodes, last_run_edges] | acc]
      end
    end)
  end

  def is_tree?(graph) do
    [nodes, _edges] = graph

    is_connected?(graph) and
      Enum.all?(nodes, fn node ->
        Challenge82.cycle(graph, node) == []
      end)
  end

  def is_connected?(graph) do
    [nodes, edges] = graph
    length(edges) > 0 and Enum.all?(nodes, &is_connected_impl(graph, &1, nodes))
  end

  defp is_connected_impl(graph, node_from, nodes) do
    nodes_to = Enum.filter(nodes, &(&1 != node_from))

    Enum.all?(nodes_to, fn node_to ->
      check_path(graph, node_from, node_to) or check_path(graph, node_to, node_from)
    end)
  end

  defp check_path(graph, node_from, node_to) do
    try do
      path_result = Challenge81.path(graph, node_from, node_to)
      path_result != []
    rescue
      _ ->
        false
    end
  end
end
