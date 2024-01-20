defmodule Challenge7 do
  @doc """
  (**) Flatten a nested list structure.
  """
  def flatten(lst) do
    List.flatten(lst)
  end

  def my_flatten(lst) do
    Enum.reduce(lst, [], fn item, acc ->
      case is_list(item) do
        true -> acc ++ my_flatten(item)
        _ -> acc ++ [item]
      end
    end)
  end
end
