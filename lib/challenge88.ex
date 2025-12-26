defmodule Challenge88 do
  @moduledoc """
  P88 (**) Connected components
    Write a function that splits a graph into its connected components.

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

  def get_graph_connected_components(graph) do
    # here graph is of Graph Expression Form
    [nodes, _edges] = graph

    Enum.reduce(nodes, [], fn x, acc ->
      # acc is a list of components, i.e. list of lists
      # x is a node

      updated_acc =
        Enum.map(acc, fn component ->
          # component is a list of nodes
          path_exists =
            Enum.any?(component, fn component_node ->
              Challenge81.path(graph, component_node, x) != []
            end)

          if path_exists, do: component ++ [x], else: component
        end)

      if updated_acc != acc, do: updated_acc, else: acc ++ [[x]]
    end)
  end
end
