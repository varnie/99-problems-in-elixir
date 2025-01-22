defmodule Game do
  @board_axis_indexes 0..7
  @board_indexes 0..63

  def create_board() do
    Enum.reduce(0..7, Map.new(), fn x, acc_tmp ->
      board_tmp = acc_tmp

      Enum.reduce(0..7, board_tmp, fn y, acc ->
        Map.put(acc, x * 8 + y, {x, y})
      end)
    end)
  end

  # def solve2() do
  #   board = create_board()

  #   for a <- @board_indexes,
  #       b <- (a + 1)..63,
  #       c <- (b + 1)..63,
  #       d <- (c + 1)..63,
  #       e <- (d + 1)..63,
  #       f <- (e + 1)..63,
  #       g <- (f + 1)..63,
  #       h <- (g + 1)..63,
  #       suitable_positions(
  #         board[a],
  #         board[b],
  #         board[c],
  #         board[d],
  #         board[e],
  #         board[f],
  #         board[g],
  #         board[h]
  #       ),
  #       do: [board[a], board[b], board[c], board[d], board[e], board[f], board[g], board[h]]
  # end

  # def get_valid_continuations(board, cur_queens, cur_index) do
  #   if (cur_index + 1) in @board_indexes do
  #     new_possible_indexes =
  #       Enum.reduce((cur_index + 1)..63, [], fn x, acc ->
  #         new_queen = board[x]

  #         if is_suitable_place_for_new_queen(cur_queens, new_queen) do
  #           # acc stores new indexes
  #           acc ++ [x]
  #         else
  #           acc
  #         end
  #       end)

  #     if new_possible_indexes == [] do
  #       cur_queens
  #     else
  #       result =
  #         Enum.map(new_possible_indexes, fn index ->
  #           new_queen = board[index]
  #           new_cur_queens = cur_queens ++ [new_queen]
  #           new_cur_queens = get_valid_continuations(board, new_cur_queens, index)
  #           new_cur_queens
  #         end)

  #       result
  #     end
  #   else
  #     cur_queens
  #   end
  # end

  # def solve1() do
  #   board = create_board()

  #   start_time = System.monotonic_time(:second)
  #   IO.puts("Started at: #{start_time} seconds")

  #   result =
  #     for a <- 0..63//8,
  #         b <- 1..63//8,
  #         c <- 2..63//8,
  #         d <- 3..63//8,
  #         e <- 4..63//8,
  #         f <- 5..63//8,
  #         g <- 6..63//8,
  #         h <- 7..63//8,
  #         # length(
  #         #   Enum.uniq_by([a, b, c, d, e, f, g, h], fn queen ->
  #         #     div(queen, 8)
  #         #   end)
  #         # ) == 8,
  #         suitable_positions(
  #           board[a],
  #           board[b],
  #           board[c],
  #           board[d],
  #           board[e],
  #           board[f],
  #           board[g],
  #           board[h]
  #         ),
  #         do: [board[a], board[b], board[c], board[d], board[e], board[f], board[g], board[h]]

  #   end_time = System.monotonic_time(:second)
  #   IO.puts("Ended at: #{end_time} seconds")
  #   IO.puts("Execution time: #{end_time - start_time} seconds")
  #   result
  # end

  def solve() do
    board = create_board()

    start_time = System.monotonic_time(:second)
    IO.puts("Started at: #{start_time} seconds")

    result =
      for a <- 0..63//8,
          b <- 1..63//8,
          c <- 2..63//8,
          d <- 3..63//8,
          e <- 4..63//8,
          f <- 5..63//8,
          g <- 6..63//8,
          h <- 7..63//8,
          length(
            Enum.uniq_by([a, b, c, d, e, f, g, h], fn queen ->
              div(queen, 8)
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

    end_time = System.monotonic_time(:second)
    IO.puts("Ended at: #{end_time} seconds")
    IO.puts("Execution time: #{end_time - start_time} seconds")
    result
  end

  def suitable_positions(pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8) do
    is_suitable_place_for_new_queen([pos1], pos2) and
      is_suitable_place_for_new_queen([pos1, pos2], pos3) and
      is_suitable_place_for_new_queen([pos1, pos2, pos3], pos4) and
      is_suitable_place_for_new_queen([pos1, pos2, pos3, pos4], pos5) and
      is_suitable_place_for_new_queen([pos1, pos2, pos3, pos4, pos5], pos6) and
      is_suitable_place_for_new_queen([pos1, pos2, pos3, pos4, pos5, pos6], pos7) and
      is_suitable_place_for_new_queen([pos1, pos2, pos3, pos4, pos5, pos6, pos7], pos8)
  end

  def is_suitable_place_for_new_queen(present_queens, {queen_x, queen_y} = queen) do
    Enum.all?(present_queens, fn {present_queen_x, present_queen_y} = present_queen ->
      cond do
        # occupied by some already placed queen
        queen == present_queen -> false
        # hits vertically
        queen_x == present_queen_x -> false
        # hits horizontally
        queen_y == present_queen_y -> false
        # now we need to check if board_queen hits new queen on diagonals, and if not, then this place is suitable
        true -> check_if_new_queen_is_not_hit_by_present_queen(present_queen, queen)
      end
    end)
  end

  defp check_if_new_queen_is_not_hit_by_present_queen(
         present_queen,
         new_queen
       ) do
    # returns true if it is not hit by the present queen

    # left deck's corner is (0, 0)

    inc_fn = fn x -> x + 1 end
    dec_fn = fn x -> x - 1 end

    modify_pos_builder_fn = fn xfnmod, yfnmod -> fn {x, y} -> {xfnmod.(x), yfnmod.(y)} end end

    is_within_gamefield_fn? = fn {x, y} ->
      x in @board_axis_indexes and y in @board_axis_indexes
    end

    leftx_upy_modify_fn = modify_pos_builder_fn.(dec_fn, inc_fn)
    rightx_upy_modify_fn = modify_pos_builder_fn.(inc_fn, inc_fn)

    leftx_downy_modify_fn = modify_pos_builder_fn.(dec_fn, dec_fn)
    rightx_downy_modify_fn = modify_pos_builder_fn.(inc_fn, dec_fn)

    pred_fn = fn item -> item != present_queen end

    check_while = fn while_fn, pred_fn, modify_val_fn ->
      fn me, val ->
        if !while_fn.(val) do
          true
        else
          if !pred_fn.(val) do
            false
          else
            me.(me, modify_val_fn.(val))
          end
        end
      end
    end

    check_while_leftx_upy_instance_fn =
      check_while.(is_within_gamefield_fn?, pred_fn, leftx_upy_modify_fn)

    check_while_rightx_upy_modify_fn =
      check_while.(is_within_gamefield_fn?, pred_fn, rightx_upy_modify_fn)

    check_while_leftx_downy_modify_fn =
      check_while.(is_within_gamefield_fn?, pred_fn, leftx_downy_modify_fn)

    check_while_rightx_downy_modify_fn =
      check_while.(is_within_gamefield_fn?, pred_fn, rightx_downy_modify_fn)

    check_while_leftx_upy_instance_fn.(check_while_leftx_upy_instance_fn, new_queen) and
      check_while_rightx_upy_modify_fn.(check_while_rightx_upy_modify_fn, new_queen) and
      check_while_leftx_downy_modify_fn.(check_while_leftx_downy_modify_fn, new_queen) and
      check_while_rightx_downy_modify_fn.(check_while_rightx_downy_modify_fn, new_queen)
  end
end
