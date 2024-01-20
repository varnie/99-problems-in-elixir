defmodule Challenge19 do
  @doc """
  (**) Rotate a list N places to the left.
  """
  def rotate(lst, k) do
    lst
    |> Enum.with_index()
    |> Enum.reduce([], fn {_val, index}, acc ->
      new_item =
        cond do
          index + k <= length(lst) - 1 -> Enum.at(lst, index + k)
          true -> Enum.at(lst, index + k - length(lst))
        end

      acc ++ [new_item]
    end)
  end
end
