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

  # defp parse_logical_expr(logical_expr_str, var_names) do
  #   {parsed_expr, processed_symbols_count} =
  #     logical_expr_str |> String.codepoints() |> parse_logical_expr_impl(var_names)

  #   if processed_symbols_count != String.length(logical_expr_str) do
  #     raise("Invalid format!")
  #   else
  #     parsed_expr
  #     # fn a, b -> parsed_expr.(a, b) end
  #   end

  #   # TODO:
  # end

  # defp parse_logical_expr_impl(src_list, var_names) do
  #   IO.puts(src_list)
  #   IO.puts(var_names)

  #   cond do
  #     Helpers.check_sanity(src_list, "(") ->
  #       cnt = 1
  #       src_list = Enum.drop(src_list, 1)

  #       # parse varname or funcname
  #       term_name = parse_term(src_list)
  #       len_name = String.length(term_name)

  #       if len_name > 0 do
  #         var_name_found = term_name in var_names
  #         func_name_found = term_name in ["or", "and"]

  #         if not (var_name_found or func_name_found) do
  #           raise("Unknown var name detected!")
  #         else
  #           cnt = cnt + len_name
  #           src_list = Enum.drop(src_list, len_name)

  #         end
  #       else
  #         raise("Expected var name of func name!")
  #       end

  #       if Helpers.check_sanity(src_list, ")") do
  #         cnt = cnt + 1
  #         src_list = Enum.drop(src_list, 1)
  #         {result_expr, cnt}
  #       else
  #         raise("Expected )")
  #       end

  #     true ->
  #       raise("Unimplemented")
  #   end

  #   # term_name = parse_term(src_list)
  #   # len_name = String.length(term_name)

  #   # cond do
  #   #   len_name > 0 ->
  #   #     var_name = Enum.find(var_names, &(&1 == term_name))

  #   #     if var_name do
  #   #       # term_fn = fn a, _b ->
  #   #       #   t = Code.eval_string(a)
  #   #       #   Kernel.elem(t, 0)
  #   #       # end

  #   #       cnt = len_name
  #   #       src_list = Enum.drop(src_list, len_name)
  #   #       {var_name, cnt}
  #   #     else
  #   #       if var_name in ["and", "or"] do
  #   #         cnt = len_name
  #   #         src_list = Enum.drop(src_list, len_name)

  #   #         if !Helpers.check_sanity(src_list, "(") do
  #   #           raise("Expected )")
  #   #         else
  #   #           #blabla
  #   #           if !Helpers.check_sanity(src_list, ")") do
  #   #             raise("Expected )")
  #   #           else
  #   #             #blabla return final func impl
  #   #           end
  #   #         end

  #   #       else
  #   #         raise("Specified var_name not found")
  #   #       end
  #   #     end

  #   #   true ->
  #   #     raise("Unimplemented!")
  #   # end

  #   # TODO:
  # end

  # defp parse_term(src_list) do
  #   Helpers.read_while_cond(
  #     fn letter -> String.match?(letter, ~r/^[a-zA-Z0-9]$/i) end,
  #     src_list
  #   )
  #   |> Enum.reverse()
  #   |> Enum.join("")
  # end
end
