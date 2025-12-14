defmodule Challenge93Test do
  use ExUnit.Case

  test "solution" do
    assert_raise RuntimeError, fn ->
      Challenge93.solutions([])
    end

    assert_raise RuntimeError, fn ->
      Challenge93.solutions([1])
    end

    result = Challenge93.solutions([10, 10])
    assert Helpers.check_two_enumerables_equal?(result, ["10==10"])

    result = Challenge93.solutions([2,3,5,7,11])
    assert Enum.member?(result, "2-3+5+7==11")
    assert Enum.member?(result, "2-3+5+7==11")
  end
end
