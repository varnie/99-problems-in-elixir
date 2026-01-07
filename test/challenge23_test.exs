defmodule Challenge23Test do
  use ExUnit.Case

  setup_all do
    {:ok, test_list: Enum.to_list(1..10)}
  end

  test "rnd_select", state do
    desired_size = state[:test_list] |> length |> div(2)

    result = Challenge23.rnd_select(state[:test_list], desired_size)
    assert length(result) == desired_size
    assert length(Enum.uniq(result)) == desired_size
    assert Enum.all?(result, &(&1 in state[:test_list]))
  end
end
