defmodule Challenge85 do
  @moduledoc """
    Graph isomorphism. (medium)
    Two graphs G1(N1,E1) and G2(N2,E2) are isomorphic if there is a bijection f: N1 → N2
    such that for any nodes X,Y of N1, X and Y are adjacent if and only if f(X) and f(Y) are adjacent.

    Write a function that determines whether two graphs are isomorphic.
    Hint: Use an open-ended list to represent the function f.

    Graph Expression Form:
    [
     ["b", "c", "d", "f", "g", "h", "k"],
     [["b", "c"], ["b", "f"], ["c", "f"], ["f", "k"], ["g", "h"]]
    ]

    Adjacency List Form:
    [
      ["b", ["c", "f"]],
      ["c", ["b", "f"]],
      ["d", []],
      ["f", ["b", "c", "k"]],
      ["g", ["h"]],
      ["h", ["g"]],
      ["k", ["f"]]
    ]
  """

  def are_isomorphic?(graph1, graph2) do
    # here graphs are of Graph Expression Form
    [nodes1, edges1] = graph1
    [nodes2, edges2] = graph2

    cond do
      length(nodes1) != length(nodes2) ->
        false

      length(edges1) != length(edges2) ->
        false

      nodes1
      |> Enum.map(&Challenge86.degree(graph1, &1))
      |> Enum.sort(fn a, b ->
        a >= b
      end) !=
          nodes2
          |> Enum.map(&Challenge86.degree(graph2, &1))
          |> Enum.sort(fn a, b ->
            a >= b
          end) ->
        false

      true ->
        bijection_exists?(graph1, graph2)
    end
  end

  defp normalize_edge([a, b]) do
    if a <= b, do: [a, b], else: [b, a]
  end

  defp edges_equal_under_mapping?(edges1, edges2, result_map) do
    mapped_edges1 =
      edges1
      |> Enum.map(fn [a, b] ->
        normalize_edge([result_map[a], result_map[b]])
      end)
      |> Enum.sort()

    normalized_edges2 =
      edges2
      |> Enum.map(&normalize_edge/1)
      |> Enum.sort()

    mapped_edges1 == normalized_edges2
  end

  defp condition_satisfied?(graph1, graph2, result_map) do
    [_nodes1, edges1] = graph1
    [_nodes2, edges2] = graph2

    map_keys = Map.keys(result_map)
    edges1_filtered = Enum.filter(edges1, fn [a, b] -> a in map_keys and b in map_keys end)

    Enum.all?(edges1_filtered, fn [a, b] ->
      map_a_val = result_map[a]
      map_b_val = result_map[b]

      !is_nil(map_a_val) and !is_nil(map_b_val) and
        ([map_a_val, map_b_val] in edges2 or [map_b_val, map_a_val] in edges2)
    end)
  end

  defp bijection_exists?(graph1, graph2) do
    [nodes1, edges1] = graph1
    [nodes2, edges2] = graph2

    result_map = iterate_thru_keys(graph1, graph2, nodes1, nodes2, [], %{})

    case result_map do
      false ->
        false

      _ ->
        map_size(result_map) == length(nodes1) and
          edges_equal_under_mapping?(edges1, edges2, result_map)
    end
  end

  defp find_suitable_value_for_key(
         _graph1,
         _graph2,
         _key_node,
         _available_val_nodes = [],
         _result_map
       ) do
    {nil, nil}
  end

  defp find_suitable_value_for_key(
         graph1,
         graph2,
         key_node,
         _available_val_nodes = [h_val_node | tail_nodes],
         result_map
       ) do
    new_result_map = Map.put(result_map, key_node, h_val_node)

    if condition_satisfied?(graph1, graph2, new_result_map) do
      {new_result_map, h_val_node}
    else
      find_suitable_value_for_key(graph1, graph2, key_node, tail_nodes, result_map)
    end
  end

  defp iterate_thru_keys(
         _graph1,
         _graph2,
         _key_nodes = [],
         _val_nodes,
         _exclude_val_nodes,
         result_map
       ) do
    result_map
  end

  defp iterate_thru_keys(
         graph1,
         graph2,
         key_nodes = [h_key | tail_keys],
         val_nodes,
         exclude_val_nodes,
         result_map
       ) do
    available_val_nodes = Enum.reject(val_nodes, &(&1 in exclude_val_nodes))

    {cur_result_map, cur_result_val} =
      find_suitable_value_for_key(graph1, graph2, h_key, available_val_nodes, result_map)

    case cur_result_map do
      nil ->
        false

      _ ->
        available_val_nodes = Enum.reject(val_nodes, &(&1 == cur_result_val))

        future_result_map =
          iterate_thru_keys(graph1, graph2, tail_keys, available_val_nodes, [], cur_result_map)

        case future_result_map do
          false ->
            # here we need to exclude `cur_result_val` from available_val_nodes for the next call of `find_suitable_value_for_key`
            new_exclude_val_nodes = [cur_result_val | exclude_val_nodes]

            iterate_thru_keys(
              graph1,
              graph2,
              key_nodes,
              val_nodes,
              new_exclude_val_nodes,
              result_map
            )

          _ ->
            future_result_map
        end
    end
  end
end
