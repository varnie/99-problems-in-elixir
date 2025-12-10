defmodule Challenge93 do
  @moduledoc """
  P95 (***) An arithmetic puzzle
    Given a list of integer numbers, find a correct way of inserting arithmetic signs (operators) such that
    the result is a correct equation.
    Example: With the list of numbers (2 3 5 7 11) we can form the equations 2-3+5+7 = 11
    or 2 = (3*5+7)/11 (and ten others!).
  """

  @ops [:plus, :minus, :mult, :div]

  def solutions(numbers) when length(numbers) < 2 do
    raise("Two ore more items required")
  end

  def solutions(numbers) do
    result =
      for i <- 1..(length(numbers) - 1) do
        {x, y} = Enum.split(numbers, i)

        left_combs = gen_combs(x)
        right_combs = gen_combs(y)

        for left_comb <- left_combs,
            right_comb <- right_combs,
            eval_string("#{left_comb}==#{right_comb}") do
          "#{left_comb}==#{right_comb}"
        end
      end

    result |> List.flatten()
  end

  defp eval_string(val) do
    try do
      Kernel.elem(Code.eval_string(val), 0) == true
    rescue
      _ -> false
    end
  end

  defp map_op_to_string(op) do
    case op do
      :plus -> "+"
      :minus -> "-"
      :mult -> "*"
      :div -> "/"
      _ -> raise("Invalid operation found #{op}")
    end
  end

  defp gen_combs(numbers) when length(numbers) == 1, do: numbers

  defp gen_combs(numbers) do
    op_combs = gen_op_combs(length(numbers) - 1)

    Enum.map(op_combs, fn cur_op_combs ->
      # we need to add a dummy item to cur_op_combs in order to use Enum.zip_with
      # (we need to make lengths of these sequences equal)
      Enum.zip_with(numbers, cur_op_combs ++ [""], fn number, op ->
        Integer.to_string(number) <> if op == "", do: "", else: map_op_to_string(op)
      end)
    end)
  end

  defp gen_op_combs(required_size, cur_item \\ []) do
    Enum.reduce(@ops, [], fn x, acc ->
      # new_cur_item is a flat list
      new_cur_item = cur_item ++ [x]

      if length(new_cur_item) == required_size do
        [new_cur_item | acc]
      else
        Enum.concat(acc, gen_op_combs(required_size, new_cur_item))
      end
    end)
  end
end
