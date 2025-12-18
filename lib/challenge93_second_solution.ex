defmodule Challenge93SecondSolution do
  @moduledoc """
  P95 (***) An arithmetic puzzle
    Given a list of integer numbers, find a correct way of inserting arithmetic signs (operators) such that
    the result is a correct equation.
    Example: With the list of numbers (2 3 5 7 11) we can form the equations 2-3+5+7 = 11
    or 2 = (3*5+7)/11 (and ten others!).
  """

  @ops ["+", "-", "/", "*"]

  def solutions(numbers) when length(numbers) < 2 do
    raise("Two or more items required")
  end

  def solutions(numbers) do
    result =
      for i <- 1..(length(numbers) - 1) do
        {x, y} = Enum.split(numbers, i)

        left_combs =
          gen_combs(x)

        right_combs =
          gen_combs(y)

        for left_comb <- left_combs,
            right_comb <- right_combs,
            calc_tree_weight(left_comb) == calc_tree_weight(right_comb) do
          "#{tree_to_str(left_comb)}=#{tree_to_str(right_comb)}"
        end
      end

    result |> Enum.concat()
  end

  def tree_to_str(tree, is_inner \\ false) do
    #TODO: better brackets implementation needed

    if TreeNode.is_leaf(tree) do
      "#{tree.symbol}"
    else
      left_str = tree_to_str(tree.left, true)
      right_str = tree_to_str(tree.right, true)

      if is_inner do
        "(#{left_str}#{tree.symbol}#{right_str})"
      else
        "#{left_str}#{tree.symbol}#{right_str}"
      end
    end
  end

  def gen_combs([head | tail], result \\ []) do
    new_result =
      case result do
        [] ->
          [
            %TreeNode{
              symbol: head,
              left: nil,
              right: nil
            }
          ]

        _ ->
          Enum.map(result, fn cur_tree ->
            Enum.map(@ops, fn cur_op ->
              cond do
                is_nil(cur_tree.left) ->
                  [
                    %TreeNode{
                      symbol: cur_op,
                      left: cur_tree,
                      right: %TreeNode{
                        symbol: head,
                        left: nil,
                        right: nil
                      }
                    }
                  ]

                true ->
                  [
                    %TreeNode{
                      symbol: cur_op,
                      left: cur_tree,
                      right: %TreeNode{
                        symbol: head,
                        left: nil,
                        right: nil
                      }
                    },
                    %TreeNode{
                      symbol: cur_tree.symbol,
                      left: cur_tree.left,
                      right: %TreeNode{
                        symbol: cur_op,
                        left: cur_tree.right,
                        right: %TreeNode{
                          symbol: head,
                          left: nil,
                          right: nil
                        }
                      }
                    }
                  ]
              end
            end)
            |> Enum.concat()
          end)
          |> Enum.concat()
      end

    case tail do
      [] -> new_result
      _ -> gen_combs(tail, new_result)
    end
  end

  def calc_tree_weight(tree) do
    if TreeNode.is_leaf(tree) do
      tree.symbol
    else
      left_tree_weight = calc_tree_weight(tree.left)
      right_tree_weight = calc_tree_weight(tree.right)

      case tree.symbol do
        "+" -> left_tree_weight + right_tree_weight
        "-" -> left_tree_weight - right_tree_weight
        "/" -> left_tree_weight / right_tree_weight
        "*" -> left_tree_weight * right_tree_weight
      end
    end
  end
end
