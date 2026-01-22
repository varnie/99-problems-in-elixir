defmodule Challenge97 do
  @moduledoc """
  P97 (**) Sudoku
   Sudoku puzzles go like this:

   Problem statement                 Solution

    .  .  4 | 8  .  . | .  1  7	     9  3  4 | 8  2  5 | 6  1  7
            |         |                      |         |
    6  7  . | 9  .  . | .  .  .	     6  7  2 | 9  1  4 | 8  5  3
            |         |                      |         |
    5  .  8 | .  3  . | .  .  4      5  1  8 | 6  3  7 | 9  2  4
    --------+---------+--------      --------+---------+--------
    3  .  . | 7  4  . | 1  .  .      3  2  5 | 7  4  8 | 1  6  9
            |         |                      |         |
    .  6  9 | .  .  . | 7  8  .      4  6  9 | 1  5  3 | 7  8  2
            |         |                      |         |
    .  .  1 | .  6  9 | .  .  5      7  8  1 | 2  6  9 | 4  3  5
    --------+---------+--------      --------+---------+--------
    1  .  . | .  8  . | 3  .  6	     1  9  7 | 5  8  2 | 3  4  6
            |         |                      |         |
    .  .  . | .  .  6 | .  9  1	     8  5  3 | 4  7  6 | 2  9  1
            |         |                      |         |
    2  4  . | .  .  1 | 5  .  .      2  4  6 | 3  9  1 | 5  7  8


    Every spot in the puzzle belongs to a (horizontal) row and a (vertical) column, as well as to one single 3x3 square
    (which we call "square" for short). At the beginning, some of the spots carry a single-digit number between 1 and 9.
    The problem is to fill the missing spots with digits in such a way that every number between 1 and 9 appears
    exactly once in each row, in each column, and in each square.
  """

  @src [
    [0, 0, 4, 8, 0, 0, 0, 1, 7],
    [6, 7, 0, 9, 0, 0, 0, 0, 0],
    [5, 0, 8, 0, 3, 0, 0, 0, 4],
    [3, 0, 0, 7, 4, 0, 1, 0, 0],
    [0, 6, 9, 0, 0, 0, 7, 8, 0],
    [0, 0, 1, 0, 6, 9, 0, 0, 5],
    [1, 0, 0, 0, 8, 0, 3, 0, 6],
    [0, 0, 0, 0, 0, 6, 0, 9, 1],
    [2, 4, 0, 0, 0, 1, 5, 0, 0]
  ]

  defp check_all_lines_have_unique_vals?(lines) do
    Enum.all?(lines, fn line ->
      line_without_zeros = Enum.filter(line, &(&1 != 0))
      length(line_without_zeros) == length(Enum.uniq(line_without_zeros))
    end)
  end

  defp check_all_vertical_lines_valid?(lst) do
    vertical_lines =
      Enum.map(0..8, fn index ->
        Enum.map(lst, fn line ->
          Enum.at(line, index)
        end)
      end)

    check_all_lines_have_unique_vals?(vertical_lines)
  end

  defp check_new_line_is_a_good_candidate?(new_line, line_index) do
    src_list_with_updated_line = List.replace_at(@src, line_index, new_line)
    check_all_vertical_lines_valid?(src_list_with_updated_line)
  end

  def solve() do
    numbers = MapSet.new(Enum.to_list(1..9))

    list_of_missed_vals =
      @src
      |> Enum.map(fn cur_lst ->
        present_numbers = Enum.filter(cur_lst, &(&1 != 0))
        diff = MapSet.difference(numbers, MapSet.new(present_numbers))
        MapSet.to_list(diff)
      end)

    possible_lists_of_missed_vals_permutations =
      Enum.map(list_of_missed_vals, &Helpers.permutations_without_repetitions/1)

    #    possible_list_of_missed_vals_permutations:
    #    [
    #      [
    #        [3, 6, 7, 8, 9],
    #        [3, 6, 7, 9, 8],
    #        ...
    #      ],
    #      [
    #        [2, 3, 4, 5, 7, 8],
    #        [2, 3, 4, 5, 8, 7],
    #        ...
    #      ],
    #      ...
    #    ]

    possible_line_permutations =
      possible_lists_of_missed_vals_permutations
      |> Enum.with_index()
      |> Enum.map(fn {update_lines, line_index} ->
        cur_line = Enum.at(@src, line_index)

        for update_line <- update_lines,
            {new_line, _} =
              Enum.reduce(cur_line, {[], update_line}, fn x, acc ->
                {cur_acc_result, cur_update_line} = acc

                if x == 0 do
                  [cur_update_line_head | cur_update_line_tail] = cur_update_line
                  {cur_acc_result ++ [cur_update_line_head], cur_update_line_tail}
                else
                  {cur_acc_result ++ [x], cur_update_line}
                end
              end),
            check_new_line_is_a_good_candidate?(new_line, line_index) do
          new_line
        end
      end)

    for a <- Enum.at(possible_line_permutations, 0),
        b <- Enum.at(possible_line_permutations, 1),
        c <- Enum.at(possible_line_permutations, 2),
        check_requirements_satisfied?([a, b, c]),
        d <- Enum.at(possible_line_permutations, 3),
        e <- Enum.at(possible_line_permutations, 4),
        f <- Enum.at(possible_line_permutations, 5),
        check_requirements_satisfied?([a, b, c, d, e, f]),
        g <- Enum.at(possible_line_permutations, 6),
        h <- Enum.at(possible_line_permutations, 7),
        i <- Enum.at(possible_line_permutations, 8),
        check_requirements_satisfied?([a, b, c, d, e, f, g, h, i]) do
      [a, b, c, d, e, f, g, h, i]
    end
  end

  defp get_all_squares_data(candidate) do
    candidate
    |> Enum.chunk_every(3)
    |> Enum.flat_map(fn cur_chunk ->
      Enum.reduce(cur_chunk, [], fn cur_row, acc ->
        [chunk_x, chunk_y, chunk_z] = Enum.chunk_every(cur_row, 3)

        case acc do
          [] -> [chunk_x, chunk_y, chunk_z]
          [x, y, z] -> [x ++ chunk_x, y ++ chunk_y, z ++ chunk_z]
        end
      end)
    end)
  end

  defp check_requirements_satisfied?(candidate) do
    check_all_vertical_lines_valid?(candidate) and
      check_all_lines_have_unique_vals?(get_all_squares_data(candidate))
  end
end
