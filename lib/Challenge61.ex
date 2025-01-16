defmodule Challenge61 do
  @doc """
    (*) Count the leaves of a binary tree
        A leaf is a node with no successors. Write a function count-leaves to count them.

        (count-leaves tree) returns the number of leaves of binary tree tree
  """
  def count_leaves(tree) do
    cond do
      is_nil(tree) -> 0
      TreeNode.is_leaf(tree) -> 1
      true -> count_leaves(tree.left) + count_leaves(tree.right)
    end
  end
end
