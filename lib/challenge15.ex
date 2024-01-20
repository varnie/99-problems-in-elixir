defmodule Challenge15 do
  @doc """
  (**) Duplicate the elements of a list a given number of times.
  """
  def dupli(lst, num) do
    Enum.reduce(lst, [], fn elem, acc ->
      acc ++ List.duplicate(elem, num)
    end)
  end
end
