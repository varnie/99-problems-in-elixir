defmodule Challenge80Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     graph_expression_form: [
       ["b", "c", "d", "f", "g", "h", "k"],
       [["b", "c"], ["b", "f"], ["c", "f"], ["f", "k"], ["g", "h"]]
     ],
     adjacency_list_form: [
       ["b", ["c", "f"]],
       ["c", ["b", "f"]],
       ["d", []],
       ["f", ["b", "c", "k"]],
       ["g", ["h"]],
       ["h", ["g"]],
       ["k", ["f"]]
     ]}
  end

  test "convert_graph_expression_form_to_adjacency_list_form", state do
    graph_expression_form = state[:graph_expression_form]
    adjacency_list_form = state[:adjacency_list_form]

    assert Challenge80.convert_graph_expression_form_to_adjacency_list_form(graph_expression_form) ==
             adjacency_list_form
  end

  test "convert_adjacency_list_form_to_graph_expression_form", state do
    graph_expression_form = state[:graph_expression_form]
    adjacency_list_form = state[:adjacency_list_form]

    assert Challenge80.convert_adjacency_list_form_to_graph_expression_form(adjacency_list_form) ==
             graph_expression_form
  end
end
