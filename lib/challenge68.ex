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
