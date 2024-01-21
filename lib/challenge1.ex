defmodule Challenge1 do
  @doc """
    (*) Find the last element of a list.
    Example:
    ?- my_last(X,[a,b,c,d]).
    X = d
  """
  def p01_my_last(lst) do
    List.last(lst)
  end

  @doc """
    (*) Find the last element of a list.
    Example:
    ?- my_last(X,[a,b,c,d]).
    X = d
  """
  def p01_my_last_02([head]) do
    head
  end

  def p01_my_last_02([_head | tail]) do
    p01_my_last_02(tail)
  end

  def p01_my_last_02(_) do
    nil
  end
end
