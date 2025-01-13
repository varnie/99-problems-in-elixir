defmodule Challenge51 do
  @doc """
  (*) Check whether a given expression represents a binary tree
  Write a function istree which returns true if and only if its argument is a list representing a binary tree.
  """
  def is_tree(src) do
    is_tree_helper(src)
  end

  defp is_tree_helper(nil), do: true

  defp is_tree_helper([root, l, r]) when root != nil and is_atom(root),
    do: is_tree_helper(l) && is_tree_helper(r)

  defp is_tree_helper(_), do: false
end
