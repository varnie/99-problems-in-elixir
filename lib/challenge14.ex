defmodule Challenge14 do
  @doc """
  (*) Duplicate the elements of a list.
  """
  def dupli(lst) do
    Enum.reduce(lst, [], fn elem, acc ->
      acc ++ [elem, elem]
    end)
  end
end
