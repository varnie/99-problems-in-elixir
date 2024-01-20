defmodule Challenge1 do
  use Application

  @spec start(any(), any()) :: {:ok, pid()}
  def start(_type, _args) do
    Challenge1.p01_my_last([1, 2, 3])
    {:ok, self()}
  end

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
