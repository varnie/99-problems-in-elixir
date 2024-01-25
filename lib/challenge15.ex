defmodule Challenge15 do
  @doc """
  (**) Duplicate the elements of a list a given number of times.
  """
  def dupli(lst, num) do
    reversed_lst = Enum.reduce(lst, [], fn elem, acc ->
      Enum.concat(List.duplicate(elem, num), acc)
    end)

    Enum.reverse(reversed_lst)
  end
end
