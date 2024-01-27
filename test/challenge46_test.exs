defmodule Challenge46Test do
  use ExUnit.Case

  test "table" do
    assert Challenge46.table(false, true, &Challenge46.tbl_and(&1, Challenge46.tbl_or(&1, !&2))) ==
             "false true false"

    assert Challenge46.table(true, true, &Challenge46.tbl_and(&1, &2)) == "true true true"
    assert Challenge46.table(true, true, &Challenge46.tbl_and/2) == "true true true"

    assert Challenge46.table(false, true, &Challenge46.tbl_and(Challenge46.tbl_or(&1, &2), &1)) ==
             "false true false"

    assert Challenge46.table(true, false, &Challenge46.tbl_and(Challenge46.tbl_or(&1, &2), &1)) ==
             "true false true"

    assert Challenge46.table(true, false, fn a, b ->
             Challenge46.tbl_and(Challenge46.tbl_or(a, b), a)
           end) == "true false true"
  end
end
