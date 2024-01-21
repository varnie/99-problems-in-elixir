defmodule Challenge28 do
  @doc """
  a) Sorting a list of lists according to length of sublists.
  a) We suppose that a list contains elements that are lists themselves.
  The objective is to sort the elements of this list according to their length.
  E.g. short lists first, longer lists later, or vice versa.
  """

  def lsort(lst_of_lsts) do
    Enum.reduce(lst_of_lsts, [], fn src_elem, acc ->
      src_elem_len = length(src_elem)

      pos =
        Enum.count(acc, fn dst_elem ->
          src_elem_len >= length(dst_elem)
        end)

      acc = List.insert_at(acc, pos, src_elem)
      acc
    end)
  end

  def lsort_another_version(lst_of_lists) do
    Enum.sort(lst_of_lists, &(length(&1) <= length(&2)))
  end

  @doc """
  b) Again, we suppose that a list contains elements that are lists themselves.
  But this time the objective is to sort the elements of this list according to their length frequency;
  i.e., in the default, where sorting is done ascendingly, lists with rare lengths are placed first,
  others with a more frequent length come later.
  """
  def lfsort(lst_of_lists) do
    frequencies = Enum.frequencies_by(lst_of_lists, &length/1)

    Enum.sort(lst_of_lists, fn item1, item2 ->
      frequencies[length(item1)] <= frequencies[length(item2)]
    end)
  end
end
