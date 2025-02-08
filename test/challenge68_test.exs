defmodule Challenge68Test do
  use ExUnit.Case

  test "preorder" do
    assert Challenge68.preorder(nil) == nil

    assert Challenge68.preorder(%TreeNode{
             symbol: "a",
             weight: nil,
             left: %TreeNode{symbol: "l", weight: nil, left: nil, right: nil},
             right: %TreeNode{symbol: "r", weight: nil, left: nil, right: nil}
           }) == "a l r"

    assert Challenge68.preorder(%TreeNode{
             symbol: "a",
             weight: nil,
             left: %TreeNode{symbol: "l", weight: nil, left: nil, right: nil},
             right: nil
           }) == "a l"

    assert Challenge68.preorder(%TreeNode{
             symbol: "a",
             weight: nil,
             right: %TreeNode{symbol: "r", weight: nil, left: nil, right: nil},
             left: nil
           }) == "a r"

    assert Challenge68.preorder(%TreeNode{
             symbol: "a",
             weight: nil,
             left: %TreeNode{
               symbol: "b",
               left: %TreeNode{
                 symbol: "d"
               },
               right: %TreeNode{symbol: "e"}
             },
             right: %TreeNode{
               symbol: "c",
               weight: nil,
               left: %TreeNode{symbol: "f"},
               right: %TreeNode{symbol: "g"}
             }
           }) == "a b d e c f g"
  end

  test "inorder" do
    assert Challenge68.inorder(nil) == nil

    assert Challenge68.inorder(%TreeNode{
             symbol: "a",
             weight: nil,
             left: %TreeNode{symbol: "l", weight: nil, left: nil, right: nil},
             right: %TreeNode{symbol: "r", weight: nil, left: nil, right: nil}
           }) == "l a r"

    assert Challenge68.inorder(%TreeNode{
             symbol: "a",
             weight: nil,
             left: %TreeNode{symbol: "l", weight: nil, left: nil, right: nil},
             right: nil
           }) == "l a"

    assert Challenge68.inorder(%TreeNode{
             symbol: "a",
             weight: nil,
             right: %TreeNode{symbol: "r", weight: nil, left: nil, right: nil},
             left: nil
           }) == "a r"

    assert Challenge68.inorder(%TreeNode{
             symbol: "a",
             weight: nil,
             left: %TreeNode{
               symbol: "b",
               left: %TreeNode{
                 symbol: "d"
               },
               right: %TreeNode{symbol: "e"}
             },
             right: %TreeNode{
               symbol: "c",
               weight: nil,
               left: %TreeNode{symbol: "f"},
               right: %TreeNode{symbol: "g"}
             }
           }) == "d b e a f c g"
  end
end
