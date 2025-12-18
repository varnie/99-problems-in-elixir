defmodule Challenge93 do
  @moduledoc """
  P95 (***) An arithmetic puzzle
    Given a list of integer numbers, find a correct way of inserting arithmetic signs (operators) such that
    the result is a correct equation.
    Example: With the list of numbers (2 3 5 7 11) we can form the equations 2-3+5+7 = 11
    or 2 = (3*5+7)/11 (and ten others!).
  """

  @ops [:plus, :minus, :mult, :div]
  @open_bracket :open
  @closed_bracket :closed

  def solutions(numbers) when length(numbers) < 2 do
    raise("Two or more items required")
  end

  def solutions(numbers) do
    result =
      for i <- 1..(length(numbers) - 1) do
        {x, y} = Enum.split(numbers, i)

        left_combs = gen_combs(x)
        right_combs = gen_combs(y)

        for left_comb <- left_combs,
            right_comb <- right_combs,
            left_comb_equation = create_str_equation(left_comb),
            right_comb_equation = create_str_equation(right_comb),
            candidate = "#{left_comb_equation}==#{right_comb_equation}",
            eval_string(candidate) do
          "#{left_comb_equation}=#{right_comb_equation}"
        end
      end

    result |> List.flatten()
  end

  defp create_str_equation(val) when not is_list(val), do: map_val_to_string(val)

  defp create_str_equation(lst) do
    Enum.map(lst, &create_str_equation/1) |> Enum.join("")
  end

  defp eval_string(val) do
    try do
      {result, _} = Code.eval_string(val)
      result === true
    rescue
      _ -> false
    end
  end

  defp map_val_to_string(op) do
    case op do
      n when is_number(n) -> Integer.to_string(n)
      :plus -> "+"
      :minus -> "-"
      :mult -> "*"
      :div -> "/"
      :open -> "("
      :closed -> ")"
      _ -> raise("Invalid operation found #{IO.inspect(op)}")
    end
  end

  defp gen_combs([item]), do: [item]

  defp gen_combs(numbers) do
    op_combs = gen_op_combs(length(numbers) - 1)

    equations_list =
      Enum.map(op_combs, fn cur_op_combs ->
        zipped_numbers_with_ops = Enum.zip(numbers, cur_op_combs ++ [""])

        Enum.reduce(zipped_numbers_with_ops, [], fn {cur_number, cur_op}, acc ->
          if cur_op == "" do
            [cur_number | acc]
          else
            [cur_op, cur_number | acc]
          end
        end)
        |> Enum.reverse()
      end)

    new_equations =
      equations_list
      |> Enum.filter(&(:mult in &1 or :div in &1))
      |> Enum.map(fn cur_equation ->
        # extend equations_list with "(..)"-equations

        term_indexes =
          cur_equation
          |> Enum.with_index()
          |> Enum.reduce([], fn x, acc ->
            {val, index} = x

            if is_integer(val) do
              acc ++ [index]
            else
              acc
            end
          end)

        all_possible_index_pairs = gen_all_index_pairs(term_indexes)
        all_possible_index_pair_combs = gen_all_index_pairs_combs(all_possible_index_pairs)

        Enum.reduce(all_possible_index_pair_combs, [], fn x, acc ->
          index_pair_combs = x

          new_equations_with_mult_div_ops =
            setup_brackets_for_equation(cur_equation, index_pair_combs)

          acc ++ [new_equations_with_mult_div_ops]
        end)
      end) |> Enum.concat()

    # merge equations_list and equations_with_brackets
    Enum.concat(equations_list, new_equations)
  end

  def setup_brackets_for_equation(equation, index_pair_combs) do
    new_equation =
      Enum.reduce(index_pair_combs, equation, fn x, acc ->
        {open_bracket_index, closed_bracket_index} = x

        equation_with_index = Enum.with_index(acc)

        new_acc =
          Enum.map(equation_with_index, fn cur_equation_item ->
            {val, index} = cur_equation_item

            if index in [open_bracket_index, closed_bracket_index] do
              bracket_symbol =
                if index == open_bracket_index, do: @open_bracket, else: @closed_bracket

              if is_integer(val) do
                if bracket_symbol == @open_bracket, do: [@open_bracket, val], else: [val, @closed_bracket]
              else
                val ++ [bracket_symbol]
              end
            else
              val
            end
          end)

        new_acc
      end)

    new_equation
  end

  def gen_all_index_pairs_combs(index_pairs_list, k \\ 1) do
    result = Challenge26SecondSolution.combinations(k, index_pairs_list)

    case result do
      [] -> result
      _ -> result ++ gen_all_index_pairs_combs(index_pairs_list, k + 1)
    end
  end

  def gen_all_index_pairs(_term_indices = [head | tail]) do
    Enum.reduce(tail, [], fn item, acc ->
      acc ++ [{head, item}]
    end) ++ gen_all_index_pairs(tail)
  end

  def gen_all_index_pairs([]), do: []

  defp gen_op_combs(required_size, cur_len \\ 0, cur_item \\ []) do
    Enum.reduce(@ops, [], fn op, acc ->
      # new_cur_item is a flat list
      new_cur_item = cur_item ++ [op]

      if cur_len + 1 == required_size do
        [new_cur_item | acc]
      else
        new_gen_op_combs = gen_op_combs(required_size, cur_len + 1, new_cur_item)
        Enum.concat(acc, new_gen_op_combs)
      end
    end)
  end
end
