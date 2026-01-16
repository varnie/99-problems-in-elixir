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

  g1 = [["a", "b", "c", "d", "e", "f", "g", "h", "i", "k", "m", "n", "p", "q"], [["a", "b"], ["a", "c"], ["a", "h"], ["a", "i"], ["a", "g"], ["d", "c"], ["d", "k"], ["e", "q"], ["e", "c"], ["f", "c"], ["q", "m"], ["q", "n"], ["p", "n"]]]

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

    find(%{}, %{}, node_neighbours_map, %{}, %{}, nodes, length(nodes))
  end

  # TODO: all below
  #  defp find_suitable_val(_node2neighbours_map, cur_map, node, []) do
  #    IO.inspect(node, label: "not found")
  #    {false, cur_map, []}
  #  end
  #
  #  defp find_suitable_val(
  #         node2neighbours_map,
  #         cur_map,
  #         node,
  #         _available_vals = [h_val | rest_vals]
  #       ) do
  #    candidate_val = h_val
  #  end
  #

  # TODO: fixme?
  defp check_correctness(
         nodes_numbered_map,
         edges_numbered_map,
         node_neighbours_map
       ) do
    result = Enum.all?(nodes_numbered_map, fn {node, node_number} ->
      neighbours = Map.get(node_neighbours_map, node, [])

      Enum.all?(neighbours, fn neighbour_node ->
        cond do
          !Map.has_key?(nodes_numbered_map, neighbour_node) ->
            true

          true ->
            neighbour_number = Map.get(nodes_numbered_map, neighbour_node)
            edge_name = calc_edge_name_for_nodes(node, neighbour_node)

            case Map.get(edges_numbered_map, edge_name) do
              nil -> false
              edge_number -> abs(node_number - neighbour_number) == edge_number
            end
        end
      end)
    end)

    #IO.inspect(result, label: "check_correctness result")
    result
  end

  #
  #  defp find_free_number_for_edge(edge_name, tried_edges_numbers_map, count) do
  #    tried_numbers = Map.get(tried_edges_numbers_map, edge_name, [])
  #
  #    candidate =
  #      Enum.find(1..(count - 1), false, fn index ->
  #        !(index in tried_numbers)
  #      end)
  #
  #    candidate
  #  end
  #
  #  defp find_free_number_for_node(node, tried_nodes_numbers_map, count) do
  #    tried_numbers = Map.get(tried_nodes_numbers_map, node, [])
  #
  #    candidate =
  #      Enum.find(1..count, false, fn index ->
  #        !(index in tried_numbers)
  #      end)
  #
  #    candidate
  #  end

  defp calc_edge_name_for_nodes(n1, n2) do
    Enum.sort([n1, n2]) |> Enum.join("_")
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
    # IO.inspect(nodes_numbered_map, label: "in find")

    cond do
      map_size(nodes_numbered_map) == 0 ->
        #IO.inspect(nodes, label: "nodes")
        node = hd(nodes)
        rest_nodes = tl(nodes)

        result =
          Enum.reduce_while(1..k, {nodes_numbered_map, tried_node_numbers_map}, fn x, acc ->
            node_candidate_number = x
            {nodes_numbered_map, tried_node_numbers_map} = acc

            new_tried_node_numbers_map =
              Map.update(
                tried_node_numbers_map,
                node,
                [node_candidate_number],
                fn existing_candidates ->
                  [node_candidate_number | existing_candidates]
                end
              )

            new_nodes_numbered_map =
              Map.put(
                nodes_numbered_map,
                node,
                node_candidate_number
              )

            case find(
                   new_nodes_numbered_map,
                   edges_numbered_map,
                   node_neighbours_map,
                   new_tried_node_numbers_map,
                   tried_edge_numbers_map,
                   rest_nodes,
                   k
                 ) do
              {true, data} ->
                {:halt, {true, data}}

              _ ->
                new_acc = {nodes_numbered_map, new_tried_node_numbers_map}
                {:cont, new_acc}
            end
          end)

        result

      true ->
        # there's at least 1 item in the nodes_numbered_map;
        # find some not processed node, for which there's an already processed neighbour-node
        processed_nodes = Map.keys(nodes_numbered_map)

        not_processed_node =
          Enum.find(nodes, false, fn not_processed_node ->
            case Map.get(node_neighbours_map, not_processed_node) do
              nil ->
                false

              neighbours_list ->
                Enum.any?(neighbours_list, fn neighbour_node ->
                  neighbour_node in processed_nodes
                end)
            end
          end)

        # TODO:
        if !not_processed_node do
          {true, {nodes_numbered_map, edges_numbered_map}}
        else
          processed_nodes_numbers = Map.values(nodes_numbered_map)
          already_tried_node_numbers = Map.get(tried_node_numbers_map, not_processed_node, [])

          free_node_numbers_to_check = Enum.to_list(1..k) -- Enum.concat(processed_nodes_numbers, already_tried_node_numbers)

          result =
            Enum.reduce_while(
              free_node_numbers_to_check,
              {nodes_numbered_map, tried_node_numbers_map, edges_numbered_map, tried_edge_numbers_map},
              fn x, acc ->
                node_candidate_number = x

                {nodes_numbered_map, tried_node_numbers_map, edges_numbered_map, tried_edge_numbers_map} = acc

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

                # find some processed node
                processed_nodes = Map.keys(nodes_numbered_map)

                processed_node =
                  Enum.find(processed_nodes, fn some_processed_node ->
                    not_processed_node in Map.get(node_neighbours_map, some_processed_node, [])
                  end)

                edge_key = calc_edge_name_for_nodes(not_processed_node, processed_node)
                processed_edges_numbers = Map.values(edges_numbered_map)
                already_tried_edge_numbers = Map.get(tried_edge_numbers_map, edge_key, [])

                free_edge_numbers_to_check =
                  Enum.to_list(1..(k - 1)) --
                    Enum.concat(processed_edges_numbers, already_tried_edge_numbers)

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

                      #IO.puts("BEFORE")
                      # here should be some sanity check right?
                      if check_correctness(
                         new_nodes_numbered_map,
                         new_edges_numbered_map,
                         node_neighbours_map
                      ) do
                      ###
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

                        #IO.inspect(inner_result, label: "inner_result")

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

                #IO.inspect(next_result, label: "next_result")

                case next_result do
                  {true, _data} -> {:halt, next_result}
                  _ -> {:cont, {nodes_numbered_map, tried_node_numbers_map, edges_numbered_map, tried_edge_numbers_map}}
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

  ####
  #  defp iterate(
  #         data = %{
  #           nodes_numbered_map: nodes_numbered_map,
  #           edges_numbered_map: edges_numbered_map,
  #           node_neighbours_map: node_neighbours_map,
  #           tried_node_numbers_map: tried_node_numbers_map,
  #           tried_edges_numbers_map: tried_edges_numbers_map
  #         },
  #         nodes,
  #         k
  #       ) do
  #    # find some not processed node and one of its processed neighbours, if possible
  #    {unprocessed_node, processed_neighbour_node} =
  #      case nodes_numbered_map do
  #        %{} ->
  #          {hd(nodes), nil}
  #
  #        _ ->
  #          some_node =
  #            Enum.find(nodes, false, fn n ->
  #              cond do
  #                Map.has_key?(nodes_numbered_map, n) ->
  #                  false
  #
  #                  Enum.any?(Map.keys(nodes_numbered_map), fn some_processed_node ->
  #                    case Map.get(node_neighbours_map, some_processed_node) do
  #                      nil -> false
  #                      neighbours_list -> n in neighbours_list
  #                    end
  #                  end)
  #              end
  #            end)
  #
  #          processed_neighbour =
  #            if some_node do
  #              Enum.find(Map.keys(nodes_numbered_map), false, fn some_present_node ->
  #                case Map.get(node_neighbours_map, some_present_node) do
  #                  nil -> false
  #                  neighbours_list -> some_node in neighbours_list
  #                end
  #              end)
  #            else
  #              nil
  #            end
  #
  #          {some_node, processed_neighbour}
  #      end
  #
  #    if !unprocessed_node do
  #      # nothing else is left, return result
  #      data
  #    else
  #      # try some available "free" number for node
  #      node_candidate_number =
  #        find_free_number_for_node(unprocessed_node, tried_node_numbers_map, k)
  #
  #      if !node_candidate_number do
  #        # current configuration is "false"
  #      else
  #        #
  #      end
  #
  #      # update tried values list for this node
  #      tried_node_numbers_map =
  #        Map.update(
  #          tried_node_numbers_map,
  #          node,
  #          [node_candidate_number],
  #          fn existing_candidates ->
  #            [node_candidate_number | existing_candidates]
  #          end
  #        )
  #
  #      if processed_neighbour_node do
  #        edge_name = calc_edge_name_for_nodes(unprocessed_node, processed_neighbour_node)
  #        # try some edge number
  #        edge_candidate_number = find_free_number_for_edge(edge_name, tried_edges_numbers_map, k)
  #
  #        new_nodes_numbered_map =
  #          Map.put(nodes_numbered_map, unprocessed_node, node_candidate_number)
  #
  #        new_edges_numbered_map = Map.put(edges_numbered_map, edge_name, edge_candidate_number)
  #
  #        tried_edges_numbers_map =
  #          Map.update(
  #            tried_edges_numbers_map,
  #            edge_name,
  #            [edge_candidate_number],
  #            fn existing_candidates ->
  #              [edge_candidate_number | existing_candidates]
  #            end
  #          )
  #
  #        if check_correctness(
  #             new_nodes_numbered_map,
  #             new_edges_numbered_map,
  #             node_neighbours_map
  #           ) do
  #          # TODO:
  #        else
  #          #
  #        end
  #      end
  #    end
  #
  #    #    result = find_suitable_val(node2neighbours_map, cur_map, h_node, available_vals)
  #    #    IO.inspect(h_node, label: "h_node")
  #    #    IO.inspect(available_vals, label: "available_vals")
  #    #    IO.inspect(result, label: "result")
  #    #    IO.puts("")
  #    #    {found, new_map, new_available_vals} = result
  #    #
  #    #    if found do
  #    #      IO.inspect(new_available_vals, label: "new_available_vals")
  #    #      next_result = iterate(node2neighbours_map, new_map, tail_nodes, new_available_vals)
  #    #      IO.inspect(next_result, label: "next_result")
  #    #      {next_result_found, _next_result_new_map, _next_result_new_available_vals} = next_result
  #    #
  #    #      if !next_result_found do
  #    #        new_available_vals = new_available_vals ++ [Map.get(new_map, h_node)]
  #    #        IO.inspect(new_available_vals, label: "try another val")
  #    #        iterate(node2neighbours_map, cur_map, nodes, new_available_vals)
  #    #      else
  #    #        next_result
  #    #      end
  #    #    else
  #    #      result
  #    #    end
  #  end
end
