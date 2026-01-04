defmodule Challenge85Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     non_isomorphic_graphs: [
       {
         [
           ["a", "b", "c", "d", "e", "f"],
           [["a", "b"], ["b", "c"], ["c", "d"], ["d", "e"], ["e", "f"], ["f", "a"], ["c", "f"]]
         ],
         [
           ["u", "v", "w", "x", "y", "z"],
           [["u", "v"], ["v", "w"], ["w", "x"], ["x", "y"], ["y", "z"], ["z", "u"], ["z", "v"]]
         ]
       }
     ],
     isomorphic_graphs: [
       {
         [
           ["a", "b", "c", "d", "e"],
           [["a", "b"], ["b", "c"], ["c", "d"], ["d", "e"], ["e", "a"]]
         ],
         [
           ["y", "v", "x", "z", "w"],
           [["y", "x"], ["y", "z"], ["v", "w"], ["v", "z"], ["x", "w"]]
         ]
       }
     ]}
  end

  test "isomorphic", state do
    should_be_isomorphic_graphs = state[:isomorphic_graphs]

    assert Enum.all?(should_be_isomorphic_graphs, fn {g1, g2} ->
             Challenge85.are_isomorphic?(g1, g2)
           end)
  end

  test "non_isomorphic", state do
    should_not_be_isomorphic_graphs = state[:non_isomorphic_graphs]

    assert Enum.all?(should_not_be_isomorphic_graphs, fn {g1, g2} ->
             !Challenge85.are_isomorphic?(g1, g2)
           end)
  end
end
