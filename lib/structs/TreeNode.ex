defmodule TreeNode do
  defstruct symbol: nil, left: nil, right: nil

  def is_leaf(node) do
    is_nil(node.left) && is_nil(node.right)
  end

  def set_left(node, l) do
    %TreeNode{node | left: l}
  end

  def set_right(node, r) do
    %TreeNode{node | right: r}
  end
end
