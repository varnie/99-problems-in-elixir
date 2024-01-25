defmodule Challenge14 do
  @doc """
  (*) Duplicate the elements of a list.
  """
  def dupli(lst) do
    reversed_lst = Enum.reduce(lst, [], fn elem, acc ->
      [elem, elem | acc]
    end)

    Enum.reverse(reversed_lst)
  end
end
