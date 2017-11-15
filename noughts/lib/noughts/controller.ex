defmodule Noughts.Controller do
  alias Noughts.SubSupervisor, as: SubSupervisor
  alias Noughts.Connector,     as: Connector
  
  def child_spec(_arg) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [[%{ clients: %{}, games: %{} }]]},
      restart: :permanent
    }
  end

  def start_link(default \\[]) do
    pid = spawn_link(__MODULE__, :message_loop, default)
    Process.register(pid, __MODULE__)
    { :ok, pid }
  end

  def message_loop(state) do
    state = receive do
      { from, name, node, :new_game } ->
	Process.monitor(from)
	pid = SubSupervisor.new_game()
	IO.puts "new game #{inspect pid} starts"
	state
    end
    message_loop(state)
  end

end
