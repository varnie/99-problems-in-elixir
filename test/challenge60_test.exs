defmodule Challenge60Test do
  use ExUnit.Case
  doctest Challenge1

  test "min_nodes" do
    assert Challenge60.min_nodes(0) == 0
    assert Challenge60.min_nodes(1) == 1
    assert Challenge60.min_nodes(2) == 2
    assert Challenge60.min_nodes(3) == 4
    assert Challenge60.min_nodes(10) == 143
  end

  test "max_height" do
    assert Challenge60.max_height(0) == 0
    assert Challenge60.max_height(1) == 1
    assert Challenge60.max_height(2) == 2
    assert Challenge60.max_height(4) == 3
    assert Challenge60.max_height(10) == 4
  end
end
