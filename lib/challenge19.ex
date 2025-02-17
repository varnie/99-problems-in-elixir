defmodule Challenge19 do
  @moduledoc """
  (**) Rotate a list N places to the left.
  """
  def rotate(lst, k) do
    lst
    |> Stream.with_index()
    |> Enum.reduce([], fn {_val, index}, acc ->
      new_item =
        case index + k <= length(lst) - 1 do
          true -> Enum.at(lst, index + k)
          false -> Enum.at(lst, index + k - length(lst))
        end

      [new_item | acc]
    end)
    |> Enum.reverse()
  end
end
