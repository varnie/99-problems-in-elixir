defmodule Challenge57Test do
  use ExUnit.Case

  test "construct" do
    assert Challenge57.construct([]) == nil
    assert Challenge57.construct([1]) == %TreeNode{symbol: 1, left: nil, right: nil}

    assert Challenge57.construct([1, 2]) == %TreeNode{
             symbol: 1,
             weight: nil,
             left: nil,
             right: %TreeNode{symbol: 2, weight: nil, left: nil, right: nil}
           }

    assert Challenge57.construct([1, 2, 3]) == %TreeNode{
             symbol: 1,
             weight: nil,
             left: nil,
             right: %TreeNode{
               symbol: 2,
               weight: nil,
               left: nil,
               right: %TreeNode{symbol: 3, weight: nil, left: nil, right: nil}
             }
           }

    assert Challenge57.construct([3, 2, 5, 7, 1]) == %TreeNode{
             symbol: 3,
             weight: nil,
             left: %TreeNode{
               symbol: 2,
               weight: nil,
               left: %TreeNode{symbol: 1, weight: nil, left: nil, right: nil},
               right: nil
             },
             right: %TreeNode{
               symbol: 5,
               weight: nil,
               left: nil,
               right: %TreeNode{left: nil, right: nil, symbol: 7, weight: nil}
             }
           }
  end
end
