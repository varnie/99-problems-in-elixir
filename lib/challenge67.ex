defmodule Challenge67 do
  @moduledoc """
  (**) A string representation of binary trees
     Somebody represents binary trees as strings of the following type (see example opposite):
     a(b(d,e),c(,f(g,)))
     a) Write a Lisp function which generates this string representation, if the tree is given as usual (as nil or (X L R) expression).
     Then write a function which does this inverse; i.e. given the string representation, construct the tree in the usual form.
  """

  def tree_to_string_repr(tree) do
    cond do
      is_nil(tree) ->
        ""

      TreeNode.is_leaf(tree) ->
        "#{tree.symbol}"

      true ->
        "#{tree.symbol}" <>
          "(" <>
          if !is_nil(tree.left) do
            tree_to_string_repr(tree.left)
          else
            ""
          end <>
          "," <>
          if !is_nil(tree.right) do
            tree_to_string_repr(tree.right)
          else
            ""
          end <> ")"
    end
  end
end
