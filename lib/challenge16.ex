defmodule Challenge16 do
  @doc """
  (**) Drop every N'th element from a list.
  """
  def drop(lst, n) do
    lst
    |> Enum.with_index()

    Enum.reduce(Enum.with_index(lst), [], fn {val, index}, acc ->
      if rem(index + 1, n) == 0 do
        # drop val every n'th time
        acc
      else
        acc ++ [val]
      end
    end)
  end

  @doc """
  (**) Drop every N'th element from a list.
  """
  def drop_slightly_rewritten(lst, n) do
    lst
    |> Enum.with_index()
    |> Enum.reduce([], fn {val, index}, acc ->
      if rem(index + 1, n) == 0 do
        # drop val every n'th time
        acc
      else
        acc ++ [val]
      end
    end)
  end

  @doc """
  (**) Drop every N'th element from a list.
  """
  def drop_using_recursion(lst, n) do
    drop_using_recursion_helper(lst, [], n, 0)
  end

  defp drop_using_recursion_helper([], dst, _n, _cur_index) do
    dst
  end

  defp drop_using_recursion_helper(_src=[head|tail], dst, n, cur_index) do
    dst = if rem(cur_index+1, n) == 0 do
      dst
    else
      # drop val every n'th time
      dst ++ [head]
    end

    drop_using_recursion_helper(tail, dst, n, cur_index+1)
  end
end
