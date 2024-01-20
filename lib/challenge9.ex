defmodule Challenge9 do
  @doc """
    (**) Pack consecutive duplicates of list elements into sublists.
    If a list contains repeated elements they should be placed in separate sublists.
  """
  def pack(lst) do
    pack_helper(lst, [])
  end

  defp pack_helper(_src = [], dst) do
    dst
  end

  defp pack_helper(_src = [head | tail], dst) do
    last_item_dst = get_last_item(dst)

    if head == last_item_dst do
      pack_helper(tail, append_to_last_item(dst, head))
    else
      pack_helper(tail, dst ++ [[head]])
    end
  end

  defp append_to_last_item(lst, item) do
    last_index = length(lst) - 1

    Enum.with_index(lst, fn element, index ->
      case index == last_index do
        true -> element ++ [item]
        _ -> element
      end
    end)
  end

  def get_last_item(lst_or_obj) do
    case is_list(lst_or_obj) do
      true -> get_last_item(List.last(lst_or_obj))
      _ -> lst_or_obj
    end
  end
end
