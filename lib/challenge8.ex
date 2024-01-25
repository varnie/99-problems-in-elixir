defmodule Challenge8 do
  @doc """
    (**) Eliminate consecutive duplicates of list elements.
    If a list contains repeated elements they should be replaced with a single copy of the element.
    The order of the elements should not be changed.
  """
  def compress(lst) do
    reversed_lst = Enum.reduce(lst, [], fn item, acc ->
      if List.first(acc) == item do
        acc
      else
        [item | acc]
      end
    end)

    Enum.reverse(reversed_lst)
  end
end
