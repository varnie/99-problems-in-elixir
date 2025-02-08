defmodule Challenge65 do
  @moduledoc """
    (**) Layout a binary tree (2)
       An alternative layout method is depicted in the illustration opposite.
       Find out the rules and write the corresponding Lisp function.
       Hint: On a given level, the horizontal distance between neighboring nodes is constant.

       Use the same conventions as in problem P64 and test your function in an appropriate way.
  """

  def layout_binary_tree(nil), do: ""
  def layout_binary_tree(t), do: layout_binary_tree_impl(t, 10, 1, 10 / 2)

  defp layout_binary_tree_impl(t, rootx, rooty, coeff) do
    if TreeNode.is_leaf(t) do
      "(#{t.symbol} nil nil)"
    else
      "(" <>
        "#{t.symbol} #{rootx} #{rooty} " <>
        if is_nil(t.left) do
          "nil "
        else
          layout_binary_tree_impl(t.left, rootx - coeff, rooty + 1, coeff / 2)
        end <>
        if is_nil(t.right) do
          "nil"
        else
          layout_binary_tree_impl(t.right, rootx + coeff, rooty + 1, coeff / 2)
        end <>
        ")"
    end
  end
end
