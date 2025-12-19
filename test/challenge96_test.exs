defmodule Challenge96Test do
  use ExUnit.Case

  test "identifier" do
    assert Challenge96.identifier("") == false
    assert Challenge96.identifier("ab_") == false
    assert Challenge96.identifier("a") == true
    assert Challenge96.identifier("ab") == true
    assert Challenge96.identifier("a6") == true
    assert Challenge96.identifier("a7b") == true
    assert Challenge96.identifier("abc") == true
    assert Challenge96.identifier("5") == false
    assert Challenge96.identifier("56") == false
    assert Challenge96.identifier("a_5") == true
    assert Challenge96.identifier("a_b") == true
    assert Challenge96.identifier("a_bc") == true
    assert Challenge96.identifier("a_bc") == true
    assert Challenge96.identifier("a_5") == true
    assert Challenge96.identifier("a_5_6") == true
    assert Challenge96.identifier("a_5_6_") == false
    assert Challenge96.identifier("this_is_a_long_identifier") == true
    assert Challenge96.identifier("This_ends_in_an_underscore_") == false
    assert Challenge96.identifier("1234") == false
    assert Challenge96.identifier("_legal_in_many_other_languages") == false
    assert Challenge96.identifier("This__has__two__consecutive__underscores") == false
    assert Challenge96.identifier("Fibonacci_sequence_is_12") == true
    assert Challenge96.identifier("Fibonacci_sequence_is_12_1_2_3_5_8_13_21_ad_infinitum") == true
  end
end
