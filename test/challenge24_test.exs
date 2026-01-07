defmodule Challenge24Test do
  use ExUnit.Case

  test "rnd_select" do
    desired_size = 6
    count = 49

    result = Challenge24.rnd_select(desired_size, count)
    assert length(result) == desired_size
    assert length(Enum.uniq(result)) == desired_size
    assert Enum.all?(result, &(&1 in 1..count))
  end
end
