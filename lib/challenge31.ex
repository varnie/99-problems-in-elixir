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

  def is_prime_one_more_impl(num) do
    cond do
      num in [1, 2, 3] ->
        true

      rem(num, 10) in [0, 2, 4, 6, 8] ->
        false

      rem(find_sum_of_digits(num), 3) == 0 ->
        false

      true ->
        to = Kernel.trunc(:math.sqrt(num))

        Enum.all?(2..to, fn elem ->
          rem(num, elem) > 0
        end)
    end
  end

  def find_sum_of_digits(num, result \\ 0) do
    if num >= 10 do
      find_sum_of_digits(div(num, 10), result + rem(num, 10))
    else
      result + num
    end
  end
end
