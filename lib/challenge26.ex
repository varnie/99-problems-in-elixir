defmodule Challenge26 do
  @moduledoc """
  (**) Generate combinations of K distinct objects chosen from the N elements of a list.
  """

  defp new_combinations_impl(_, [], _, _, result), do: result

  defp new_combinations_impl(k, [h | t], cur_count, cur_acc, result) do
    {cur_count, cur_acc, result} =
      if cur_count + 1 < k do
        {cur_count + 1, cur_acc ++ [h], result}
      else
        {cur_count, cur_acc, result ++ [cur_acc ++ [h]]}
      end

    new_combinations_impl(k, t, cur_count, cur_acc, result)
  end

  def new_combinations(k, lst) when k <= 0 or k > length(lst), do: []

  def new_combinations(_k, []), do: []

  def new_combinations(k, lst = [h | tail]) do
    default_acc = new_combinations_impl(k, lst, 0, [], [])

    cond do
      k == 1 ->
        default_acc

      k == 2 ->
        Enum.concat(default_acc, new_combinations(k, tail))

      true ->
        result =
          Enum.reduce(1..length(tail), default_acc, fn x, acc ->
            new_acc =
              Enum.concat(acc, new_combinations_impl(k, [h | Enum.drop(tail, x)], 0, [], []))

            new_acc
          end)

        Enum.concat(result, new_combinations(k, tail))
    end
  end

  def combinations(k, lst) when k <= 0 or k > length(lst), do: []

  def combinations(k, lst) do
    combinations_helper(k, lst, []) |> our_reduce()
  end

  defp combinations_helper(k, lst, cur) do
    lst
    |> Enum.with_index(1)
    |> Enum.map(fn {elem, index} ->
      new_cur = cur ++ [elem]

      if length(new_cur) == k do
        new_cur
      else
        new_lst = Enum.drop(lst, index)
        combinations_helper(k, new_lst, new_cur)
      end
    end)
  end

  defp our_reduce(lst, dst \\ []) do
    Enum.reduce(lst, dst, fn x, acc ->
      if is_list(x) && !Enum.empty?(x) do
        if Enum.all?(x, &(!is_list(&1))) do
          [x | acc]
        else
          our_reduce(x, acc)
        end
      else
        if !is_list(x), do: [x | acc], else: acc
      end
    end)
  end
end
