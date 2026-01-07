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
             Helpers.normalize_edges(Challenge82.cycle(graph1, "w")),
             Helpers.normalize_edges([
               [["w", "x"], ["y", "x"], ["y", "z"], ["z", "w"]],
               [["w", "x"], ["y", "x"], ["w", "y"]],
               [["z", "w"], ["y", "z"], ["y", "x"], ["w", "x"]],
               [["z", "w"], ["y", "z"], ["w", "y"]],
               [["w", "y"], ["y", "x"], ["w", "x"]],
               [["w", "y"], ["y", "z"], ["z", "w"]]
             ])
           )

    assert Helpers.check_two_enumerables_equal?(
             Helpers.normalize_edges(Challenge82.cycle(graph1, "x")),
             Helpers.normalize_edges([
               [["w", "x"], ["w", "z"], ["y", "z"], ["x", "y"]],
               [["w", "x"], ["w", "y"], ["x", "y"]],
               [["x", "y"], ["y", "z"], ["w", "z"], ["w", "x"]],
               [["x", "y"], ["w", "y"], ["w", "x"]]
             ])
           )

    graph2 = state[:graph2]

    assert Helpers.check_two_enumerables_equal?(
             Helpers.normalize_edges(Challenge82.cycle(graph2, "f")),
             [
               [["b", "f"], ["b", "c"], ["c", "f"]],
               [["c", "f"], ["b", "c"], ["b", "f"]]
             ]
           )
  end
end
