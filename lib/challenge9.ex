defmodule Challenge9 do
  @doc """
    (**) Pack consecutive duplicates of list elements into sublists.
    If a list contains repeated elements they should be placed in separate sublists.
  """
  def pack(lst) do
    pack_helper(lst, [])
  end

  defp pack_helper(_src = [], dst) do
    Enum.reverse(dst)
  end

  defp pack_helper(_src = [head | tail], dst) do
    first_item_dst = get_first_item(dst)

    if head == first_item_dst do
      pack_helper(tail, append_to_first_item(dst, head))
    else
      pack_helper(tail, [[head] | dst])
    end
  end

  defp append_to_first_item(lst, item) do
    Enum.with_index(lst, fn element, index ->
      case index == 0 do
        true -> [item | element]
        _ -> element
      end
    end)
  end

  def get_first_item(lst_or_obj) do
    case is_list(lst_or_obj) do
      true -> get_first_item(List.first(lst_or_obj))
      _ -> lst_or_obj
    end
  end
end
