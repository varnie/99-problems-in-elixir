defmodule Challenge27Test do
  use ExUnit.Case

  test "group3" do
    assert length(Challenge27.group3([:a, :b, :c, :d, :e, :f, :g, :h, :i])) == 1260
  end
end
