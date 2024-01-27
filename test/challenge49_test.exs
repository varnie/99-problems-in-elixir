defmodule Challenge49Test do
  use ExUnit.Case

  test "gray" do
    assert Challenge49.gray(1) == [~c"0", ~c"1"]
    assert Challenge49.gray(2) == [~c"00", ~c"01", ~c"11", ~c"10"]

    assert Challenge49.gray(3) == [
             ~c"000",
             ~c"001",
             ~c"011",
             ~c"010",
             ~c"110",
             ~c"111",
             ~c"101",
             ~c"100"
           ]

    assert Challenge49.gray(4) == [
             ~c"0000",
             ~c"0001",
             ~c"0011",
             ~c"0010",
             ~c"0110",
             ~c"0111",
             ~c"0101",
             ~c"0100",
             ~c"1100",
             ~c"1101",
             ~c"1111",
             ~c"1110",
             ~c"1010",
             ~c"1011",
             ~c"1001",
             ~c"1000"
           ]
  end
end
