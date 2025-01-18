defmodule Challenge55Test do
  use ExUnit.Case

  setup_all do
    {:ok,
     cbal_tree_2_result_list: [
       %TreeNode{symbol: :x, left: %TreeNode{symbol: :x, left: nil, right: nil}, right: nil},
       %TreeNode{symbol: :x, left: nil, right: %TreeNode{symbol: :x, left: nil, right: nil}}
     ],
     cbal_tree_3_result_list: [
       %TreeNode{
         symbol: :x,
         left: %TreeNode{symbol: :x, weight: nil, left: nil, right: nil},
         right: %TreeNode{symbol: :x, weight: nil, left: nil, right: nil}
       }
     ]}
  end

  test "cbal_tree_0" do
    assert Challenge55.cbal_tree(0) == [nil]
  end

  test "cbal_tree_1" do
    assert Challenge55.cbal_tree(1) == [%TreeNode{symbol: :x, left: nil, right: nil}]
  end

  test "cbal_tree_2", state do
    result_2 = Challenge55.cbal_tree(2)
    desired_result_2 = state[:cbal_tree_2_result_list]
    assert length(result_2) == length(desired_result_2)

    assert Enum.all?(result_2, fn elem ->
             elem in desired_result_2
           end)
  end

  test "cbal_tree_3", state do
    result_3 = Challenge55.cbal_tree(3)
    desired_result_3 = state[:cbal_tree_3_result_list]
    assert length(result_3) == length(desired_result_3)

    assert Enum.all?(result_3, fn elem ->
             elem in desired_result_3
           end)
  end
end
