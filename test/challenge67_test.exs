defmodule Challenge67Test do
  use ExUnit.Case

  test "string_repr_to_tree" do
    assert is_nil(Challenge67.string_repr_to_tree(nil))
    assert is_nil(Challenge67.string_repr_to_tree(""))
    assert Challenge67.string_repr_to_tree("ab") == %TreeNode{symbol: "ab"}

    assert Challenge67.string_repr_to_tree("a(l,)") == %TreeNode{
             symbol: "a",
             left: %TreeNode{symbol: "l"},
             right: nil
           }

    assert Challenge67.string_repr_to_tree("a(,r)") == %TreeNode{
             symbol: "a",
             right: %TreeNode{symbol: "r"},
             left: nil
           }

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

    assert Challenge67.string_repr_to_tree("a(b(d,e),c(,f(g,)))") == t
  end

  test "tree_to_string_repr" do
    assert Challenge67.tree_to_string_repr(nil) == ""
    assert Challenge67.tree_to_string_repr(%TreeNode{}) == ""
    assert Challenge67.tree_to_string_repr(%TreeNode{symbol: "ab"}) == "ab"

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

    assert Challenge67.tree_to_string_repr(t) == "a(b(d,e),c(,f(g,)))"

    assert Challenge67.tree_to_string_repr(%TreeNode{
             symbol: "a",
             left: %TreeNode{symbol: "l"},
             right: nil
           }) == "a(l,)"

    assert Challenge67.tree_to_string_repr(%TreeNode{
             symbol: "a",
             right: %TreeNode{symbol: "r"},
             left: nil
           }) == "a(,r)"
  end
end
