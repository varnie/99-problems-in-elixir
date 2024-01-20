defmodule Challenge21 do
  @doc """
  (*) Insert an element at a given position into a list.
  """
  def insert_at(item, lst, k) do
    if k < 1 or k > length(lst) do
      nil
    else
      {l1, l2} = Enum.split(lst, k - 1)
      Enum.concat([l1, [item], l2])
    end
  end
end
