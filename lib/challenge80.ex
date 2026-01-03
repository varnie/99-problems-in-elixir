defmodule Challenge80 do
  @moduledoc """
  P80 (***) Conversions
      Write functions to convert between the different graph representations. With these functions,
  all representations are equivalent; i.e. for the following problems you can always pick freely the most convenient
  form. The reason this problem is rated (***) is not because it's particularly difficult, but because it's a lot
  of work to deal with all the special cases.

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

  def convert_graph_expression_form_to_adjacency_list_form(graph_expression) do
    [nodes, edges] = graph_expression

    Enum.map(nodes, fn cur_node ->
      adjacent_nodes =
        Enum.filter(edges, fn [from, to] -> cur_node in [from, to] end)
        |> Enum.map(fn [from, to] ->
          if from == cur_node, do: to, else: from
        end)
        |> Enum.sort()

      [cur_node, adjacent_nodes]
    end)
  end

  def convert_adjacency_list_form_to_graph_expression_form(adjacency_list_form) do
    nodes =
      Enum.map(adjacency_list_form, fn [cur_node, _] ->
        cur_node
      end)

    edges =
      Enum.reduce(adjacency_list_form, [], fn x, acc ->
        [cur_node, adjacent_nodes] = x

        edges =
          Enum.reject(adjacent_nodes, fn adjacent_node ->
            [cur_node, adjacent_node] in acc or [adjacent_node, cur_node] in acc
          end)
          |> Enum.map(fn adjacent_node -> [cur_node, adjacent_node] end)

        acc ++ edges
      end)

    [nodes, edges]
  end
end
