defmodule ConnectorTest do
  use ExUnit.Case
  doctest Noughts.Connector

  test "ignore invaild GenServer pid" do
    assert Noughts.Connector.update_game({}, "player_one") == :bad_argument
  end

end
    
