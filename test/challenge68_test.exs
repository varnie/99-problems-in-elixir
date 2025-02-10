defmodule Challenge68Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     alr_tree: %TreeNode{
       symbol: "a",
       left: %TreeNode{symbol: "l", left: nil, right: nil},
       right: %TreeNode{symbol: "r", left: nil, right: nil}
     },
     al_tree: %TreeNode{
       symbol: "a",
       left: %TreeNode{symbol: "l", left: nil, right: nil},
       right: nil
     },
     ar_tree: %TreeNode{
       symbol: "a",
       right: %TreeNode{symbol: "r", left: nil, right: nil},
       left: nil
     },
     some_tree: %TreeNode{
       symbol: "a",
       left: %TreeNode{
         symbol: "b",
         left: %TreeNode{symbol: "d"},
         right: %TreeNode{symbol: "e"}
       },
       right: %TreeNode{
         symbol: "c",
         left: nil,
         right: %TreeNode{symbol: "f", left: %TreeNode{symbol: "g"}, right: nil}
       }
     }}
  end

  test "preorder_sequence_to_tree", state do
    assert Challenge68.preorder_sequence_to_tree(nil) == nil
    assert Challenge68.preorder_sequence_to_tree("") == nil
    assert Challenge68.preorder_sequence_to_tree("alr") == state[:alr_tree]
    assert Challenge68.preorder_sequence_to_tree("al") == state[:al_tree]

    assert Challenge68.preorder_sequence_to_tree("ar") == %TreeNode{
             symbol: "a",
             left: %TreeNode{symbol: "r", left: nil, right: nil},
             right: nil
           }

    assert Challenge68.preorder_sequence_to_tree("abdecfg") == %TreeNode{
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
    assert Challenge68.preorder(nil) == ""

    assert Challenge68.preorder(state[:alr_tree]) == "alr"

    assert Challenge68.preorder(state[:al_tree]) == "al"

    assert Challenge68.preorder(state[:ar_tree]) == "ar"

    assert Challenge68.preorder(state[:some_tree]) == "abdecfg"
  end

  test "inorder", state do
    assert Challenge68.inorder(nil) == ""

    assert Challenge68.inorder(state[:alr_tree]) == "lar"

    assert Challenge68.inorder(state[:al_tree]) == "la"

    assert Challenge68.inorder(state[:ar_tree]) == "ar"

    assert Challenge68.inorder(state[:some_tree]) == "dbeacgf"
  end
end
