defmodule Challenge49 do
  @doc """
  (**) Gray code.
    An n-bit Gray code is a sequence of n-bit strings constructed according to certain rules. For example,
    n = 1: C(1) = ['0','1'].
    n = 2: C(2) = ['00','01','11','10'].
    n = 3: C(3) = ['000','001','011','010',´110´,´111´,´101´,´100´].

    Find out the construction rules and write a predicate with the following specification:

    % gray(N,C) :- C is the N-bit Gray code

    Can you apply the method of "result caching" in order to make the predicate more efficient, when it is to be used repeatedly?
  """
  def gray(n) when n == 1 do
    [~c"0", ~c"1"]
  end

  def gray(n) when n == 2 do
    [~c"00", ~c"01", ~c"11", ~c"10"]
  end

  def gray(n) do
    Challenges.ThinWrapper.get_or_create(n, fn ->
      prev = gray(n - 1)
      prev_reversed = Enum.reverse(prev)

      Enum.concat(prefix(prev, ~c"0"), prefix(prev_reversed, ~c"1"))
    end)
  end

  defp prefix(coll, pref) do
    Enum.map(coll, fn item ->
      pref ++ item
    end)
  end
end
