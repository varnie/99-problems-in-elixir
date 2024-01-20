defmodule Challenge23 do
  @doc """
  (*) Extract a given number of randomly selected elements from a list.
  """
  def rnd_select(lst, k) do
    cond do
      k < 0 -> []
      true -> Enum.take_random(lst, k)
    end
  end
end
