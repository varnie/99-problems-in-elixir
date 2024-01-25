defmodule Challenge40 do
  @doc """
  (**) Goldbach's conjecture.
    Goldbach's conjecture says that every positive even number greater than 2 is the sum of two prime numbers.
    Example: 28 = 5 + 23.
    It is one of the most famous facts in number theory that has not been proved to be correct in the general case.
    It has been numerically confirmed up to very large numbers.
    Write a predicate to find the two prime numbers that sum up to a given even integer.
  """
  def goldbach(num) when num > 2 and rem(num, 2) == 0 do
      first_satisfied_val = Enum.find(1..num-1, fn elem ->
      Challenge31.is_prime(elem) and Challenge31.is_prime(num - elem)
    end)

    {first_satisfied_val, num - first_satisfied_val}
  end

  def goldbach(_num) do
    nil
  end
end
