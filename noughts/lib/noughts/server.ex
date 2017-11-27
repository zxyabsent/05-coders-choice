defmodule Noughts.Server do

  #####
  # Game Server Implementation

  def init([game_id | player_info]) do
    restore(Noughts.Stash.fetch(game_id), game_id, player_info)
  end

  def restore(:error, game_id, [player_one, player_two]) do
    { :ok, { %Noughts.Game{
	       player_one: player_one,
	       player_two: player_two,
	       board: Noughts.Chess.chessboard}, game_id } }
  end

  def restore({:ok, value}, game_id, _player_info) do
    { :ok, { value, game_id } }
  end

  def handle_call({:get_board}, _from, {state, game_id}) do
    { :reply, state.board, {state, game_id} }
  end

  def handle_cast({:update_value, {cb}}, {state, game_id}) do
    { :noreply, {%Noughts.Game{state | board: cb}, game_id} }
  end

  def terminate(_reason, {state, game_id}) do
    Noughts.Stash.update(game_id, state)
  end

  def find_opponent(:true, state) do
    state.player_one
  end

  def find_opponent(:false, state) do
    state.player_two
  end
  
end
