defmodule Noughts.Connector do
  use GenServer

  #####
  # Game Server External API
  
  def start_link(player_id) do
    GenServer.start_link(Noughts.Server, player_id)
  end

  def get_positions(game) do
    GenServer.call(game, { :get_value })
  end

  def update_game(game, value) do
    GenServer.cast(game, { :update_value, value})
  end

end
  
