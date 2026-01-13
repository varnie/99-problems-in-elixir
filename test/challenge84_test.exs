# File: `test/challenge84_test.exs`
defmodule Challenge84Test do
  use ExUnit.Case

  test "ms_tree returns labelled graph with correct vertices and edges" do
    graph = [
      ["a", "b", "c", "d"],
      [
        ["a", "b", 1],
        ["a", "c", 3],
        ["b", "c", 1],
        ["b", "d", 4],
        ["c", "d", 2]
      ]
    ]

    [vs, es] = Challenge84.ms_tree(graph)

    expected_edges = [
      ["a", "b", 1],
      ["b", "c", 1],
      ["c", "d", 2]
    ]

    # vertices should equal the input vertex list
    assert vs == hd(graph)
    # edges are compared order-insensitively
    assert Enum.sort(es) == Enum.sort(expected_edges)
  end

  test "ms_tree_weight returns the total minimum weight" do
    graph1 = [
      ["a", "b", "c", "d"],
      [
        ["a", "b", 1],
        ["a", "c", 3],
        ["b", "c", 1],
        ["b", "d", 4],
        ["c", "d", 2]
      ]
    ]

    assert Challenge84.ms_tree_weight(graph1) == 4

    graph2 = [
      ["a", "b", "c", "d", "e", "f", "g", "h"],
      [
        ["a", "b", 5],
        ["a", "d", 3],
        ["b", "c", 2],
        ["b", "e", 4],
        ["c", "e", 6],
        ["d", "e", 7],
        ["d", "f", 4],
        ["d", "g", 3],
        ["e", "h", 5],
        ["f", "g", 4],
        ["g", "h", 1]
      ]
    ]

    assert Challenge84.ms_tree_weight(graph2) == 22
  end

  test "ms_tree raises on disconnected graph" do
    disconnected_graph = [
      ["a", "b", "c"],
      [
        ["a", "b", 1]
        # "c" is isolated
      ]
    ]

    assert_raise RuntimeError, "Graph is disconnected", fn ->
      Challenge84.ms_tree(disconnected_graph)
    end
  end

  test "ms_tree on graph with loop edges" do
    graph_with_loops = [
      ["a", "b", "c"],
      [
        ["a", "a", 2],  # loop edge
        ["a", "b", 1],
        ["b", "c", 3]
      ]
    ]

    [vs, es] = Challenge84.ms_tree(graph_with_loops)

    expected_edges = [
      ["a", "b", 1],
      ["b", "c", 3]
    ]

    assert vs == hd(graph_with_loops)
    assert Enum.sort(es) == Enum.sort(expected_edges)
  end
end
