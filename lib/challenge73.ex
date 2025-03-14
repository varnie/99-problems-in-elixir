defmodule Challenge73 do
  @moduledoc """
     (**) Prolog-like tree representation
    There is a particular notation for multiway trees in Prolog. Prolog is a prominent functional programming language,
    which is used primarily for artificial intelligence problems. As such, it is one of the main competitors of Lisp.
    In Prolog everything is a term, just as in Lisp everything is a symbolic expression.

    In Prolog we represent a multiway tree by a term t(X,F), where X denotes the root node and F denotes the forest
    of successor trees (a Prolog list). The example tree depicted opposite is represented by the following
    Lisp expression:

    t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])])

    The Prolog representation of a multiway tree is a sequence of atoms, commas, parentheses "(" and ")",
    and brackets "[" and "]".which we shall collectively call "tokens". We can represent this sequence of tokens
    as a Lisp list; e.g. the Prolog expression t(a,[t(b,[]),t(c,[])]) could be represented as the Lisp list
    ( t "(" a "," "[" t "(" b "," "[" "]" ")" "," t "(" c "," "[" "]" ")" "]" ")" ).
    Write a function (tree-ptl expr) which returns the "Prolog token list" if the tree is given as an expression expr
    in the usual Lisp notation.

    Example:
    * (tree-ptl '(a b c))
    ( T "(" A "," "[" T "(" B "," "[" "]" ")" "," T "(" C "," "[" "]" ")" "]" ")" )

    As a second, even more interesting exercise try to write the inverse conversion:
    Given the list PTL, construct the corresponding Lisp tree.
  """

  def mtree_ptl([h | tail]) do
    children = Enum.map(tail, &mtree_ptl(&1)) |> Enum.join(",")
    "t(#{h},[#{children}])"
  end

  def mtree_ptl(elem), do: "t(#{elem},[])"

  def ptl_mtree(string_repr) do
    {result, unprocessed_symbols} =
      string_repr
      |> String.codepoints()
      |> ptl_mtree_impl()

    if !Enum.empty?(unprocessed_symbols), do: raise("Invalid structure"), else: result
  end

  defp ptl_mtree_impl(coll) do
    {_, coll} = read_and_continue(coll, "t")
    {_, coll} = read_and_continue(coll, "(")

    {node_name, coll} =
      read_and_continue(coll, &String.match?(&1, ~r/^[a-zA-Z]$/i))

    {_, coll} = read_and_continue(coll, ",")
    {_, coll} = read_and_continue(coll, "[")

    {result, coll} =
      if !Helpers.check_sanity(coll, "]") do
        {children, coll} = read_list_of_children(coll)
        children = Enum.reverse(children)
        IO.inspect(node_name, label: "node_name")
        IO.inspect(children, label: "list_of_children")
        {[node_name | children], coll}
      else
        {node_name, coll}
      end

    IO.inspect(result, label: "result")
    IO.inspect("--")

    {_, coll} = read_and_continue(coll, "]")
    {_, coll} = read_and_continue(coll, ")")

    {result, coll}
  end

  defp read_list_of_children(coll, result \\ []) do
    {child, coll} = ptl_mtree_impl(coll)
    result = [child | result]

    if Helpers.check_sanity(coll, ",") do
      {_, coll} = read_and_continue(coll, ",")
      {list_of_children, coll} = read_list_of_children(coll, result)
      {list_of_children, coll}
    else
      {result, coll}
    end
  end

  defp read_and_continue(src_list, letter_or_func) do
    cond_fn =
      if Kernel.is_function(letter_or_func), do: letter_or_func, else: &(&1 == letter_or_func)

    read = Helpers.read_while_cond(cond_fn, src_list) |> Enum.reverse() |> Enum.join("")
    len = String.length(read)
    if len == 0, do: raise("Invalid syntax"), else: {read, Enum.drop(src_list, len)}
  end
end
