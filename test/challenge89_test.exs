defmodule Challenge89Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     bipartite_graph: [
       ["a", "b", "c", "d"],
       [
         ["a", "c"],
         ["a", "d"],
         ["b", "c"],
         ["b", "d"]
       ]
     ]}
  end

  test "is_bipartite on bipartite graphs", state do
    assert Challenge89.is_bipartite([["a", "b"], [["a", "b"]]]) == true

    graph = state[:bipartite_graph]
    assert Challenge89.is_bipartite(graph) == true

    assert Challenge89.is_bipartite([
             ["a", "b", "c", "1", "2", "3"],
             [["a", "1"], ["b", "2"], ["c", "3"]]
           ]) == true
  end

  test "is_not_bipartite on non-bipartite graph" do
    assert Challenge89.is_bipartite([[], []]) == false
    assert Challenge89.is_bipartite([["a"], []]) == false
    assert Challenge89.is_bipartite([["a", "b", "c"], [["a", "b"]]]) == false

    non_bipartite_graph = [
      ["a", "b", "c"],
      [["a", "b"], ["b", "c"], ["c", "a"]]
    ]

    assert Challenge89.is_bipartite(non_bipartite_graph) == false
  end
end
