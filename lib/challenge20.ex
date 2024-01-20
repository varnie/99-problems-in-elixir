defmodule Challenge20 do
  @doc """
  (*) Remove the K'th element from a list.
  """
  def remove_at(lst, k) do
    lst
    |> Enum.with_index()
    |> Enum.reduce([], fn {val, index}, acc ->
      cond do
        index + 1 === k -> acc
        true -> acc ++ [val]
      end
    end)
  end
end
