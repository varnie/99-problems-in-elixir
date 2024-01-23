defmodule Challenge33 do

  @doc """
  (*) Determine whether two positive integer numbers are coprime.
    Two numbers are coprime if their greatest common divisor equals 1.
  """
  def coprime(a, b) do
    Challenge32.gcd(a, b) == 1
  end
end
