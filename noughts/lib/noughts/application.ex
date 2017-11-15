defmodule Noughts.Application do
  use Application

  def start(_type, _args) do
    children = [
      Noughts.Stash,
      Noughts.Controller,
      Noughts.SubSupervisor
    ]
    
    opts = [strategy: :one_for_one, name: Noughts.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
