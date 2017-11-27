defmodule Noughts.Connector do
  use GenServer

  #####
  # Game Server External API
  
  def start_link(game_info) do
    GenServer.start_link(Noughts.Server, game_info)
  end

  def get_positions(game) do
    GenServer.call(game, { :get_value })
  end

  def update_game(game, value) do
    GenServer.call(game, { :update_value, value})
  end

end
  
