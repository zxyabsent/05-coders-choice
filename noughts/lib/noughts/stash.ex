defmodule Noughts.Stash do
  use GenServer

  #####
  # External API

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, [], name: MyStash)
  end

  def fetch(key) do
    GenServer.call(MyStash, {:get_value, key})
  end

  def update(key, value) do
    GenServer.cast(MyStash, {:save_value, key, value})
  end

  def delete(key) do
    GenServer.cast(MyStash, {:delete_key, key})
  end
  
  #####
  # Stash Implementation
  def init(_default) do
    { :ok, %{} }
  end

  def handle_call({:get_value, key}, _from, state) do
    { :reply, Map.fetch(state, key), state}
  end

  def handle_cast({:save_value, key, value}, state) do
    { :noreply, Map.put(state, key, value) }
  end

  def handle_cast({:delete_key, key}, state) do
    { :noreply, Map.delete(state, key) }
  end

end

  
