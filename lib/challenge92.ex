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

  def solve(graph) do
    #    we accept the undirected graph in the Graph Expression Form:
    #    [
    #     ["b", "c", "d", "f", "g", "h", "k"],
    #     [["b", "c"], ["b", "f"], ["c", "f"], ["f", "k"], ["g", "h"]]
    #    ]
    #    The undirected graph is a tree.

    [nodes = [node | rest_nodes], edges] = graph

    # prepare mapping from nodes to their neighbours for convenience
    node_neighbours_map =
      Enum.reduce(nodes, %{}, fn x, acc ->
        neighbour_nodes =
          Enum.filter(edges, fn edge -> x in edge end)
          |> Enum.map(fn [a, b] -> if a == x, do: b, else: a end)

        # put in the map the node and its neighbours
        Map.put(acc, x, neighbour_nodes)
      end)

    node_candidate_number = 1

    state = %{
      nodes_numbered_map: %{node => node_candidate_number},
      edges_numbered_map: %{},
      node_neighbours_map: node_neighbours_map,
      tried_node_numbers_map: %{node => [node_candidate_number]},
      tried_edge_numbers_map: %{},
      k: length(nodes)
    }

    {_status, result} = find(state, rest_nodes)

    result
  end

  defp check_correctness(candidate_node_number, processed_node_number, candidate_edge_number) do
    abs(candidate_node_number - processed_node_number) == candidate_edge_number
  end

  defp calc_edge_name_for_nodes(n1, n2) do
    {a, b} = if n1 > n2, do: {n1, n2}, else: {n2, n1}
    a <> "_" <> b
  end

  defp find(state, nodes) do
    # there's at least 1 item in the nodes_numbered_map;
    # find some not processed node, for which there's an already processed neighbour node

    pair_of_nodes =
      Enum.find_value(nodes, nil, fn some_not_processed_node ->
        node_neighbours = Map.get(state.node_neighbours_map, some_not_processed_node, [])

        Enum.find_value(node_neighbours, fn some_neighbour_node ->
          if Map.get(state.nodes_numbered_map, some_neighbour_node, false),
            do: {some_not_processed_node, some_neighbour_node}
        end)
      end)

    if !pair_of_nodes do
      {true, {state.nodes_numbered_map, state.edges_numbered_map}}
    else
      {not_processed_node, processed_node} = pair_of_nodes

      processed_nodes_numbers = Map.values(state.nodes_numbered_map)
      already_tried_node_numbers = Map.get(state.tried_node_numbers_map, not_processed_node, [])

      free_node_numbers_to_check =
        Enum.to_list(1..state.k) --
          Enum.concat(processed_nodes_numbers, already_tried_node_numbers)

      edge_key = calc_edge_name_for_nodes(not_processed_node, processed_node)

      processed_edges_numbers = Map.values(state.edges_numbered_map)
      already_tried_edge_numbers = Map.get(state.tried_edge_numbers_map, edge_key, [])

      free_edge_numbers_to_check =
        Enum.to_list(1..(state.k - 1)) --
          Enum.concat(processed_edges_numbers, already_tried_edge_numbers)

      case try_node_numbers(
             state,
             not_processed_node,
             processed_node,
             free_node_numbers_to_check,
             free_edge_numbers_to_check,
             nodes
           ) do
        {true, data} -> {true, data}
        _ -> {false, nil}
      end
    end
  end

  defp try_node_numbers(
         state,
         not_processed_node,
         processed_node,
         free_node_numbers_to_check,
         free_edge_numbers_to_check,
         nodes
       ) do
    edge_key = calc_edge_name_for_nodes(not_processed_node, processed_node)
    new_nodes = nodes -- [not_processed_node]

    Enum.reduce_while(
      free_node_numbers_to_check,
      {state.nodes_numbered_map, state.tried_node_numbers_map},
      fn node_candidate_number, {nodes_numbered_map, tried_node_numbers_map} ->
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

        case try_edge_numbers(
               %{
                 state
                 | nodes_numbered_map: new_nodes_numbered_map,
                   tried_node_numbers_map: new_tried_node_numbers_map
               },
               free_edge_numbers_to_check,
               edge_key,
               node_candidate_number,
               Map.get(nodes_numbered_map, processed_node),
               new_nodes
             ) do
          {true, data} ->
            {:halt, {true, data}}

          _ ->
            {:cont, {nodes_numbered_map, tried_node_numbers_map}}
        end
      end
    )
  end

  defp try_edge_numbers(
         state,
         free_edge_numbers_to_check,
         edge_key,
         node_candidate_number,
         processed_node_number,
         nodes
       ) do
    Enum.reduce_while(
      free_edge_numbers_to_check,
      {state.edges_numbered_map, state.tried_edge_numbers_map},
      fn edge_candidate_number, {edges_numbered_map, tried_edge_numbers_map} ->
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

        # here should be some sanity check, right?
        case check_correctness(
               node_candidate_number,
               processed_node_number,
               edge_candidate_number
             ) and
               find(
                 %{
                   state
                   | edges_numbered_map: new_edges_numbered_map,
                     tried_edge_numbers_map: new_tried_edge_numbers_map
                 },
                 nodes
               ) do
          {true, data} ->
            {:halt, {true, data}}

          _ ->
            new_acc = {edges_numbered_map, new_tried_edge_numbers_map}
            {:cont, new_acc}
        end
      end
    )
  end
end
