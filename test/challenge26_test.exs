defmodule Challenge26Test do
  use ExUnit.Case

  test "combinations" do
    lst = ["a", "b", "c", "d", "e", "f"]
    result = Challenge26.combinations(3, lst)

    correct_result = [
      ["a", "b", "c"],
      ["a", "b", "d"],
      ["a", "b", "e"],
      ["a", "b", "f"],
      ["a", "c", "d"],
      ["a", "c", "e"],
      ["a", "c", "f"],
      ["a", "d", "e"],
      ["a", "d", "f"],
      ["a", "e", "f"],
      ["b", "c", "d"],
      ["b", "c", "e"],
      ["b", "c", "f"],
      ["b", "d", "e"],
      ["b", "d", "f"],
      ["b", "e", "f"],
      ["c", "d", "e"],
      ["c", "d", "f"],
      ["c", "e", "f"],
      ["d", "e", "f"]
    ]

    assert Enum.sort(result) == Enum.sort(correct_result)

    assert length(Challenge26.combinations(3, Enum.to_list(1..12))) == 220
  end
end
