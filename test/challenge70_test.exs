defmodule Challenge70Test do
  use ExUnit.Case

  test "is_tree" do
    assert Challenge70.is_tree(nil) == false
    assert Challenge70.is_tree([]) == false
    assert Challenge70.is_tree([:a]) == false
    assert Challenge70.is_tree([:a, []]) == false
    assert Challenge70.is_tree([:a, :b]) == true
    assert Challenge70.is_tree([:a, [:b]]) == false
    assert Challenge70.is_tree([:a, [:b, :c]]) == true
    assert Challenge70.is_tree([:a, [:b, :c], :d]) == true
    assert Challenge70.is_tree(:a) == true
  end

  test "nnodes" do
    assert Challenge70.nnodes([:a, :b]) == 2
    assert Challenge70.nnodes([:a, [:b, :c]]) == 3
    assert Challenge70.nnodes([:a, [:b, :c], :d]) == 4
    assert Challenge70.nnodes(:a) == 1
  end
end
