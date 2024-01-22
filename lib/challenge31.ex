defmodule Challenge31 do
  def is_prime(num) when num == 1, do: true

  def is_prime(num) do
    is_prime_helper(num, 2)
  end

  defp is_prime_helper(num, index) when index == num, do: true

  defp is_prime_helper(num, index) do
    rem(num, index) != 0 && is_prime_helper(num, index + 1)
  end

  def is_prime_another_impl(num) when num == 1, do: true

  def is_prime_another_impl(num) when num == 2, do: true

  def is_prime_another_impl(num) do
    Enum.all?(2..(num - 1), &(rem(num, &1) != 0))
  end
end
