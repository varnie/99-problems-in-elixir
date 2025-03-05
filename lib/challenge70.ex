defmodule Challenge70 do
  @moduledoc """
  (*) Check whether a given expression represents a multiway tree
      Write a function istree which succeeds if and only if its argument is a Lisp expression representing a multiway tree.
      Example:
      * (istree '(a (f g) c (b d e)))
      T

  (*) Count the nodes of a multiway tree
      Write a function nnodes which counts the nodes of a given multiway tree.
      Example:
      * (nnodes '(a f))
      2
  """

  def nnodes(t = [_a, _b | _tail]) do
    t |> Enum.sum_by(&nnodes/1)
  end

  def nnodes(_a), do: 1

  def is_tree(t = [_a, _b | _tail]), do: Enum.all?(t, fn x -> is_root(x) || is_tree(x) end)
  def is_tree(a), do: is_root(a)
  defp is_root(a), do: is_atom(a) && !is_nil(a)
end
