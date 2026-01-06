defmodule Challenge91 do
  @moduledoc """
  (**) Knight's tour
     Another famous problem is this one: How can a knight jump on an NxN chessboard in such a way
     that it visits every square exactly once?

     Hints: Represent the squares by pairs of their coordinates of the form (X Y),
     where both X and Y are integers between 1 and N. Define a function (jump N (X Y))
     that returns a list of the positions (U V) such that a knight can jump
     from (X Y) to (U V) on a NxN chessboard.
     And finally, represent the solution of our problem as a list
     of N*N knight positions (the knight's tour).
  """

  def solve() do
    coords = index_to_coordinates(1)
    {_, result} = gen_solution([coords], coords, 1)
    result
  end

  defp gen_solution(solution, head, len) do
    if len == 64 do
      {true, solution}
    else
      possible_jumps = jumps(head) |> Enum.reject(fn ps -> ps in solution end)
      try_jumps(solution, len, possible_jumps)
    end
  end

  defp try_jumps(_acc, _len, []) do
    {false, nil}
  end

  defp try_jumps(acc, len, [jump_head | jumps_tail]) do
    case gen_solution([jump_head | acc], jump_head, len + 1) do
      {false, _} -> try_jumps(acc, len, jumps_tail)
      result -> result
    end
  end

  defp is_within_gamefield_fn?({x, y}) do
    x in 1..8 and y in 1..8
  end

  def jumps({x, y}) do
    test1 = {x + 1, y + 2}
    test2 = {x + 2, y + 1}
    test3 = {x + 2, y - 1}
    test4 = {x + 1, y - 2}
    test5 = {x - 1, y - 2}
    test6 = {x - 2, y - 1}
    test7 = {x - 2, y + 1}
    test8 = {x - 1, y + 2}

    Enum.filter(
      [test1, test2, test3, test4, test5, test6, test7, test8],
      &is_within_gamefield_fn?/1
    )
  end

  def index_to_coordinates(index) do
    remainder = rem(index, 8)

    y = if remainder > 0, do: div(index, 8) + 1, else: div(index, 8)
    x = if remainder > 0, do: remainder, else: 8

    {x, y}
  end
end
