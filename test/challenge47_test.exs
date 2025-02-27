defmodule Challenge47Test do
  use ExUnit.Case
  import Challenge47

  test "table" do
    assert Challenge47.table(fn a, b -> a &&& (a ||| not b) end) == [
             "true true true",
             "true false true",
             "false true false",
             "false false false"
           ]

    assert Challenge47.table(fn a, b -> a &&& (a ||| b) end) == [
             "true true true",
             "true false true",
             "false true false",
             "false false false"
           ]

    assert Challenge47.table(fn a, b -> a &&& not b end) == [
             "true true false",
             "true false true",
             "false true false",
             "false false false"
           ]

    assert Challenge47.table(fn a, b -> a +++ b end) == [
             "true true true",
             "true false false",
             "false true true",
             "false false true"
           ]

    assert Challenge47.table(fn a, b -> a &&& a <~> b end) == [
             "true true false",
             "true false true",
             "false true false",
             "false false false"
           ]

    result = Challenge47.table_n(fn a, b, c -> a &&& b &&& c end)

    result_expected = [
      "false false false false",
      "false false true false",
      "false true false false",
      "false true true false",
      "true false false false",
      "true false true false",
      "true true false false",
      "true true true true"
    ]

    assert Helpers.check_two_enumerables_equal?(result, result_expected)
  end
end
