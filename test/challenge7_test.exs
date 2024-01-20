defmodule Challenge7Test do
  use ExUnit.Case

  test "flatten" do
    assert Challenge7.flatten(["a", ["b", ["c", "d"], "e"]]) == ["a", "b", "c", "d", "e"]
    assert Challenge7.flatten([]) == []
    assert Challenge7.flatten([[["a"]]]) == ["a"]
  end

  test "my_flatten" do
    assert Challenge7.my_flatten(["a", ["b", ["c", "d"], "e"]]) == ["a", "b", "c", "d", "e"]
    assert Challenge7.my_flatten([]) == []
    assert Challenge7.my_flatten([[["a"]]]) == ["a"]
  end
end
