defmodule Challenge93Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     result_list: [
       "2=3-(5+7)+11",
       "2=3-(5+7-11)",
       "2=3-5-7+11",
       "2=3-5-(7-11)",
       "2=(3*5+7)/11",
       "2*(3-5)=7-11",
       "2-3+5+7=11",
       "2-(3-5)+7=11",
       "2-(3-5-7)=11"
     ]}
  end

  test "solutions", state do
    assert_raise RuntimeError, fn ->
      Challenge93.solutions([])
    end

    assert_raise RuntimeError, fn ->
      Challenge93.solutions([1])
    end

    result = Challenge93.solutions([10, 10])
    assert result == ["10=10"]

    result = Challenge93.solutions([2, 3, 5, 7, 11])

    assert Helpers.check_two_enumerables_equal?(result, state[:result_list])
  end
end
