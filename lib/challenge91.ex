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
    {_tag, vals} = solve_helper([coords])
    vals
  end

  defp solve_helper(solution) when length(solution) == 64, do: {:stop, solution}

  defp solve_helper(solution = [h | _rest]) do
    possible_jumps = jumps(h) |> Enum.reject(fn ps -> ps in solution end)

    Enum.reduce_while(possible_jumps, nil, fn val, acc ->
      case acc do
        {:stop, solution} ->
          {:halt, {:stop, solution}}

        _ ->
          case solve_helper([val | solution]) do
            {:stop, result} -> {:halt, {:stop, result}}
            _ -> {:cont, acc}
          end
      end
    end)
  end

  defp is_within_gamefield_fn?({x, y}) do
    x in 1..8 and y in 1..8
  end

  def jumps({x, y} = _coordinate) do
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
