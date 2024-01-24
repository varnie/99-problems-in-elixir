defmodule Challenge25 do
  @doc """
  (*) Generate a random permutation of the elements of a list. Solutions
  """
  def rnd_permu(lst) do
    tmp_list = Challenge24.rnd_select(length(lst), length(lst))

    Enum.map(tmp_list, fn item ->
      # here item stands for an index of an element in the lst starting from 1
      Enum.at(lst, item - 1)
    end)
  end
end
