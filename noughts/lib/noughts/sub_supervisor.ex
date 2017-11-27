defmodule Noughts.SubSupervisor do
  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([Noughts.Connector], strategy: :simple_one_for_one)
  end

  def new_game(game_info) do
    { :ok, pid } = Supervisor.start_child(__MODULE__, [game_info])
    pid
  end

  def terminate_child(pid) do
    Supervisor.terminate_child(__MODULE__, pid)
  end

end
