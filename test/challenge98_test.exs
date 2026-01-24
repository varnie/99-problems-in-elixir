defmodule Challenge98Test do
  use ExUnit.Case

  test "solve returns valid solutions" do
    solutions = Challenge98.solve()
    assert is_list(solutions)
    assert length(solutions) > 0

    for sol <- solutions do
      assert length(sol) == 9

      for row <- sol do
        assert length(row) == 8
        assert Enum.all?(row, fn cell -> cell in [0, 1] end)
      end
    end

    expected = [
      [0, 1, 1, 1, 0, 0, 0, 0],
      [1, 1, 0, 1, 0, 0, 0, 0],
      [0, 1, 1, 1, 0, 0, 1, 1],
      [0, 0, 1, 1, 0, 0, 1, 1],
      [0, 0, 1, 1, 1, 1, 1, 1],
      [1, 0, 1, 1, 1, 1, 1, 0],
      [1, 1, 1, 1, 1, 1, 0, 0],
      [0, 0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 1, 1, 0, 0, 0]
    ]

    assert Enum.member?(solutions, expected)
  end
end
