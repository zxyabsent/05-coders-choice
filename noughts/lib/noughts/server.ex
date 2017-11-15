defmodule Noughts.Server do

  #####
  # Game Server Implementation

  def init(player_id) do
    restore(Noughts.Stash.fetch(player_id), player_id)
  end

  def restore(:error, player_id) do
    #####
    # Who to update the stash is not yet decided.
    value = ["_", "_", "_", "_", "_", "_", "_", "_", "_"]
    Noughts.Stash.update(player_id, value)
    { :ok, value }
  end

  def restore({:ok, value}, _player_id) do
    { :ok, value }
  end

  def handle_call({:get_value}, _from, state) do
    { :reply, state, state }
  end

  def handle_cast({:update_value, value}, _state) do
    { :noreply, value }
  end
  
end
