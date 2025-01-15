defmodule Challenge55 do
  @doc """
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
  def cbal_tree(count) do
    cond do
      count == 0 ->
        [nil]

      count == 1 ->
        [%TreeNode{symbol: :x, left: nil, right: nil}]

      count == 2 ->
        [
          %TreeNode{symbol: :x, left: %TreeNode{symbol: :x, left: nil, right: nil}, right: nil},
          %TreeNode{symbol: :x, left: nil, right: %TreeNode{symbol: :x, left: nil, right: nil}}
        ]

      true ->
        cbal_tree_helper(cbal_tree(count - 1))
    end
  end

  # TODO: refactor
  defp cbal_tree_helper(nodes_list) do
    nodes_list
    |> Enum.map(fn node ->
      new_left_nodes_list = gen_new_nodes(node.left)
      new_right_nodes_list = gen_new_nodes(node.right)

      result_a =
        Enum.reduce(new_left_nodes_list, [], fn new_left_node, acc ->
          [%TreeNode{symbol: node.symbol, left: new_left_node, right: node.right} | acc]
        end)

      result_b =
        Enum.reduce(new_right_nodes_list, [], fn new_right_node, acc ->
          [%TreeNode{symbol: node.symbol, left: node.left, right: new_right_node} | acc]
        end)

      Enum.concat(result_a, result_b)
    end)
    |> List.flatten()
    |> Enum.filter(fn node ->
      calc_condition_is_met(node)
    end)
    |> Enum.uniq()
  end

  # TODO: refactor
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

  defp calc_condition_is_met(node) do
    cond do
      is_nil(node) -> true
      abs(count_nodes_in_tree(node.left) - count_nodes_in_tree(node.right)) <= 1 -> true
      true -> false
    end
  end

  def count_nodes_in_tree(node) do
    if is_nil(node) do
      0
    else
      count = 1

      count_nodes_in_left_subtree =
        if !is_nil(node.left) do
          count_nodes_in_tree(node.left)
        else
          0
        end

      count_nodes_in_right_subtree =
        if !is_nil(node.right) do
          count_nodes_in_tree(node.right)
        else
          0
        end

      count + count_nodes_in_left_subtree + count_nodes_in_right_subtree
    end
  end
end
