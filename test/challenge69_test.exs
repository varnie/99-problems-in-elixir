defmodule Challenge69Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     some_tree: %TreeNode{
       symbol: "a",
       left: %TreeNode{
         symbol: "b",
         left: %TreeNode{symbol: "d", left: nil, right: nil},
         right: %TreeNode{symbol: "e", left: nil, right: nil}
       },
       right: %TreeNode{
         symbol: "c",
         left: nil,
         right: %TreeNode{
           symbol: "f",
           left: %TreeNode{symbol: "g", left: nil, right: nil},
           right: nil
         }
       }
     }}
  end

  test "dotstring_to_tree", state do
    t = state[:some_tree]
    ds = Challenge69.dotstring(t)

    assert Challenge69.dotstring_to_tree(ds) == t
  end

  test "dotstring", state do
    t = state[:some_tree]

    assert Challenge69.dotstring(t) == "abd..e..c.fg..."
  end
end
