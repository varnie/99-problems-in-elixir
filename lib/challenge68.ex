defmodule Challenge68 do
  @moduledoc """
  (**) Preorder and inorder sequences of binary trees
     We consider binary trees with nodes that are identified by single lower-case letters, as in the example of problem P67.

     a) Write functions preorder and inorder that construct the preorder and inorder sequence of a given binary tree, respectively.
     The results should be lists, e.g. (A B D E C F G) for the preorder sequence of the example in problem P67.

     b) Can you write the inverse of preorder from problem part a) ; i.e. given a preorder sequence, construct a corresponding tree?

     c) If both the preorder sequence and the inorder sequence of the nodes of a binary tree are given,
     then the tree is determined unambiguously. Write a function pre-in-tree that does the job.
  """
  def preorder_sequence_to_tree(nil), do: nil
  def preorder_sequence_to_tree(""), do: nil

  def preorder_sequence_to_tree(seq) do
    seq |> String.split() |> preorder_sequence_to_tree_impl()
  end

  defp preorder_sequence_to_tree_impl([head | tail]) do
    tree = %TreeNode{symbol: head}
    Enum.reduce(tail, tree, &insert_node_where_appropriate/2)
  end

  defp insert_node_where_appropriate(node_name, tree) do
    cond do
      is_nil(tree.left) -> TreeNode.set_left(tree, %TreeNode{symbol: node_name})
      is_nil(tree.right) -> TreeNode.set_right(tree, %TreeNode{symbol: node_name})
      true -> TreeNode.set_right(tree, insert_node_where_appropriate(node_name, tree.right))
    end
  end

  def preorder(nil), do: nil

  def preorder(t) do
    if TreeNode.is_leaf(t) do
      t.symbol
    else
      t.symbol <>
        if !is_nil(t.left) do
          " " <> preorder(t.left)
        else
          ""
        end <>
        if !is_nil(t.right) do
          " " <> preorder(t.right)
        else
          ""
        end
    end
  end

  def inorder(nil), do: nil

  def inorder(t) do
    if TreeNode.is_leaf(t) do
      t.symbol
    else
      if !is_nil(t.left) do
        inorder(t.left) <> " "
      else
        ""
      end <>
        t.symbol <>
        if !is_nil(t.right) do
          " " <> inorder(t.right)
        else
          ""
        end
    end
  end
end
