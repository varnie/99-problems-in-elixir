defmodule Challenge84 do
  @moduledoc """
  P84 (**) Construct a minimum spanning tree
    Write a function (ms-tree graph) to construct a minimum spanning tree of a given labelled graph.
    The function must also return the minimum weight. Hint: Use the algorithm of Prim.
    A small modification of the solution of P83 does the trick.
    The data of the example graph to the right can be found in the file p84.dat.

  Labelled Graph Expression Form:
  [
   ["b", "c", "f", "k"],
   [["b", "c", 4], ["b", "f", 5], ["c", "f", 1], ["f", "k", 2]]
  ]
  """

  def ms_tree(graph) do
    # here graph is of Labelled Graph Expression Form
    [nodes, _edges] = graph
    [h_node | _rest_nodes] = nodes

    [vs, es] = ms_tree_impl(graph, [h_node], [])

    if length(vs) != length(nodes) do
      raise "Graph is disconnected"
    else
      [vs, es]
    end
  end

  def ms_tree_weight(graph) do
    # here graph is of Labelled Graph Expression Form
    [_vs, es] = ms_tree(graph)
    Enum.map(es, fn [_a, _b, val] -> val end) |> Enum.sum()
  end

  defp ms_tree_impl(graph, mst_vertices, mst_edges) do
    # here graph is of Labelled Graph Expression Form
    [_nodes, edges] = graph

    # Find edges connecting any tree vertex with the fringe vertices
    relevant_edges =
      Enum.filter(edges, fn candidate_edge ->
        [a, b, _val] = candidate_edge

        (a in mst_vertices and !(b in mst_vertices)) or
          (b in mst_vertices and !(a in mst_vertices))
      end)

    case relevant_edges do
      [] ->
        [Enum.reverse(mst_vertices), Enum.reverse(mst_edges)]

      _ ->
        new_mst_edge = Enum.min_by(relevant_edges, fn [_a, _b, val] -> val end)
        [a, b, _val] = new_mst_edge

        new_mst_edges = [new_mst_edge | mst_edges]

        new_mst_vertex = if a in mst_vertices, do: b, else: a

        new_mst_vertices = [new_mst_vertex | mst_vertices]

        ms_tree_impl(graph, new_mst_vertices, new_mst_edges)
    end
  end
end
