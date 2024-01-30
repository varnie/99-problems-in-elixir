defmodule TreeNode do
  defstruct symbol: nil, weight: nil, left: nil, right: nil

  def is_leaf(node) do
    is_nil(node.left) && is_nil(node.right)
  end
end
