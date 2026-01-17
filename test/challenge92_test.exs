defmodule Challenge92Test do
  use ExUnit.Case

  test "solve" do
    g = [
      ["a", "b", "c", "d", "e", "f", "g"],
      [["a", "d"], ["a", "g"], ["a", "b"], ["e", "b"], ["e", "f"], ["b", "c"]]
    ]

    _g2 = [
      ["a", "b", "c", "d", "e", "f", "g", "h", "i", "k", "m", "n", "p", "q"],
      [
        ["a", "b"],
        ["a", "c"],
        ["a", "h"],
        ["a", "i"],
        ["a", "g"],
        ["d", "c"],
        ["d", "k"],
        ["e", "q"],
        ["e", "c"],
        ["f", "c"],
        ["q", "m"],
        ["q", "n"],
        ["p", "n"]
      ]
    ]

    validate_solution_for_graph(g)
    #validate_solution_for_graph(g2)
  end

  defp validate_solution_for_graph(g) do
    [nodes, _edges] = g

    result = Challenge92.solve(g)

    assert !is_nil(result)
    {nodes_numbered_map, edges_numbered_map} = result
    assert map_size(nodes_numbered_map) == length(nodes)
    assert map_size(edges_numbered_map) == length(nodes) - 1

    nodes_numbered_map_keys = Map.keys(nodes_numbered_map)
    edges_numbered_map_keys = Map.keys(edges_numbered_map)

    assert length(Enum.uniq(nodes_numbered_map_keys)) == length(nodes)
    assert length(Enum.uniq(edges_numbered_map_keys)) == length(nodes) - 1

    assert Enum.all?(edges_numbered_map, fn {k, v} ->
             [a, b] = String.split(k, "_")

             cond do
               !(a in nodes_numbered_map_keys) -> false
               !(b in nodes_numbered_map_keys) -> false
               true -> abs(Map.get(nodes_numbered_map, a) - Map.get(nodes_numbered_map, b)) == v
             end
           end)
  end
end
