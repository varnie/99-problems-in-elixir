defmodule Challenge12 do
  @doc """
  **) Decode a run-length encoded list.
    Given a run-length code list generated as specified in problem P11. Construct its uncompressed version.
  """
  def decode(lst) do
    Enum.reduce(lst, [], fn item, acc ->
      case item do
        {count, letter} -> acc ++ List.duplicate(letter, count)
        _ -> acc ++ [item]
      end
    end)
  end

    @spec decode_my1(any()) :: list()
  @doc """
  **) Decode a run-length encoded list.
    Given a run-length code list generated as specified in problem P11. Construct its uncompressed version.
  """
  def decode_my1(lst) do
    list_of_lists =
      for item <- lst do
        case item do
          {count, letter} -> List.duplicate(letter, count)
          _ -> [item]
        end
      end

    List.flatten(list_of_lists)
  end

  @doc """
  **) Decode a run-length encoded list.
    Given a run-length code list generated as specified in problem P11. Construct its uncompressed version.
  """
  def decode_my2(lst) do
    for item <- lst, reduce: [] do
      acc when is_tuple(item) and tuple_size(item) == 2 ->
        {count, letter} = item
        acc ++ List.duplicate(letter, count)

      acc ->
        acc ++ [item]
    end
  end
end
