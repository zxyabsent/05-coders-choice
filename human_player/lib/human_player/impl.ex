defmodule HumanPlayer.Impl do
  @server_name Noughts.Controller
  @name :player

  def new_game(node) do
    Process.register(self(), @name)
    node
    |> Node.connect
    |> checkConnect(node)
  end

  def checkConnect(:true, node) do
    send { @server_name, node}, {self(), @name, node(), :new_game }
    message_loop({"", node})
  end

  def checkConnect(:false, _node) do
    IO.puts "Connection failed!"
  end

  def message_loop(state) do
    state = receive do
      message -> get_next_move(message, state)
    end

    message_loop(state)
  end  

  def get_next_move({:won}, state) do
    IO.puts "\nCONGRATULATIONS! You won this game! Well played :-)"
    state
  end

  def get_next_move({:tie}, state) do
    IO.puts "\nJesus! It was a tie! Have a new try!"
    state
  end

  def get_next_move({:lucky_won}, state) do
    IO.puts "\nCONGRATULATIONS! You won this game because your opponent left the game!"
    state
  end

  def get_next_move({:game_start, chessboard, :false},{_, node}) do
    draw_current_board(chessboard)
    IO.puts "Your opponent moves fisrt! Waiting for his move!"
    { "x", node }
  end

  def get_next_move({:game_start, chessboard, :true}, {_, node}) do
    draw_current_board(chessboard)
    IO.puts "You move first! Think about a nice beginning!"
    cb = List.update_at(chessboard, get_move() - 1, &(&1 = "o")) |> drawing()
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
    cb = List.update_at(chessboard, get_move() - 1, &(&1 = chess)) |> drawing()
    send {@server_name, node}, {@name, node(), cb, :make_move}
  end

  def draw_current_board(cb) do
    IO.write "\e[H\e[2J"
    IO.puts drawing(cb)
  end

  def get_move() do
    [a, b] =
      IO.gets ("Your move:   ")
      |> String.trim
      |> String.slice(1..3)
      |> String.split(",")
    x = Integer.parse(a) # xth line
    y = Integer.parse(b) # yth column
    (x - 1) * 3 + y
  end

  defp drawing([a, b, c, d, e, f, g, h, i]) do
    """
    Noughts and crosses
    - - - - - - - -
    | #{inspect a}, #{inspect b}, #{inspect c} |
    | #{inspect d}, #{inspect e}, #{inspect f} |
    | #{inspect g}, #{inspect h}, #{inspect i} |
    - - - - - - - -
    """
  end
end

  
