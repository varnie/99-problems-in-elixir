defmodule Challenge90Another do
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

  defp create_board() do
    Enum.reduce(@board_axis_indexes, Map.new(), fn x, acc_tmp ->
      board_tmp = acc_tmp

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
        suitable_positions(
          board[a],
          board[b],
          board[c],
          board[d],
          board[e],
          board[f],
          board[g],
          board[h]
        ),
        do: [board[a], board[b], board[c], board[d], board[e], board[f], board[g], board[h]]
  end

  defp suitable_positions(pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8) do
    result =
      Enum.reduce_while([pos2, pos3, pos4, pos5, pos6, pos7, pos8], [pos1], fn val, acc ->
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

  defp is_within_gamefield_fn({x, y}) do
    x in @board_axis_indexes and y in @board_axis_indexes
  end

  defp check_if_new_queen_is_not_hit_by_present_queen(
         present_queen,
         new_queen
       ) do
    # returns true if it is not hit by the present queen
    # left bottom deck's corner is (1, 1)

    move_leftx_upy_corner_stream = Stream.iterate(new_queen, fn {x, y} -> {x - 1, y + 1} end)
    move_rightx_upy_corner_stream = Stream.iterate(new_queen, fn {x, y} -> {x + 1, y + 1} end)
    move_leftx_downy_corner_stream = Stream.iterate(new_queen, fn {x, y} -> {x - 1, y - 1} end)
    move_rightx_downy_corner_stream = Stream.iterate(new_queen, fn {x, y} -> {x + 1, y - 1} end)

    reduce_stream_fn = fn stream ->
      Enum.reduce_while(stream, true, fn val, acc ->
        cond do
          !is_within_gamefield_fn(val) -> {:halt, acc}
          val == present_queen -> {:halt, false}
          true -> {:cont, true}
        end
      end)
    end

    Enum.all?(
      [
        move_leftx_upy_corner_stream,
        move_rightx_upy_corner_stream,
        move_leftx_downy_corner_stream,
        move_rightx_downy_corner_stream
      ],
      reduce_stream_fn
    )
  end
end
