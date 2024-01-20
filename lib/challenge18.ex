defmodule Challenge18 do
  @doc """
  (**) Extract a slice from a list.
  Given two indices, i and k, the slice is the list containing the elements between the i'th and k'th element of the original list (both limits included).
  Start counting the elements with 1.
  """
  def slice(lst, i, k) do
    lst
    |> Enum.with_index()
    |> Enum.reduce([], fn {val, index}, acc ->
      cond do
        index + 1 < i -> acc
        index + 1 <= k -> acc ++ [val]
        true -> acc
      end
    end)
  end
end