defmodule Challenge11 do
  @doc """
  (*)
    Modified run-length encoding.
    Modify the result of problem P10 in such a way that if an element has no duplicates it is simply copied into the result list.
    Only elements with duplicates are transferred as [N,E] terms.
  """
  def encode_modified(lst) do
    encoded = Challenge10.encode(lst)

    Enum.map(encoded, fn item ->
      {len, letter} = item

      result =
        if len > 1 do
          item
        else
          letter
        end

      result
    end)
  end
end
