defmodule Challenge4 do
  @doc """
    (*) Find the number of elements of a list.
  """
  def p04_find_len(lst) do
    length(lst)
  end

  @doc """
    (*) Find the number of elements of a list.
  """
  def p04_find_len_my(lst) do
    helper(lst, 0)
  end

  defp helper([_h | t], acc) do
    helper(t, acc + 1)
  end

  defp helper([], acc) do
    acc
  end
end
