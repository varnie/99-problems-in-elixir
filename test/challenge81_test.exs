defmodule Challenge81Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     graph1: [
       ["w", "x", "y", "z"],
       [["w", "x"], ["x", "y"], ["y", "z"], ["z", "w"], ["w", "y"]]
     ],
     graph2: [
       ["w", "x", "y", "z"],
       [["w", "x"], ["x", "y"], ["y", "z"], ["z", "w"], ["w", "y"]]
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

    graph2 = state[:graph2]
    assert Helpers.check_two_enumerables_equal?(
             Challenge81.path(graph2, "z", "y"),
             [[["z", "w"], ["w", "x"], ["x", "y"]], [["z", "w"], ["w", "y"]]]
           )

   assert Helpers.check_two_enumerables_equal?(
             Challenge81.path(graph2, "y", "w"),
             [[["y", "z"], ["z", "w"]]]
           )
  end
end
