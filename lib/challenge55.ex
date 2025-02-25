defmodule Challenge55 do
  @moduledoc """
    (**) Construct completely balanced binary trees
        In a completely balanced binary tree, the following property holds for every node:
        The number of nodes in its left subtree and the number of nodes in its right subtree are almost equal,
        which means their difference is not greater than one.

        Write a function cbal-tree to construct completely balanced binary trees for a given number of nodes.
        The function should generate all solutions. Put the symbol 'x' as information into all nodes of the tree.
        Example:
        * (cbal-tree-print 4)
        (X (X NIL NIL) (X NIL (X NIL NIL)))
        (X (X NIL NIL) (X (X NIL NIL) NIL))
        etc......
  """

  # TODO: buggy
  def cbal_tree(count) do
    cond do
      count == 0 ->
        [nil]

      count == 1 ->
        [%TreeNode{symbol: :x, left: nil, right: nil}]

      true ->
        cbal_tree_helper(cbal_tree(count - 1))
    end
  end

  defp cbal_tree_helper(nodes_list) do
    nodes_list
    |> Enum.reduce([], fn x, acc ->
      new_nodes = x |> gen_new_nodes() |> Enum.filter(&check_condition_is_met/1)
      Enum.concat(acc, new_nodes)
    end)
    |> Enum.uniq()
  end

  defp gen_new_nodes(node) do
    if is_nil(node) do
      [%TreeNode{symbol: :x, left: nil, right: nil}]
    else
      if TreeNode.is_leaf(node) do
        [
          TreeNode.set_left(node, %TreeNode{symbol: :x, left: nil, right: nil}),
          TreeNode.set_right(node, %TreeNode{symbol: :x, left: nil, right: nil})
        ]
      else
        new_left_nodes_list = gen_new_nodes(node.left)
        new_right_nodes_list = gen_new_nodes(node.right)

        result_a =
          Enum.reduce(new_left_nodes_list, [], fn new_left_node, acc ->
            [TreeNode.set_left(node, new_left_node) | acc]
          end)

        result_b =
          Enum.reduce(new_right_nodes_list, [], fn new_right_node, acc ->
            [TreeNode.set_right(node, new_right_node) | acc]
          end)

        Enum.concat(result_a, result_b)
      end
    end
  end

  defp check_condition_is_met(node) do
    is_nil(node) ||
      (abs(count_nodes_in_tree(node.left) - count_nodes_in_tree(node.right)) <= 1 &&
         check_condition_is_met(node.left) && check_condition_is_met(node.right))
  end

  defp count_nodes_in_tree(node) do
    if is_nil(node),
      do: 0,
      else: 1 + count_nodes_in_tree(node.left) + count_nodes_in_tree(node.right)
  end
end
