defmodule Challenge86Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     graph: [
       ["b", "c", "d", "f", "g", "h", "k", "X"],
       [["b", "c"], ["b", "f"], ["b", "X"], ["c", "f"], ["f", "k"], ["g", "h"]]
     ]}
  end

  test "degree", state do
    graph = state[:graph]
    assert Challenge86.degree(graph, "b") == 3
    assert Challenge86.degree(graph, "X") == 1
  end

  test "all_nodes_sorted_by_decreasing_degree", state do
    graph = state[:graph]
    assert Challenge86.all_nodes_sorted_by_decreasing_degree(graph) == ["b", "f", "c", "g", "h", "k", "X", "d"]
  end

  test "paint", state do
    graph = state[:graph]
    assert Challenge86.paint(graph) == %{"k" => 1, "X" => 2, "b" => 1, "c" => 3, "d" => 1, "f" => 2, "g" => 1, "h" => 1}
  end
end
