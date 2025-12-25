defmodule Challenge87Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     graph1: [["a"], []],
     graph2: [
       ["b", "c", "d", "f", "g", "h", "k", "X"],
       [["b", "c"], ["b", "f"], ["b", "X"], ["c", "f"], ["f", "k"], ["g", "h"]]
     ]}
  end

  test "graph_traversal_depth_first_orde", state do
    graph1 = state[:graph1]
    assert Challenge87.graph_traversal_depth_first_order(graph1, "a") == ["a"]

    graph2 = state[:graph2]
    assert_raise RuntimeError, fn ->
      assert Challenge87.graph_traversal_depth_first_order(graph2, "nonexistent")
    end

    assert Challenge87.graph_traversal_depth_first_order(graph2, "b") == ["b", "c", "f", "k", "X", "d", "g", "h"]

    assert Challenge87.graph_traversal_depth_first_order(graph2, "f") == ["f", "k", "b", "c", "X", "d", "g", "h"]
  end
end
