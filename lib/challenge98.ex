defmodule Challenge98 do
  @moduledoc """
    (***) Nonograms
    Around 1994, a certain kind of puzzles was very popular in England. The "Sunday Telegraph" newspaper wrote:
    "Nonograms are puzzles from Japan and are currently published each week only in The Sunday Telegraph. Simply use
    your logic and skill to complete the grid and reveal a picture or diagram." As a Lisp programmer, you are in a
    better situation: you can have your computer do the work! Just write a little program ;-).

    The puzzle goes like this: Essentially, each row and column of a rectangular bitmap is annotated with the respective
    lengths of its distinct strings of occupied cells. The person who solves the puzzle must complete the bitmap given
    only these lengths.

              Problem statement:          Solution:

              |_|_|_|_|_|_|_|_| 3         |_|X|X|X|_|_|_|_| 3
              |_|_|_|_|_|_|_|_| 2 1       |X|X|_|X|_|_|_|_| 2 1
              |_|_|_|_|_|_|_|_| 3 2       |_|X|X|X|_|_|X|X| 3 2
              |_|_|_|_|_|_|_|_| 2 2       |_|_|X|X|_|_|X|X| 2 2
              |_|_|_|_|_|_|_|_| 6         |_|_|X|X|X|X|X|X| 6
              |_|_|_|_|_|_|_|_| 1 5       |X|_|X|X|X|X|X|_| 1 5
              |_|_|_|_|_|_|_|_| 6         |X|X|X|X|X|X|_|_| 6
              |_|_|_|_|_|_|_|_| 1         |_|_|_|_|X|_|_|_| 1
              |_|_|_|_|_|_|_|_| 2         |_|_|_|X|X|_|_|_| 2
               1 3 1 7 5 3 4 3             1 3 1 7 5 3 4 3
               2 1 5 1                     2 1 5 1


    For the example above, the problem can be stated as the two lists
    ((3) (2 1) (3 2) (2 2) (6) (1 5) (6) (1) (2)) and ((1 2) (3 1) (1 5) (7 1) (5) (3) (4) (3)) which give
    the "solid" lengths of the rows and columns, top-to-bottom and left-to-right, respectively.
    Published puzzles are larger than this example, e.g. 25 x 20, and apparently always have unique solutions.
  """

  def solve() do
    src_data = [
      [[3], [2, 1], [3, 2], [2, 2], [6], [1, 5], [6], [1], [2]],
      [[1, 2], [3, 1], [1, 5], [7, 1], [5], [3], [4], [3]]
    ]

    [line_specs, row_specs] = src_data
    lines_dimension_size = 8

    combinations =
      Enum.map(line_specs, fn line_spec ->
        produce_combinations(line_spec, lines_dimension_size)
      end)

    # combinations are list of lists of possible lines
    Enum.reduce(combinations, [[]], fn x, acc ->
      # x is a list of possible lines

      # IO.inspect(acc, label: "acc")

      for prev <- acc,
          candidate_line <- x,
          new_candidate = prev ++ [candidate_line],
          check_requirements(new_candidate, row_specs) do
        # IO.inspect(new_candidate, label: "new_candidate")
        new_candidate
      end
    end)
    |> Enum.uniq()

    # TODO:
  end

  defp check_requirements(solution, row_specs) do
    # IO.inspect(solution, label: "solution_to_check")

    vertical_lines = Enum.zip_with(solution, fn list -> list end)
    vertical_lines_with_index = Enum.with_index(vertical_lines)

    result =
      Enum.all?(vertical_lines_with_index, fn {vertical_line, index} ->
        {counter, found_sizes} =
          Enum.reduce(vertical_line, {0, []}, fn x, acc ->
            symbol = x
            {counter, sizes} = acc

            if symbol == 1 do
              {counter + 1, sizes}
            else
              if counter > 0 do
                {0, [counter | sizes]}
              else
                acc
              end
            end
          end)

        #            #partly_sizes = if counter > 0, do: counter, else: "none"
        #    #        IO.inspect(row_index, label: "row_index")
        #    #        IO.inspect(found_sizes, label: "found_sizes")
        #    #        IO.inspect(partly_sizes, label: "partly_sizes")
        #
        valid_sizes = Enum.at(row_specs, index)

        has_partially_discovered_size = counter > 0

        # at first do strict check
        cond do
          !Enum.all?(found_sizes, fn found_size ->
            found_size in valid_sizes
          end) ->
            false

          !has_partially_discovered_size ->
            true

          true ->
            remaining_valid_sizes =
              MapSet.new(valid_sizes)
              |> MapSet.difference(MapSet.new(found_sizes))
              |> MapSet.to_list()

            Enum.any?(remaining_valid_sizes, &(&1 >= counter))
        end
      end)

    # IO.inspect(result, label: "check_requirements")
    result
  end

  defp produce_combinations(lst, dimension_size) do
    permutations = Helpers.permutations_without_repetitions(lst)
    # IO.inspect(permutations, label: "permutations")
    available_space = dimension_size

    Enum.flat_map(permutations, fn items ->
      produce_combinations_impl(items, available_space)
      |> Enum.map(fn cells_list ->
        cells_list ++ List.duplicate(0, dimension_size - length(cells_list))
      end)
    end)
  end

  defp produce_combinations_impl(items, available_space) do
    # items like [2,1] or [2] or [2,4,1] etc
    # available_space like 8

    Enum.reduce(items, [], fn x, acc ->
      head_cells = List.duplicate(1, x)
      max_offset = available_space - x

      new_lists =
        Enum.map(0..max_offset, fn offset ->
          zeroes_cells = List.duplicate(0, offset)
          cells = zeroes_cells ++ head_cells
          cells
        end)

      new_acc =
        case acc do
          [] ->
            new_lists

          _ ->
            for new_cells <- new_lists,
                prev <- acc,
                length(new_cells) + length(prev) + 1 <= available_space do
              prev ++ [0] ++ new_cells
            end
        end

      new_acc
    end)
  end
end
