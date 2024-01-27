defmodule Challenge15 do
  @doc """
  (**) Duplicate the elements of a list a given number of times.
  """
  def dupli(lst, num) do
    lst
    |> Enum.map(fn elem ->
      List.duplicate(elem, num)
    end)
    |> List.flatten()
  end
end
