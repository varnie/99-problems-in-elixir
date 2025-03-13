defmodule Challenge72Test do
  use ExUnit.Case

  test "mtree_ptl" do
    assert Challenge73.mtree_ptl(["a", ["f", "g"], "c", ["b", "d", "e"]]) == "t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])])"
    assert Challenge73.mtree_ptl(["a", "b"]) == "t(a,[t(b,[])])"
    assert Challenge73.mtree_ptl(["a", "b", "c"]) == "t(a,[t(b,[]),t(c,[])])"
    assert Challenge73.mtree_ptl("a") == "t(a,[])"
  end
end
