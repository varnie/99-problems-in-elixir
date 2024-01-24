defmodule Challenge40Test do
  use ExUnit.Case

  test "goldbach" do
    assert is_nil(Challenge40.goldbach(3))
    assert Challenge40.goldbach(28) == {5, 23}
    assert Challenge40.goldbach(1928) == {61, 1867}
  end
end
