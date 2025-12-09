defmodule Challenge95 do
  @moduledoc """
  P95 (**) English number words
    On financial documents, like cheques, numbers must sometimes be written in full words.
    Example: 175 must be written as one-seven-five. Write a function (full-words n) to print
    (non-negative) integer numbers in full words.
  """

  def full_words(n) when n >= 0 do
    n
    |> number_to_digits_list()
    |> Enum.map(&digit_to_word/1)
    |> Enum.join("-")
  end

  def number_to_digits_list(num, result \\ []) do
    if num >= 10 do
      number_to_digits_list(div(num, 10), result ++ [rem(num, 10)])
    else
      Enum.reverse(result ++ [num])
    end
  end

  defp digit_to_word(digit) do
    case digit do
      0 -> "zero"
      1 -> "one"
      2 -> "two"
      3 -> "three"
      4 -> "four"
      5 -> "five"
      6 -> "six"
      7 -> "seven"
      8 -> "eight"
      9 -> "nine"
      _ -> raise ArgumentError, "Invalid digit: #{digit}"
    end
  end
end
