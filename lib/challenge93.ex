defmodule Challenge93 do
  @moduledoc """
  P95 (***) An arithmetic puzzle
    Given a list of integer numbers, find a correct way of inserting arithmetic signs (operators) such that
    the result is a correct equation.
    Example: With the list of numbers (2 3 5 7 11) we can form the equations 2-3+5+7 = 11
    or 2 = (3*5+7)/11 (and ten others!).
  """

  @ops [:plus, :minus, :mult, :div]

  def solution(numbers) when length(numbers) < 2 do
    raise("Two ore more items required")
  end

  def solution(numbers) do
    result =
      for i <- 1..(length(numbers) - 1) do
        {x, y} = Enum.split(numbers, i)

        left_combs = gen_combs(x)
        right_combs = gen_combs(y)

        for left_comb <- left_combs,
            right_comb <- right_combs,
            Kernel.elem(Code.eval_string("#{left_comb}==#{right_comb}"), 0) == true do
          "#{left_comb}==#{right_comb}"
        end
      end

    Enum.filter(result, &(&1 != []))
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

    Enum.map(op_combs, fn op_comb ->
      # we need to add dummy item to op_combs in order to use Enu.zip_with
      # (we need to make lengths of these sequences equal)
      Enum.zip_with(numbers, op_comb ++ [""], fn number, op ->
        Integer.to_string(number) <> if op == "", do: "", else: map_op_to_string(op)
      end)
    end)
  end

  def gen_op_combs(how_much, cur_item \\ []) do
    Enum.reduce(@ops, [], fn x, acc ->
      # new_cur_item is a flat list
      new_cur_item = cur_item ++ [x]

      if length(new_cur_item) == how_much do
        new_acc = [new_cur_item | acc]
        new_acc
      else
        Enum.concat(acc, gen_op_combs(how_much, new_cur_item))
      end
    end)
  end
end
