defmodule Challenge88Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     graph: [
       ["b", "c", "d", "f", "g", "h", "k"],
       [["b", "c"], ["b", "f"], ["c", "f"], ["f", "k"], ["g", "h"]]
     ]}
  end

  test "connected_components", state do
    graph = state[:graph]

    assert Helpers.check_two_enumerables_equal?(
             Challenge88.get_graph_connected_components(graph),
             [["b", "c", "f", "k"], ["d"], ["g", "h"]]
           )

    assert Challenge88.get_graph_connected_components([[], []]) == []
    assert Challenge88.get_graph_connected_components([["a"], []]) == [["a"]]
    assert Challenge88.get_graph_connected_components([["a", "b"], [["a", "b"]]]) == [["a", "b"]]
  end
end
