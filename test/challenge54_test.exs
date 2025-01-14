defmodule Challenge54Test do
  use ExUnit.Case

  test "is_tree" do
    assert Challenge54.is_tree(nil) == true
    assert Challenge54.is_tree([]) == false
    assert Challenge54.is_tree([:a, [:b, nil, nil], nil]) == true
    assert Challenge54.is_tree([:a, [:b, nil, nil]]) == false
    assert Challenge54.is_tree([:a, nil, nil]) == true
    assert Challenge54.is_tree([nil, nil, nil]) == false
  end
end
