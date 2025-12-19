defmodule Challenge96 do
  @moduledoc """
  P96 (**) Syntax checker (alternative solution with difference lists)
    In a certain programming language (Ada) identifiers are defined by the syntax diagram (railroad chart) opposite.
    Transform the syntax diagram into a system of syntax diagrams which do not contain loops;
    i.e. which are purely recursive. Using these modified diagrams, write a function (identifier str)
    that can check whether or not a given string s is a legal identifier.

    (identifier str) returns true when str is a legal identifier.
  """

  def identifier(str) do
    graphemes = String.graphemes(str)

    case graphemes do
      [] -> false
      [a] -> is_letter?(a)
      [h | tail] -> is_letter?(h) and is_block?(tail)
    end
  end

  defp is_block?(lst) do
    case lst do
      [] ->
        true

      [x] ->
        is_letter_or_digit?(x)

      ["_" | tail = [tail_a | _rest]] ->
        !is_underscore?(tail_a) and is_block?(tail)

      [x | tail] ->
        is_letter_or_digit?(x) and is_block?(tail)
    end
  end

  defp is_letter_or_digit?(x), do: is_letter?(x) or is_digit?(x)

  defp is_letter?(x), do: String.match?(x, ~r/^[A-Za-z]$/)

  defp is_digit?(x), do: String.match?(x, ~r/^[0-9]$/)

  defp is_underscore?(x), do: x == "_"
end
