defmodule Challenge90 do
  @moduledoc """
    (**) Eight queens problem
        This is a classical problem in computer science.
        The objective is to place eight queens on a chessboard so that no two queens are attacking each other;
        i.e., no two queens are in the same row, the same column, or on the same diagonal.

        Hint: Represent the positions of the queens as a list of numbers 1..N.
        Example: (4 2 7 3 6 8 5 1) means that the queen in the first column is in row 4,
        the queen in the second column is in row 2, etc.
        Use the generate-and-test paradigm.
  """

  @board_axis_indexes 1..8
  @letters Map.new(Enum.zip(@board_axis_indexes, [:a, :b, :c, :d, :e, :f, :g, :h]))

  defp create_board() do
    Enum.reduce(@board_axis_indexes, Map.new(), fn x, board_tmp ->
      Enum.reduce(@board_axis_indexes, board_tmp, fn y, acc ->
        Map.put(acc, (x - 1) * 8 + y, {x, y})
      end)
    end)
  end

  def solve() do
    board = create_board()

    for a <- 1..64//8,
        b <- 2..64//8,
        c <- 3..64//8,
        d <- 4..64//8,
        e <- 5..64//8,
        f <- 6..64//8,
        g <- 7..64//8,
        h <- 8..64//8,
        length(
          Enum.uniq_by([a, b, c, d, e, f, g, h], fn queen ->
            div(queen - 1, 8)
          end)
        ) == 8,
        positions = Enum.map([a, b, c, d, e, f, g, h], fn index -> board[index] end),
        suitable_positions(positions),
        do:
          Enum.map(positions, fn {x, y} ->
            {@letters[x], y}
          end)
  end

  defp suitable_positions(positions) do
    result =
      Enum.reduce_while(positions, [], fn val, acc ->
        if is_suitable_place_for_new_queen(acc, val) do
          {:cont, [val | acc]}
        else
          {:halt, nil}
        end
      end)

    !is_nil(result)
  end

  defp is_suitable_place_for_new_queen(present_queens, queen) do
    Enum.all?(present_queens, fn present_queen ->
      check_if_new_queen_is_not_hit_by_present_queen(present_queen, queen)
    end)
  end

  defp check_if_new_queen_is_not_hit_by_present_queen(
         present_queen,
         new_queen
       ) do
    # returns true if it is not hit by the present queen
    # left bottom deck's corner is (1, 1)

    pred_fn = fn item -> item != present_queen end

    check_while_leftx_upy_instance_fn =
      check_while(&is_within_gamefield?/1, pred_fn, &leftx_upy_modify/1)

    check_while_rightx_upy_modify_fn =
      check_while(&is_within_gamefield?/1, pred_fn, &rightx_upy_modify/1)

    check_while_leftx_downy_modify_fn =
      check_while(&is_within_gamefield?/1, pred_fn, &leftx_downy_modify/1)

    check_while_rightx_downy_modify_fn =
      check_while(&is_within_gamefield?/1, pred_fn, &rightx_downy_modify/1)

    check_while_leftx_upy_instance_fn.(check_while_leftx_upy_instance_fn, new_queen) and
      check_while_rightx_upy_modify_fn.(check_while_rightx_upy_modify_fn, new_queen) and
      check_while_leftx_downy_modify_fn.(check_while_leftx_downy_modify_fn, new_queen) and
      check_while_rightx_downy_modify_fn.(check_while_rightx_downy_modify_fn, new_queen)
  end

  defp check_while(while_fn, pred_fn, modify_val_fn) do
    fn me, val ->
      cond do
        !while_fn.(val) -> true
        !pred_fn.(val) -> false
        true -> me.(me, modify_val_fn.(val))
      end
    end
  end

  defp is_within_gamefield?({x, y}), do: x in @board_axis_indexes and y in @board_axis_indexes

  defp leftx_upy_modify({x, y}), do: {x - 1, y + 1}
  defp rightx_upy_modify({x, y}), do: {x + 1, y + 1}
  defp leftx_downy_modify({x, y}), do: {x - 1, y - 1}
  defp rightx_downy_modify({x, y}), do: {x + 1, y - 1}
end
