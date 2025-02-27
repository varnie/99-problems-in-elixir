defmodule Challenge47 do
  @moduledoc """
    (*) Truth tables for logical expressions (2).
        Modify problem P46 by accepting expressions written in infix notation, with all parenthesis present.
        This allows us to write logical expression in a more natural way, as in the example: (A and (A or (not B))).

        Example:
        * (table 'A 'B '(A and (A or (not B)))).
        true true true
        true nil true
        nil true nil
        nil nil nil
  """

  # or
  def a ||| b, do: a || b
  # and
  def a &&& b, do: a && b
  # impl
  def a +++ b, do: Challenge46.tbl_impl(a, b)
  # xor
  def a <~> b, do: Challenge46.tbl_xor(a, b)

  def table(input_fn) do
    for a <- [true, false],
        b <- [true, false],
        do: "#{a} #{b} #{input_fn.(a, b)}"
  end

  # TODO:
  def table_n(input_fn) do
    info = Function.info(input_fn)
    input_fn_arity = Keyword.get(info, :arity)

    if input_fn_arity == 0 do
      raise("Arity must not be zero")
    else
      args_list = build(Enum.to_list(1..input_fn_arity))

      for args <- args_list do
        args_joined = Enum.join(args, " ")
        func_result = "#{Kernel.apply(input_fn, args)}"
        args_joined <> " " <> func_result
      end
    end
  end

  def build([_h]), do: [[true], [false]]

  def build([_h | tail]) do
    result = Enum.map(build(tail), fn t -> [[false | t], [true | t]] end)
    Enum.concat(result)
  end
end
