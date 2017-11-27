defmodule Noughts.Controller do
  alias Noughts.SubSupervisor, as: SubSupervisor
  alias Noughts.Connector,     as: Connector
  
  def child_spec(_arg) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [[%{ pid_reg: %{}, clients: %{}, games: %{}, waiting: [], counter: 0 }]]},
      restart: :permanent
    }
  end

  def start_link(default \\[]) do
    pid = spawn_link(__MODULE__, :message_loop, default)
    Process.register(pid, __MODULE__)
    IO.puts "Server running"
    { :ok, pid }
  end

  def message_loop(state) do
    state = receive do
      { from, name, node, :new_game } ->
	Process.monitor(from)
	put_in state, [:pid_reg, from], {name, node}
	find_match(state, state.waiting, {name, node})
	
      { name, node, chessboard, :make_move} ->
	make_move(state, Noughts.Chess.won(chessboard), {name, node}, chessboard)
	
      { :DOWN, _ref, :process, pid, _reason } ->
	IO.puts "Client #{inspect pid} exited!"
	SubSupervisor.terminate_child(state.games[state.pid_reg[pid]])
	disconnect(state, pid)
	
    end
    message_loop(state)
  end

  def find_match(state, [], player) do
    send player, {:matching}
    IO.puts "A new player is waiting in queue!"
    put_in(state[:waiting], player)
    IO.puts "#{inspect state.waiting}"
    |> put_in([:clients, player], {})
  end

  def find_match(state, [player_one], player_two) do
    pid = SubSupervisor.new_game([state.counter + 1, player_one, player_two])
    chessboard = Connector.get_positions(pid)
    send player_one, {:game_start, chessboard, :true}
    send player_two, {:game_start, chessboard, :false}
    IO.puts "New game #{inspect pid} starts!"
    put_in(state, [:clients, player_one], player_two)
    |> put_in([:clients, player_two], player_one)
    |> put_in([:games, player_one], pid)
    |> put_in([:games, player_two], pid)
    |> put_in([:waiting], [])
  end

  def make_move(state, :true, player, _chessboard) do
    send player, {:won}
    player_an = state.clients[player]
    send player_an, {:lost}
    clean_up(state, player, player_an)
  end

  def make_move(state, :false, player, chessboard) do
    next_mover = Connector.update_game(state.games[player], {player, chessboard})
    send player, {:received}
    send next_mover, {:your_turn, chessboard}
    state
  end

  def make_move(state, :tie, player, _chessboard) do
    send player, {:tie}
    player_an = state.clients[player]
    send player_an, {:tie}
    clean_up(state, player, player_an)
  end

  def disconnect(state, pid) do
    player = state.pid_reg[pid]
    player_an = state.clients[player]
    send player_an, {:lucky_won}
    clean_up(state, player, player_an)
  end

  def clean_up(state, player, player_an) do
    pid = state.games[player]
    SubSupervisor.terminate_child(pid)
    IO.puts "Genserver #{inspect pid} exited because the game ended!"
    put_in(state, [:games, player], {})
    |> put_in([:games, player_an], {})
  end
  
end
