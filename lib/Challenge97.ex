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

  def check_all_vertical_lines_valid(lst, line_len) do
    vertical_lines =
      Enum.map(0..line_len-1, fn index ->
        Enum.map(lst, fn row ->
          Enum.at(row, index)
        end)
      end)

    Enum.all?(vertical_lines, fn row ->
      row_without_zeros = Enum.filter(row, fn x -> x != 0 end)
      length(row_without_zeros) == length(Enum.uniq(row_without_zeros))
    end)
  end

  def check_new_row_is_a_good_candidate?(new_row, row_index) do
    indexed_src_list = Enum.with_index(@src, 0)

    new_src_list =
      Enum.map(indexed_src_list, fn {cur_lst, cur_index} ->
        if cur_index != row_index do
          cur_lst
        else
          new_row
        end
      end)

    #IO.inspect(new_src_list, label: "new_src_list")
    check_all_vertical_lines_valid(new_src_list, 9)
  end

  def solve() do
    numbers = MapSet.new([1, 2, 3, 4, 5, 6, 7, 8, 9])

    list_of_missed_vals =
      @src
      |> Enum.map(fn cur_lst ->
        present_numbers =
          Enum.reduce(cur_lst, [], fn x, acc ->
            if x != 0 do
              acc ++ [x]
            else
              acc
            end
          end)

        diff = MapSet.difference(numbers, MapSet.new(present_numbers))
        MapSet.to_list(diff)
      end)

    permutations_of_lists_of_missed_vals =
      Enum.map(list_of_missed_vals, &permutations_without_repetitions/1)

    # TODO
    permutations_of_possible_lines =
      Enum.map(Enum.with_index(permutations_of_lists_of_missed_vals, 0), fn {updates_rows,
                                                                             row_index} ->
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


    #    for {updates_rows, row_index} <- Enum.with_index(permutations_of_lists_of_missed_vals, 0),
    #        updates_row <- updates_rows,
    #        cur_row = Enum.at(@src, row_index),
    #        {new_row, _} =
    #          Enum.reduce(cur_row, {[], updates_row}, fn x, acc ->
    #            {cur_acc_result, cur_updates_row} = acc
    #
    #            if x == 0 do
    #              [cur_updates_row_head | cur_updates_row_tail] = cur_updates_row
    #              {cur_acc_result ++ [cur_updates_row_head], cur_updates_row_tail}
    #            else
    #              {cur_acc_result ++ [x], cur_updates_row}
    #            end
    #          end),
    #        check_new_row_is_a_good_candidate?(new_row, row_index) do
    #      new_row
    #    end

    # permutations_of_lists_of_missed_vals

    ##
    #    indexed_permutations_of_lists_of_missed_vals = permutations_of_lists_of_missed_vals |> Enum.with_index(0)
    #    indexed_permutations_of_lists_of_missed_vals
    #    |> Enum.map(fn {row_index, updates_rows} ->
    #      cur_row = Enum.at(@src, row_index)
    #
    #      for updates_row <- updates_rows do
    #        {new_row, _} =
    #          Enum.reduce(cur_row, {[], updates_row}, fn x, acc ->
    #            {cur_acc_result, cur_updates_row} = acc
    #
    #            if x == 0 do
    #              [cur_updates_row_head | cur_updates_row_tail] = cur_updates_row
    #              {cur_acc_result ++ [cur_updates_row_head], cur_updates_row_tail}
    #            else
    #              {cur_acc_result ++ [x], cur_updates_row}
    #            end
    #          end)
    #
    #        check_new_row_is_a_good_candidate?(new_row, row_index) do
    #          new_row
    #        end
    #      end
    #    end)

    #    suitable_candidates_rows =
    #      Enum.zip(@src, permutations_of_lists_of_missed_vals)
    #      |> Enum.map(fn {cur_row, updates_rows} ->
    #        for updates_row <- updates_rows do
    #          {new_row, _} =
    #            Enum.reduce(cur_row, {[], updates_row}, fn x, acc ->
    #              {cur_acc_result, cur_updates_row} = acc
    #
    #              if x == 0 do
    #                [cur_updates_row_head | cur_updates_row_tail] = cur_updates_row
    #                {cur_acc_result ++ [cur_updates_row_head], cur_updates_row_tail}
    #              else
    #                {cur_acc_result ++ [x], cur_updates_row}
    #              end
    #            end)
    #
    #          new_row
    #        end
    #      end)
    #      |> Enum.map(fn list_of_rows ->
    #        Enum.filter(list_of_rows, fn cur_row ->
    #          result = all_digits_occur_only_once(cur_row)
    #
    #          if !result do
    #            IO.inspect("NOOOOOOOOOO")
    #          end
    #
    #          result
    #        end)
    #      end)
    #
    #    suitable_candidates_rows
    # TODO

    #    permutations_of_lists_of_missed_vals:
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

    #IO.inspect(permutations_of_possible_lines)
    #IO.inspect("go bruteforce!")

    for a <- Enum.at(permutations_of_possible_lines, 0),
        b <- Enum.at(permutations_of_possible_lines, 1),
        c <- Enum.at(permutations_of_possible_lines, 2),
        check_condition_valid([a, b, c], 9),
        d <- Enum.at(permutations_of_possible_lines, 3),
        e <- Enum.at(permutations_of_possible_lines, 4),
        f <- Enum.at(permutations_of_possible_lines, 5),
        check_condition_valid([a, b, c, d, e, f], 9),
        g <- Enum.at(permutations_of_possible_lines, 6),
        h <- Enum.at(permutations_of_possible_lines, 7),
        i <- Enum.at(permutations_of_possible_lines, 8),
        check_condition_valid([a, b, c, d, e, f, g, h, i], 9) do
      [a, b, c, d, e, f, g, h, i]
      # TODO:
    end
  end

  def check_condition_valid(candidate, line_len) do
    #IO.inspect("hey")
    if !check_all_vertical_lines_valid(candidate, line_len) do
        # IO.inspect("no2")
        false
    else
        #IO.inspect("wow....")
        # generate 9 lists 3x3
        {rectangle_rows, _} =
          candidate
          |> Enum.reduce({[], []}, fn x, {result, cur_acc} ->
            # x is a row
            cur_acc = cur_acc ++ [x]

            if length(cur_acc) == 3 do
              #          IO.inspect(cur_acc, label: "cur_acc")
              new_result_items =
                Enum.reduce(cur_acc, [[], [], []], fn cur_row, [x, y, z] ->
                  chunks = Enum.chunk_every(cur_row, 3)
                  [chunk_x, chunk_y, chunk_z] = chunks
                  #              IO.inspect(chunk_x, label: "chunk_x")
                  #              IO.inspect(chunk_y, label: "chunk_y")
                  #              IO.inspect(chunk_z, label: "chunk_z")

                  #              IO.inspect(x, label: "x")
                  #              IO.inspect(y, label: "y")
                  #              IO.inspect(z, label: "z")
                  [x ++ chunk_x, y ++ chunk_y, z ++ chunk_z]
                end)

              #          IO.inspect(new_result_items, label: "new_result_items")

              {Enum.concat(result, new_result_items), []}
            else
              {result, cur_acc}
            end
          end)

        Enum.all?(rectangle_rows, fn rectangle ->
          numbers = Enum.reduce(rectangle, [], fn x, acc ->
            if x != 0 do
              acc ++ [x]
            else
              acc
            end
          end)

          length(numbers) == length(Enum.uniq(numbers))
        end)
    end
  end

#  defp all_digits_occur_only_once(lst) do
#    # IO.inspect("calc condition..")
#    Enum.sum(lst) == 45
#  end

#  def check_constraints_satisfied(candidate) do
#    #    IO.inspect("check_constraints_satisfied")
#    #    IO.inspect(candidate, label: "with candidate")
#    # IO.inspect(Enum.at(candidate, 7), label: "testing...")
#
#    if !Enum.all?(candidate, &all_digits_occur_only_once/1) do
#      # IO.inspect("no1")
#      false
#    else
#      # IO.inspect(candidate, label: "yeah, 1st check passed!")
#      vertical_lines_valid = check_all_vertical_lines_valid(candidate, 9)
#
##      vertical_lines =
##        Enum.map(0..(length(candidate) - 1), fn index ->
##          Enum.map(candidate, fn row ->
##            Enum.at(row, index)
##          end)
##        end)
#
#      #      IO.inspect(candidate, label: "candidate")
#      #      IO.inspect(vertical_lines, label: "vertical_lines")
#
#      if !vertical_lines_valid do
#        # IO.inspect("no2")
#        false
#      else
#        IO.inspect("wow....")
#        # generate 9 lists 3x3
#        {rectangle_rows, _} =
#          candidate
#          |> Enum.reduce({[], []}, fn x, {result, cur_acc} ->
#            # x is a row
#            cur_acc = cur_acc ++ [x]
#
#            if length(cur_acc) == 3 do
#              #          IO.inspect(cur_acc, label: "cur_acc")
#              new_result_items =
#                Enum.reduce(cur_acc, [[], [], []], fn cur_row, [x, y, z] ->
#                  chunks = Enum.chunk_every(cur_row, 3)
#                  [chunk_x, chunk_y, chunk_z] = chunks
#                  #              IO.inspect(chunk_x, label: "chunk_x")
#                  #              IO.inspect(chunk_y, label: "chunk_y")
#                  #              IO.inspect(chunk_z, label: "chunk_z")
#
#                  #              IO.inspect(x, label: "x")
#                  #              IO.inspect(y, label: "y")
#                  #              IO.inspect(z, label: "z")
#                  [x ++ chunk_x, y ++ chunk_y, z ++ chunk_z]
#                end)
#
#              #          IO.inspect(new_result_items, label: "new_result_items")
#
#              {Enum.concat(result, new_result_items), []}
#            else
#              {result, cur_acc}
#            end
#          end)
#
#        Enum.all?(rectangle_rows, &all_digits_occur_only_once/1) == true
#      end
#    end
#
#    #    all_horizontal_rows_are_ok = Enum.all?(candidate, all_digits_occur_only_once_fn)
#    #
#    #    list_of_vertical_rows =
#    #      Enum.map(0..(length(candidate) - 1), fn index ->
#    #        Enum.map(candidate, fn row ->
#    #          Enum.at(row, index)
#    #        end)
#    #      end)
#    #
#    #    all_vertical_rows_are_ok = Enum.all?(list_of_vertical_rows, all_digits_occur_only_once_fn)
#    #
#    #    # generate 9 lists 3x3
#    #    {rectangle_rows, _} =
#    #      candidate
#    #      |> Enum.reduce({[], []}, fn x, {result, cur_acc} ->
#    #        # x is a row
#    #        cur_acc = cur_acc ++ [x]
#    #
#    #        if length(cur_acc) == 3 do
#    #          #          IO.inspect(cur_acc, label: "cur_acc")
#    #          new_result_items =
#    #            Enum.reduce(cur_acc, [[], [], []], fn cur_row, [x, y, z] ->
#    #              chunks = Enum.chunk_every(cur_row, 3)
#    #              [chunk_x, chunk_y, chunk_z] = chunks
#    #              #              IO.inspect(chunk_x, label: "chunk_x")
#    #              #              IO.inspect(chunk_y, label: "chunk_y")
#    #              #              IO.inspect(chunk_z, label: "chunk_z")
#    #
#    #              #              IO.inspect(x, label: "x")
#    #              #              IO.inspect(y, label: "y")
#    #              #              IO.inspect(z, label: "z")
#    #              [x ++ chunk_x, y ++ chunk_y, z ++ chunk_z]
#    #            end)
#    #
#    #          #          IO.inspect(new_result_items, label: "new_result_items")
#    #
#    #          {Enum.concat(result, new_result_items), []}
#    #        else
#    #          {result, cur_acc}
#    #        end
#    #      end)
#    #
#    #    #    IO.inspect(rectangle_rows, label: "3x3 rects")
#    #    all_rectangle_rows_are_ok = Enum.all?(rectangle_rows, all_digits_occur_only_once_fn)
#    #
#    #    all_horizontal_rows_are_ok and all_vertical_rows_are_ok and all_rectangle_rows_are_ok
#  end

#  def build_candidate(list_for_updates) do
#    Enum.zip(@src, list_for_updates)
#    |> Enum.map(fn {cur_row, updates_row} ->
#      {result, _} =
#        Enum.reduce(cur_row, {[], updates_row}, fn x, acc ->
#          {cur_acc_result, cur_updates_row} = acc
#
#          if x == 0 do
#            [cur_updates_row_head | cur_updates_row_tail] = cur_updates_row
#            {cur_acc_result ++ [cur_updates_row_head], cur_updates_row_tail}
#          else
#            {cur_acc_result ++ [x], cur_updates_row}
#          end
#        end)
#
#      result
#    end)
#  end

  def combinations_for_list_of_lists([]), do: []

  def combinations_for_list_of_lists(_list_of_lists = [h | tail]) do
    #    "
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
    #    "

    Enum.reduce(h, [], fn x, acc ->
      new_elems =
        case tail do
          [] ->
            [[x]]

          _ ->
            for tail_item <- combinations_for_list_of_lists(tail) do
              [x | tail_item]
            end
        end

      acc ++ new_elems
    end)
  end

  def permutations_without_repetitions(lst) do
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
