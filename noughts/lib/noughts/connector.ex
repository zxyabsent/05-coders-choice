defmodule Noughts.Connector do
  use GenServer

  #####
  # Game Server External API
  
  def start_link([], gameinfo) do
    GenServer.start_link(Noughts.Server, gameinfo)
  end

  def get_chessboard(game) do
    GenServer.call(game, { :get_board })
  end

  def update_game({}, _value) do
    :bad_argument
  end

  def update_game(game, value) do
    GenServer.cast(game, { :update_value, value})
  end

end
  
