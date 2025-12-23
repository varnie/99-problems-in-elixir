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
             [[["w", "x"], ["x", "y"]], [["w", "y"]]]
           )

    assert Helpers.check_two_enumerables_equal?(
             Challenge81.path(graph1, "y", "w"),
             [[["y", "z"], ["z", "w"]]]
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
  end
end
