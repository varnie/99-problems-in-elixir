defmodule Challenge26 do
  @moduledoc """
  (**) Generate combinations of K distinct objects chosen from the N elements of a list.
  """
  def combinations(k, lst) do
    cond do
      k <= 0 -> nil
      k > length(lst) -> []
      true -> combinations_helper(k, lst, []) |> our_reduce([])
    end
  end

  defp combinations_helper(k, lst, cur) do
    lst
    |> Enum.with_index()
    |> Enum.map(fn {elem, index} ->
      new_cur = [elem | cur]

      if length(new_cur) == k do
        new_cur |> Enum.reverse()
      else
        new_lst = Enum.drop(lst, index + 1)
        combinations_helper(k, new_lst, new_cur)
      end
    end)
  end

  defp our_reduce(lst, dst) do
    Enum.reduce(lst, dst, fn elem, acc ->
      if is_list(elem) && !Enum.empty?(elem) do
        if Enum.all?(elem, &(!is_list(&1))) do
          [elem | acc]
        else
          our_reduce(elem, acc)
        end
      else
        if !is_list(elem) do
          [elem | acc]
        else
          acc
        end
      end
    end)
  end
end
