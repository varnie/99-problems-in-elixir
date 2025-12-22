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
        Enum.map(lst, fn row ->
          Enum.at(row, index)
        end)
      end)

    check_all_lines_have_unique_vals?(vertical_lines)
  end

  defp check_new_row_is_a_good_candidate?(new_row, row_index) do
    indexed_src_list = Enum.with_index(@src, 0)

    new_src_list =
      Enum.map(indexed_src_list, fn {cur_lst, cur_index} ->
        if cur_index != row_index do
          cur_lst
        else
          new_row
        end
      end)

    check_all_vertical_lines_valid?(new_src_list)
  end

  def solve() do
    numbers = MapSet.new([1, 2, 3, 4, 5, 6, 7, 8, 9])

    list_of_missed_vals =
      @src
      |> Enum.map(fn cur_lst ->
        present_numbers = Enum.filter(cur_lst, &(&1 != 0))
        diff = MapSet.difference(numbers, MapSet.new(present_numbers))
        MapSet.to_list(diff)
      end)

    possible_lists_of_missed_vals_permutations =
      Enum.map(list_of_missed_vals, &permutations_without_repetitions/1)

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

    possible_row_permutations =
      possible_lists_of_missed_vals_permutations
      |> Enum.with_index(0)
      |> Enum.map(fn {updates_rows, row_index} ->
        for updates_row <- updates_rows,
            cur_row = Enum.at(@src, row_index),
            {new_row, _} =
              Enum.reduce(cur_row, {[], updates_row}, fn x, acc ->
                {cur_acc_result, cur_updates_row} = acc

                if x == 0 do
                  [cur_updates_row_head | cur_updates_row_tail] = cur_updates_row
                  {cur_acc_result ++ [cur_updates_row_head], cur_updates_row_tail}
                else
                  {cur_acc_result ++ [x], cur_updates_row}
                end
              end),
            check_new_row_is_a_good_candidate?(new_row, row_index) do
          new_row
        end
      end)

    for a <- Enum.at(possible_row_permutations, 0),
        b <- Enum.at(possible_row_permutations, 1),
        c <- Enum.at(possible_row_permutations, 2),
        check_requirements_satisfied?([a, b, c]),
        d <- Enum.at(possible_row_permutations, 3),
        e <- Enum.at(possible_row_permutations, 4),
        f <- Enum.at(possible_row_permutations, 5),
        check_requirements_satisfied?([a, b, c, d, e, f]),
        g <- Enum.at(possible_row_permutations, 6),
        h <- Enum.at(possible_row_permutations, 7),
        i <- Enum.at(possible_row_permutations, 8),
        check_requirements_satisfied?([a, b, c, d, e, f, g, h, i]) do
      [a, b, c, d, e, f, g, h, i]
    end
  end

  defp check_requirements_satisfied?(candidate) do
    if !check_all_vertical_lines_valid?(candidate) do
      false
    else
      {square_rows, _} =
        candidate
        |> Enum.reduce({[], []}, fn x, {result, cur_acc} ->
          # x is a row
          cur_acc = cur_acc ++ [x]

          if length(cur_acc) == 3 do
            new_result_items =
              Enum.reduce(cur_acc, [[], [], []], fn cur_row, [x, y, z] ->
                chunks = Enum.chunk_every(cur_row, 3)
                [chunk_x, chunk_y, chunk_z] = chunks
                [x ++ chunk_x, y ++ chunk_y, z ++ chunk_z]
              end)

            {Enum.concat(result, new_result_items), []}
          else
            {result, cur_acc}
          end
        end)

      check_all_lines_have_unique_vals?(square_rows)
    end
  end

  defp permutations_without_repetitions(lst) do
    #    "[1,2,3]
    #     [1,3,2]
    #     [2,1,3]
    #     [2,3,1]
    #     [3,1,2]
    #     [3,2,1]"

    indexed_list = lst |> Enum.with_index(1)
    permutations_without_repetitions_helper(indexed_list)
  end

  defp permutations_without_repetitions_helper(indexed_list) do
    Enum.reduce(indexed_list, [], fn x, acc ->
      {head, index} = x

      rest = Enum.reject(indexed_list, fn {_some_val, some_index} -> some_index == index end)

      new_elems =
        case rest do
          [] ->
            [[head]]

          _ ->
            Enum.map(permutations_without_repetitions_helper(rest), fn new_item ->
              [head | new_item]
            end)
        end

      acc ++ new_elems
    end)
  end
end
