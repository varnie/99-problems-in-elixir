defmodule Challenge90AnotherTest do
  use ExUnit.Case

  test "solve" do
    assert Challenge90Another.solve() |> length() == 92
  end
end
