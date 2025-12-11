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
            eval_string("#{left_comb_equation}==#{right_comb_equation}") do
          "#{left_comb_equation}==#{right_comb_equation}"
        end
      end

    result |> List.flatten()
  end

  defp create_str_equation(val) when is_number(val), do: Integer.to_string(val)

  defp create_str_equation(val) do
    Enum.map(val, &map_val_to_string/1) |> Enum.join("")
  end

  defp eval_string(val) do
    try do
      Kernel.elem(Code.eval_string(val), 0) == true
    rescue
      _ -> false
    end
  end

  defp map_val_to_string(op) do
    if is_number(op) do
      Integer.to_string(op)
    else
      case op do
        :plus -> "+"
        :minus -> "-"
        :mult -> "*"
        :div -> "/"
        _ -> raise("Invalid operation found #{op}")
      end
    end
  end

  defp gen_combs(numbers) when length(numbers) == 1, do: numbers

  defp gen_combs(numbers) do
    op_combs = gen_op_combs(length(numbers) - 1)

    result =
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

    result
  end

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
