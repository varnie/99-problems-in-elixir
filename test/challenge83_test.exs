defmodule Challenge83Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     graph: [
       ["a", "b", "c", "d", "e", "f", "g", "h"],
       [
         ["a", "b"],
         ["a", "d"],
         ["b", "c"],
         ["b", "e"],
         ["c", "e"],
         ["d", "e"],
         ["d", "f"],
         ["d", "g"],
         ["e", "h"],
         ["f", "g"],
         ["g", "h"]
       ]
     ]}
  end

  test "is_tree?", state do
    graph = state[:graph]
    assert !Challenge83.is_tree?(graph)

    assert Challenge83.is_tree?([[1,2], [[1,2]]]) == true
    assert Challenge83.is_tree?([["a","b","c","d","e"], [["a", "b"], ["a", "c"], ["a", "d"], ["a", "e"]]]) == true
  end

  test "is_connected?", state do
    graph = state[:graph]
    assert Challenge83.is_connected?(graph) == true
  end

  test "s_tree", state do
    graph = state[:graph]
    result = Challenge83.s_tree(graph)
    assert result |> length == 112
    assert result |> Enum.uniq |> length == 112
  end
end
