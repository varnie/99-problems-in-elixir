defmodule Challenge26 do
  @doc """
  (**) Generate combinations of K distinct objects chosen from the N elements of a list.
  """
  def combinations(k, lst) do
    cond do
      k <= 0 -> nil
      k > length(lst) -> []
      true -> combinations_helper(k, lst, []) |> flatten()
    end
  end

  defp combinations_helper(k, lst, cur) do
    lst
    |> Enum.with_index()
    |> Enum.map(fn {elem, index} ->
      new_cur = cur ++ [elem]

      if length(new_cur) == k do
        new_cur
      else
        new_lst = Enum.drop(lst, index + 1)
        combinations_helper(k, new_lst, new_cur)
      end
    end)
  end

  defp flatten(lst, dst\\[])

  defp flatten([h | t], dst) do
    new_dst =
      if is_list(h) && !Enum.empty?(h) do
          #if Enum.all?(h, fn item -> !is_list(item) end) do
          if Enum.all?(h, &!is_list(&1)) do
            Enum.concat(dst, [h])
          else
            flatten(h, dst)
          end
      else
          dst
      end

    flatten(t, new_dst)
  end

  defp flatten([], dst) do
    dst
  end
end
