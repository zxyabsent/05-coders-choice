defmodule HumanPlayer.Impl do
  @server_name Noughts.Controller
  @name :player

  def new_game(node) do
    node
    |> Node.connect
    |> checkConnect(node)
  end

  def checkConnect(:true, node) do
    pid = spawn(__MODULE__, :message_loop, [{"", node}])
    Process.register(pid, @name)
    send { @server_name, node}, {pid, @name, node(), :new_game }
  end

  def checkConnect(:false, _node) do
    IO.puts "Connection failed!"
  end

  def message_loop(:exit) do
    Process.exit(self(), :shutdown)
  end

  def message_loop(state) do
    state = receive do
      message -> get_next_move(message, state)
    end

    message_loop(state)
  end  

  def get_next_move({:won}, _state) do
    IO.puts "\nCONGRATULATIONS! You won this game! Well played :-)"
    :exit
  end

  def get_next_move({:lost, chessboard}, _state) do
    draw_current_board(chessboard)
    IO.puts "Sorry, you lost the game! Work harder!"
    :exit
  end

  def get_next_move({:tie}, _state) do
    IO.puts "\nJesus! It was a tie! Have another try!"
    :exit
  end

  def get_next_move({:tie, chessboard}, _state) do
    draw_current_board(chessboard)
    IO.puts "\nJesus! It was a tie! Have another try!"
    :exit
  end

  def get_next_move({:lucky_won}, _state) do
    IO.puts "\nCONGRATULATIONS! You won this game because your opponent left the game!"
    :exit
  end

  def get_next_move({:game_start, chessboard, :false},{_, node}) do
    draw_current_board(chessboard)
    IO.puts "Your opponent moves first! Waiting for his move!"
    { "x", node }
  end

  def get_next_move({:game_start, chessboard, :true}, {_, node}) do
    draw_current_board(chessboard)
    IO.puts "You move first! Think about a nice beginning!"
    cb = List.update_at(chessboard, get_move(chessboard), &(&1 = "o"))
    draw_current_board(cb)
    send {@server_name, node}, {@name, node(), cb, :make_move}
    { "o", node }
  end

  def get_next_move({:received}, state) do
    IO.puts "Nice move! Now it is your opponent's turn!"
    state
  end

  def get_next_move({:matching}, state) do
    IO.puts "Finding a match!"
    state
  end
  
  def get_next_move({:your_turn, chessboard}, {chess, node}) do
    draw_current_board(chessboard)
    IO.puts "It is your turn! Move on!"
    cb = List.update_at(chessboard, get_move(chessboard), &(&1 = chess))
    draw_current_board(cb)
    send {@server_name, node}, {@name, node(), cb, :make_move}
    {chess, node}
  end

  def draw_current_board(cb) do
    IO.puts drawing(cb)
  end

  def get_move(chessboard) do
    x = IO.gets("Which line?  ")  |> String.trim |> Integer.parse # xth line
    y = IO.gets("Which column?  ")|> String.trim |> Integer.parse # yth column
    cond do
      x == :error || y == :error ->
	IO.puts "Invalid move! Please try again :-)\n"
	get_move(chessboard)
	  
      elem(x, 0) < 1 || elem(x, 0) > 3 || elem(y, 0) < 1 || elem(y, 0) > 3 ->
        IO.puts "Invalid move! Please try again :-)\n"
        get_move(chessboard)

      Enum.at(chessboard, (elem(x, 0) - 1) * 3 + elem(y, 0) - 1) != "_" ->
        IO.puts "The position has beed occupied! Please try again :-)\n"
        get_move(chessboard) 

      true -> (elem(x, 0) - 1) * 3 + elem(y, 0) - 1

    end
  end
									    
  defp drawing([a, b, c, d, e, f, g, h, i]) do
    """
    Noughts and crosses
    - - - - - - -
    | #{a} | #{b} | #{c} |
    | #{d} | #{e} | #{f} |
    | #{g} | #{h} | #{i} |
    - - - - - - -
    """
  end
end

  
