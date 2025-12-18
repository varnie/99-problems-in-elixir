defmodule Challenge93SecondSolutionTest do
  use ExUnit.Case

  test "solutions" do
    assert_raise RuntimeError, fn ->
      Challenge93SecondSolution.solutions([])
    end

    assert_raise RuntimeError, fn ->
      Challenge93SecondSolution.solutions([1])
    end

    result = Challenge93SecondSolution.solutions([10, 10])
    assert result == ["10=10"]

    result = Challenge93SecondSolution.solutions([2, 3, 5, 7, 11])

    assert Enum.member?(result, "2=3-5-7+11")
    assert Enum.member?(result, "2=(3*5+7)/11")
    assert Enum.member?(result, "2*(3-5)=7-11")
    assert Enum.member?(result, "2-3+5+7=11")
  end
end
