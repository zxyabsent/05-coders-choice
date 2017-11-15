defmodule ConnectorTest do
  use ExUnit.Case
  doctest Noughts.Connector

  test "init the game" do
    { :ok, pid } = Noughts.Connector.start_link(:tom)
    assert Noughts.Connector.get_positions(pid) == ["_", "_", "_", "_", "_", "_", "_", "_", "_"]
    Noughts.Stash.delete(:tom)
  end

  test "restore a game" do
    Noughts.Stash.update(:tom, ["_", "_", "y"])
    { :ok, pid } = Noughts.Connector.start_link(:tom)
    assert Noughts.Connector.get_positions(pid) == ["_", "_", "y"]
    Noughts.Stash.delete(:tom)
  end

  test "update the game"  do
    { :ok, pid } = Noughts.Connector.start_link(:tom)
    assert Noughts.Connector.get_positions(pid) == ["_", "_", "_", "_", "_", "_", "_", "_", "_"]
    Noughts.Connector.update_game(pid, ["_", "_", "x"])
    assert Noughts.Connector.get_positions(pid) == ["_", "_", "x"]
    Noughts.Stash.delete(:tom)
  end

end
    
