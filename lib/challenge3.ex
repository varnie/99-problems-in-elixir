defmodule Challenge3 do
  @doc """
    (*) Find the K'th element of a list.
    The first element in the list is number 1.
  """
  def p03_find_k_item(lst, k) do
    if k > length(lst) or k < 0 do
      nil
    else
      Enum.at(lst, k - 1)
    end
  end

  @doc """
    (*) Find the K'th element of a list.
    The first element in the list is number 1.
  """
  def p03_find_k_item_my(lst, k) do
    if k > length(lst) or k < 1 do
      nil
    else
      helper(lst, 1, k)
    end
  end

  defp helper([head | tail], cur_index, k) do
    case cur_index == k do
      true -> head
      _ -> helper(tail, cur_index + 1, k)
    end
  end
end
