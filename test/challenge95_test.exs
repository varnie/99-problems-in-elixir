defmodule Challenge95Test do
  use ExUnit.Case

  test "solve" do
    assert Challenge95.full_words(0) == "zero"
    assert Challenge95.full_words(7) == "seven"
    assert Challenge95.full_words(42) == "four-two"
    assert Challenge95.full_words(175) == "one-seven-five"
    assert Challenge95.full_words(1001) == "one-zero-zero-one"
    assert Challenge95.full_words(9999) == "nine-nine-nine-nine"
  end
end