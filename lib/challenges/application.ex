defmodule Challenges.Application do
  use Application

  def start(_type, _args) do
    children = [
      # Add ThinWrapper to the supervision tree
      {Challenges.ThinWrapper, []}
    ]

    opts = [strategy: :one_for_one, name: Challenges.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
