defmodule Challenge22 do
  @doc """
  (*) Create a list containing all integers within a given range.
  """
  def range(x, y) do
    cond do
      x > y -> []
      x == y -> []
      true -> range_helper(x, y, [])
    end
  end

  defp range_helper(x, y, dst) do
    if x > y do
      dst
    else
      range_helper(x + 1, y, dst ++ [x])
    end
  end
end
