defmodule Challenge63Test do
  use ExUnit.Case

  test "complete_binary_tree" do
    assert Challenge63.complete_binary_tree(0) == nil

    assert Challenge63.complete_binary_tree(1) == %TreeNode{
             symbol: 1,
             weight: nil,
             left: nil,
             right: nil
           }

    assert Challenge63.complete_binary_tree(2) == %TreeNode{
             symbol: 1,
             weight: nil,
             left: %TreeNode{symbol: 2, weight: nil, left: nil, right: nil},
             right: nil
           }

    assert Challenge63.complete_binary_tree(3) == %TreeNode{
             symbol: 1,
             weight: nil,
             left: %TreeNode{symbol: 2, weight: nil, left: nil, right: nil},
             right: %TreeNode{symbol: 3, weight: nil, left: nil, right: nil}
           }

    assert Challenge63.complete_binary_tree(4) == %TreeNode{
             symbol: 1,
             weight: nil,
             left: %TreeNode{
               symbol: 2,
               weight: nil,
               left: %TreeNode{symbol: 4, weight: nil, left: nil, right: nil},
               right: nil
             },
             right: %TreeNode{symbol: 3, weight: nil, left: nil, right: nil}
           }

    # assert Challenge62B.atlevel(
    #          %TreeNode{
    #            symbol: 1,
    #            weight: nil,
    #            left: %TreeNode{
    #              symbol: 2,
    #              weight: nil,
    #              left: %TreeNode{symbol: 3, weight: nil, left: nil, right: nil},
    #              right: nil
    #            },
    #            right: %TreeNode{
    #              symbol: 4,
    #              weight: nil,
    #              left: nil,
    #              right: %TreeNode{left: nil, right: nil, symbol: 5, weight: nil}
    #            }
    #          },
    #          2
    #        ) == [
    #          %TreeNode{
    #            symbol: 2,
    #            weight: nil,
    #            left: %TreeNode{symbol: 3, weight: nil, left: nil, right: nil},
    #            right: nil
    #          },
    #          %TreeNode{
    #            symbol: 4,
    #            weight: nil,
    #            left: nil,
    #            right: %TreeNode{symbol: 5, weight: nil, left: nil, right: nil}
    #          }
    #        ]
  end
end
