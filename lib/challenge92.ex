defmodule Challenge92 do
  @moduledoc """
      (***) Von Koch's conjecture
    Several years ago I met a mathematician who was intrigued by a problem for which he didn't know a solution.
    His name was Von Koch, and I don't know whether the problem has been solved since.

    Anyway the puzzle goes like this: given a tree with N nodes (and hence N-1 edges), find a way to enumerate the nodes
    from 1 to N and, accordingly, the edges from 1 to N-1 in such a way that, for each edge K, the difference of its
    node numbers equals K. The conjecture is that this is always possible.

    For small trees the problem is easy to solve by hand. However, for larger trees, and 14 is already very large, it is
    extremely difficult to find a solution. And remember, we don't know for sure whether there is always a solution!

    Write a function that calculates a numbering scheme for a given tree. What is the solution for the larger tree pictured above?
  """

  #
  g = [
    ["a", "b", "c", "d", "e", "f", "g"],
    [["a", "d"], ["a", "g"], ["a", "b"], ["e", "b"], ["e", "f"], ["b", "c"]]
  ]

  g1 = [
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "k", "m", "n", "p", "q"],
    [
      ["a", "b"],
      ["a", "c"],
      ["a", "h"],
      ["a", "i"],
      ["a", "g"],
      ["d", "c"],
      ["d", "k"],
      ["e", "q"],
      ["e", "c"],
      ["f", "c"],
      ["q", "m"],
      ["q", "n"],
      ["p", "n"]
    ]
  ]

  def solve(graph) do
    #    we accept the undirected graph in the Graph Expression Form:
    #    [
    #     ["b", "c", "d", "f", "g", "h", "k"],
    #     [["b", "c"], ["b", "f"], ["c", "f"], ["f", "k"], ["g", "h"]]
    #    ]
    #    The undirected graph is a tree.

    [nodes, edges] = graph

    # prepare mapping from nodes to their neighbours for convenience
    node_neighbours_map =
      Enum.reduce(nodes, %{}, fn x, acc ->
        neighbour_nodes =
          Enum.filter(edges, fn edge -> x in edge end)
          |> Enum.map(fn [a, b] -> if a == x, do: b, else: a end)

        # put in the map the node and its neighbours
        Map.put(acc, x, neighbour_nodes)
      end)

    [node | rest_nodes] = nodes
    node_candidate_number = 1

    case find(
      %{node => node_candidate_number},
      %{},
      node_neighbours_map,
      %{node => [node_candidate_number]},
      %{},
      rest_nodes,
      length(nodes)
    ) do
      {true, result} -> result
      _ -> nil
    end
  end

  defp check_correctness(
         nodes_numbered_map,
         edges_numbered_map,
         node_neighbours_map
       ) do
    Enum.all?(nodes_numbered_map, fn {node, node_number} ->
      neighbours = Map.get(node_neighbours_map, node, [])

      Enum.all?(neighbours, fn neighbour_node ->
        case Map.get(nodes_numbered_map, neighbour_node) do
          nil ->
            true

          neighbour_number ->
            edge_name = calc_edge_name_for_nodes(node, neighbour_node)

            case Map.get(edges_numbered_map, edge_name) do
              nil -> false
              edge_number -> abs(node_number - neighbour_number) == edge_number
            end
        end
      end)
    end)
  end

  defp calc_edge_name_for_nodes(n1, n2) do
    {a, b} = if n1 > n2, do: {n1, n2}, else: {n2, n1}
    a <> "_" <> b
  end

  defp find(
         nodes_numbered_map,
         edges_numbered_map,
         node_neighbours_map,
         tried_node_numbers_map,
         tried_edge_numbers_map,
         nodes,
         k
       ) do
    # there's at least 1 item in the nodes_numbered_map;
    # find some not processed node, for which there's an already processed neighbour node

    {not_processed_node, processed_node} =
      Enum.find_value(nodes, {nil, nil}, fn some_not_processed_node ->
        node_neighbours = Map.get(node_neighbours_map, some_not_processed_node, [])

        Enum.find_value(node_neighbours, fn some_neighbour_node ->
          if Map.get(nodes_numbered_map, some_neighbour_node, false),
            do: {some_not_processed_node, some_neighbour_node}
        end)
      end)

    if !not_processed_node do
      {true, {nodes_numbered_map, edges_numbered_map}}
    else
      processed_nodes_numbers = Map.values(nodes_numbered_map)
      already_tried_node_numbers = Map.get(tried_node_numbers_map, not_processed_node, [])

      free_node_numbers_to_check =
        Enum.to_list(1..k) -- Enum.concat(processed_nodes_numbers, already_tried_node_numbers)

      edge_key = calc_edge_name_for_nodes(not_processed_node, processed_node)

      processed_edges_numbers = Map.values(edges_numbered_map)
      already_tried_edge_numbers = Map.get(tried_edge_numbers_map, edge_key, [])

      free_edge_numbers_to_check =
        Enum.to_list(1..(k - 1)) --
          Enum.concat(processed_edges_numbers, already_tried_edge_numbers)

      result =
        Enum.reduce_while(
          free_node_numbers_to_check,
          {nodes_numbered_map, tried_node_numbers_map},
          fn x, acc ->
            node_candidate_number = x
            {nodes_numbered_map, tried_node_numbers_map} = acc

            new_tried_node_numbers_map =
              Map.update(
                tried_node_numbers_map,
                not_processed_node,
                [node_candidate_number],
                fn existing_candidates ->
                  [node_candidate_number | existing_candidates]
                end
              )

            new_nodes_numbered_map =
              Map.put(
                nodes_numbered_map,
                not_processed_node,
                node_candidate_number
              )

            next_result =
              Enum.reduce_while(
                free_edge_numbers_to_check,
                {edges_numbered_map, tried_edge_numbers_map},
                fn x, acc ->
                  edge_candidate_number = x
                  {edges_numbered_map, tried_edge_numbers_map} = acc

                  new_tried_edge_numbers_map =
                    Map.update(
                      tried_edge_numbers_map,
                      edge_key,
                      [edge_candidate_number],
                      fn existing_candidates ->
                        [edge_candidate_number | existing_candidates]
                      end
                    )

                  new_edges_numbered_map =
                    Map.put(
                      edges_numbered_map,
                      edge_key,
                      edge_candidate_number
                    )

                  # here should be some sanity check right?
                  if check_correctness(
                       new_nodes_numbered_map,
                       new_edges_numbered_map,
                       node_neighbours_map
                     ) do

                    inner_result =
                      find(
                        new_nodes_numbered_map,
                        new_edges_numbered_map,
                        node_neighbours_map,
                        new_tried_node_numbers_map,
                        new_tried_edge_numbers_map,
                        nodes -- [not_processed_node],
                        k
                      )

                    case inner_result do
                      {true, _data} ->
                        {:halt, inner_result}

                      _ ->
                        new_acc = {edges_numbered_map, new_tried_edge_numbers_map}
                        {:cont, new_acc}
                    end
                  else
                    new_acc = {edges_numbered_map, new_tried_edge_numbers_map}
                    {:cont, new_acc}
                  end
                end
              )

            case next_result do
              {true, _data} ->
                {:halt, next_result}

              _ ->
                {:cont, {nodes_numbered_map, tried_node_numbers_map}}
            end
          end
        )

      case result do
        {true, _data} -> result
        _ -> {false, nil}
      end
    end
  end
end
