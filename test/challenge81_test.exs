defmodule Challenge81Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     graph1: [
       ["w", "x", "y", "z"],
       [["w", "x"], ["x", "y"], ["y", "z"], ["z", "w"], ["w", "y"]]
     ],
     graph2: [
       ["b", "c", "d", "f", "g", "h", "k"],
       [["b", "c"], ["b", "f"], ["c", "f"], ["f", "k"], ["g", "h"]]
     ]}
  end

  test "path", state do
    graph1 = state[:graph1]
    assert Challenge81.path(graph1, "nonexistent", "w") == []
    assert Challenge81.path(graph1, "w", "w") == []

    assert Helpers.check_two_enumerables_equal?(
             Challenge81.path(graph1, "w", "y"),
             [[["w", "x"], ["x", "y"]], [["z", "w"], ["y", "z"]], [["w", "y"]]]
           )

    assert Helpers.check_two_enumerables_equal?(
             Challenge81.path(graph1, "y", "w"),
             [[["x", "y"], ["w", "x"]], [["y", "z"], ["z", "w"]], [["w", "y"]]]
           )

    graph2 = state[:graph2]

    assert Helpers.check_two_enumerables_equal?(
             Challenge81.path(graph2, "b", "k"),
             [[["b", "c"], ["c", "f"], ["f", "k"]], [["b", "f"], ["f", "k"]]]
           )

    assert Helpers.check_two_enumerables_equal?(
             Challenge81.path(graph2, "b", "g"),
             []
           )

    graph = [[1, 2, 3], [[1, 2], [2, 1]]]
    assert Challenge81.path(graph, 1, 2) != []
    assert Challenge81.path(graph, 1, 3) == []

    graph = [
      ["b", "c", "f", "k"],
      [["b", "c"], ["b", "f"], ["c", "f"], ["f", "k"]]
    ]

    assert Challenge81.path(graph, "b", "c") == [[["b", "c"]], [["b", "f"], ["c", "f"]]]

    assert Helpers.check_two_enumerables_equal?(
             Challenge81.path(graph, "b", "f"),
             [[["b", "c"], ["c", "f"]], [["b", "f"]]]
           )

    graph = [[1, 2, 3, 4], [[1, 2], [3, 4], [1, 3]]]
    assert Challenge81.path(graph, 1, 2) == [[[1, 2]]]

    assert Challenge81.path(graph, 2, 1) in [
             [[[1, 2]]],
             [[[2, 1]]]
           ]
  end
end
