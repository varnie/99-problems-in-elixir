defmodule Helpers do
  def check_two_cols_equal?(c1, c2) do
    if length(c1) == length(c2) do
      false
    end

    Enum.all?(c1, fn elem ->
      elem in c2
    end)
  end
end
