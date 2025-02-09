defmodule Challenge68Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     alr_tree: %TreeNode{
       symbol: "a",
       weight: nil,
       left: %TreeNode{symbol: "l", weight: nil, left: nil, right: nil},
       right: %TreeNode{symbol: "r", weight: nil, left: nil, right: nil}
     },
     al_tree: %TreeNode{
       symbol: "a",
       weight: nil,
       left: %TreeNode{symbol: "l", weight: nil, left: nil, right: nil},
       right: nil
     },
     ar_tree: %TreeNode{
       symbol: "a",
       weight: nil,
       right: %TreeNode{symbol: "r", weight: nil, left: nil, right: nil},
       left: nil
     },
     some_tree: %TreeNode{
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
     }}
  end

  test "preorder_sequence_to_tree", state do
    assert Challenge68.preorder_sequence_to_tree(nil) == nil
    assert Challenge68.preorder_sequence_to_tree("") == nil
    assert Challenge68.preorder_sequence_to_tree("a l r") == state[:alr_tree]
    assert Challenge68.preorder_sequence_to_tree("a l") == state[:al_tree]

    assert Challenge68.preorder_sequence_to_tree("a r") == %TreeNode{
             symbol: "a",
             left: %TreeNode{symbol: "r", left: nil, right: nil, weight: nil},
             right: nil
           }

    assert Challenge68.preorder_sequence_to_tree("a b d e c f g") == %TreeNode{
             symbol: "a",
             left: %TreeNode{symbol: "b", left: nil, right: nil},
             right: %TreeNode{
               symbol: "d",
               left: %TreeNode{symbol: "e", left: nil, right: nil},
               right: %TreeNode{
                 symbol: "c",
                 left: %TreeNode{symbol: "f", left: nil, right: nil},
                 right: %TreeNode{symbol: "g", left: nil, right: nil}
               }
             }
           }
  end

  test "preorder", state do
    assert Challenge68.preorder(nil) == nil

    assert Challenge68.preorder(state[:alr_tree]) == "a l r"

    assert Challenge68.preorder(state[:al_tree]) == "a l"

    assert Challenge68.preorder(state[:ar_tree]) == "a r"

    assert Challenge68.preorder(state[:some_tree]) == "a b d e c f g"
  end

  test "inorder", state do
    assert Challenge68.inorder(nil) == nil

    assert Challenge68.inorder(state[:alr_tree]) == "l a r"

    assert Challenge68.inorder(state[:al_tree]) == "l a"

    assert Challenge68.inorder(state[:ar_tree]) == "a r"

    assert Challenge68.inorder(state[:some_tree]) == "d b e a f c g"
  end
end
