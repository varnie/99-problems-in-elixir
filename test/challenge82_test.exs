defmodule Challenge82Test do
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

  test "cycle", state do
    graph1 = state[:graph1]

    assert Challenge82.cycle(graph1, "nonexistent") == []

    assert Helpers.check_two_enumerables_equal?(
             Challenge82.cycle(graph1, "w"),
             [
               [["w", "x"], ["x", "y"], ["y", "z"], ["z", "w"]],
               [["w", "y"], ["y", "z"], ["z", "w"]]
             ]
           )

    assert Helpers.check_two_enumerables_equal?(
             Challenge82.cycle(graph1, "x"),
             [[["x", "y"], ["y", "z"], ["z", "w"], ["w", "x"]]]
           )

    graph2 = state[:graph1]

    assert Helpers.check_two_enumerables_equal?(
             Challenge82.cycle(graph2, "f"),
             []
           )
  end
end
