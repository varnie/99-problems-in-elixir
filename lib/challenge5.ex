defmodule Challenge5 do
  @doc """
    (*) Reverse a list.
  """
  def reverse(lst) do
    Enum.reverse(lst)
  end

  @doc """
    (*) Reverse a list.
  """
  def reverse_my(lst) do
    helper(lst, [])
  end

  defp helper([], dst) do
    dst
  end

  defp helper([h | tail], dst) do
    helper(tail, [h | dst])
  end
end
