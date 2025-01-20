defmodule Challenge62BTest do
  use ExUnit.Case

  test "internals" do
    assert Challenge62B.atlevel(%TreeNode{symbol: 1}, 0) == []
    assert Challenge62B.atlevel(%TreeNode{symbol: 1}, 1) == [%TreeNode{symbol: 1}]

    assert Challenge62B.atlevel(nil, 1) == []

    assert Challenge62B.atlevel(
             %TreeNode{
               symbol: 1,
               weight: nil,
               left: %TreeNode{
                 symbol: 2,
                 weight: nil,
                 left: %TreeNode{symbol: 3, weight: nil, left: nil, right: nil},
                 right: nil
               },
               right: %TreeNode{
                 symbol: 4,
                 weight: nil,
                 left: nil,
                 right: %TreeNode{left: nil, right: nil, symbol: 5, weight: nil}
               }
             },
             2
           ) == [
             %TreeNode{
               symbol: 2,
               weight: nil,
               left: %TreeNode{symbol: 3, weight: nil, left: nil, right: nil},
               right: nil
             },
             %TreeNode{
               symbol: 4,
               weight: nil,
               left: nil,
               right: %TreeNode{symbol: 5, weight: nil, left: nil, right: nil}
             }
           ]
  end
end
