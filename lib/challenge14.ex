defmodule Challenge14 do
  @doc """
  (*) Duplicate the elements of a list.
  """
  def dupli(lst) do
    lst
    |> Enum.map(fn elem ->
      [elem, elem]
    end)
    |> List.flatten()
  end
end
