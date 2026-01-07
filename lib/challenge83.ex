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

#    g = [
#      [1, 2, 3, 4],
#      [[1, 2], [2, 3], [3, 4], [4, 1], [1, 3], [2, 4]]
#    ]

  def s_tree(graph) do
    # here graph is of Graph Expression Form
    [_nodes, edges] = graph

    if !is_connected?(graph) do
      raise("Graph should be connected!")
    else
      s_trees_list = s_tree_impl(graph, edges)
      IO.inspect(s_trees_list, label: "pre-result")
      [_, edges] = Enum.min_by(s_trees_list, fn [_n, e] -> length(e) end)
      min_length = length(edges)
      IO.inspect(min_length, label: "min")
      Enum.filter(s_trees_list, fn [_n, e] -> length(e) == min_length end) |> Enum.uniq()
    end
  end

  defp s_tree_impl(graph, last_run_edges) do
    # here graph is of Graph Expression Form
    [nodes, _] = graph
    IO.inspect(graph, label: "graph")
    IO.inspect(last_run_edges, label: "last_run_edges")

    Enum.reduce(last_run_edges, [], fn x, acc ->
      edge_to_remove = x
      rest_edges = Enum.reject(last_run_edges, &(&1 == edge_to_remove))

      new_graph = [nodes, rest_edges]

      if is_connected?(new_graph) do
        IO.puts("connected, go deeper")
        Enum.concat(acc, s_tree_impl(new_graph, rest_edges))
      else
        IO.inspect(new_graph, label: "this new_graph is not connected")
        IO.inspect(last_run_edges, label: "add new item")
        [[nodes, last_run_edges] | acc]
      end
    end)

    # TODO:
  end

  def is_tree?(graph) do
    [nodes, _edges] = graph
    #is_connected?(graph) and Enum.flat_map(nodes, fn node -> Challenge82.cycle(graph, node) end) == []
    #TODO: should be no cycles
  end

  def is_connected?(graph) do
    [nodes, edges] = graph
    length(edges) > 0 and Enum.all?(nodes, &is_connected_impl(graph, &1, nodes))
  end

  defp is_connected_impl(graph, node_from, nodes) do
    nodes_to = Enum.filter(nodes, &(&1 != node_from))

    Enum.all?(nodes_to, fn node_to ->
      result = check_path(graph, node_from, node_to) or check_path(graph, node_to, node_from)
      if !result do
        IO.puts("no path from #{node_from} to #{node_to} or vice versa")
      end
      result
    end)
  end

  defp check_path(graph, node_from, node_to) do
    IO.inspect(node_from)
    IO.inspect(node_to)

    try do
      path_result = Challenge81.path(graph, node_from, node_to)
      IO.inspect(path_result)
      result = path_result != []
      IO.inspect(result, label: "result")
      result
    rescue
      _ ->
        IO.puts("result no")
        false
    end
  end
end


# [[1, 2, 3, 4], [[1, 2], [3, 4], [1, 3]]] - should be connected