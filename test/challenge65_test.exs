defmodule Challenge65Test do
  use ExUnit.Case

  test "layout_binary_tree" do
    assert Challenge65.layout_binary_tree(nil) == ""
    assert Challenge65.layout_binary_tree(%TreeNode{symbol: "a"}, 10) == "(a 10 1 nil nil)"

    assert Challenge65.layout_binary_tree(%TreeNode{
             symbol: "a",
             left: %TreeNode{symbol: "l"},
             right: nil
           }) == "(a 10 1 (l 5.0 2 nil nil) nil)"

    assert Challenge65.layout_binary_tree(%TreeNode{
             symbol: "a",
             right: %TreeNode{symbol: "r"},
             left: nil
           }) == "(a 10 1 nil (r 15.0 2 nil nil))"

    assert Challenge65.layout_binary_tree(%TreeNode{
             symbol: "a",
             left: %TreeNode{symbol: "l"},
             right: %TreeNode{symbol: "r"}
           }) == "(a 10 1 (l 5.0 2 nil nil) (r 15.0 2 nil nil))"

    t = %TreeNode{
      symbol: "a",
      weight: nil,
      left: %TreeNode{
        symbol: "b",
        weight: nil,
        left: %TreeNode{symbol: "d", weight: nil, left: nil, right: nil},
        right: %TreeNode{symbol: "e", weight: nil, left: nil, right: nil}
      },
      right: %TreeNode{
        symbol: "c",
        weight: nil,
        left: nil,
        right: %TreeNode{
          symbol: "f",
          weight: nil,
          left: %TreeNode{symbol: "g", weight: nil, left: nil, right: nil},
          right: nil
        }
      }
    }

    assert Challenge65.layout_binary_tree(t) ==
             "(a 10 1 (b 5.0 2 (d 2.5 3 nil nil) (e 7.5 3 nil nil)) (c 15.0 2 nil (f 17.5 3 (g 16.25 4 nil nil) nil)))"
  end
end
