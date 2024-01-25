defmodule Challenge13 do
  import CountLetter

  @doc """
  (**) Run-length encoding of a list (direct solution).
    Implement the so-called run-length encoding data compression method directly.
    I.e. don't explicitly create the sublists containing the duplicates, as in problem P09, but only count them.
    As in problem P11, simplify the result list by replacing the singleton terms [1,X] by X.
  """
  def encode_direct(lst) do
    encode_direct_helper(lst, [], %CountLetter{count: 0, letter: nil}) |> Enum.reverse()
  end

  defp encode_direct_helper([], dst, countLetter = %CountLetter{count: count, letter: letter}) do
    if count > 0 && !is_nil(letter) do
      [decide_generated_item(countLetter) | dst]
    else
      dst
    end
  end

  defp encode_direct_helper(
         [head | tail],
         dst,
         countLetter = %CountLetter{count: count, letter: letter}
       ) do
    if is_nil(letter) do
      encode_direct_helper(tail, dst, %{countLetter | count: 1, letter: head})
    else
      case head == letter do
        true ->
          encode_direct_helper(tail, dst, %{countLetter | count: count + 1, letter: head})

        _ ->
          encode_direct_helper(tail, [decide_generated_item(countLetter) | dst], %{
            countLetter
            | count: 1,
              letter: head
          })
      end
    end
  end

  defp decide_generated_item(%CountLetter{count: count, letter: letter}) do
    if count == 1 do
      letter
    else
      {count, letter}
    end
  end
end
