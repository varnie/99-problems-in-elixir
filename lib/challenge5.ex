defmodule Challenge5 do
  @moduledoc """
    (*) Reverse a list.
  """
  def reverse(lst) do
    Enum.reverse(lst)
  end

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
