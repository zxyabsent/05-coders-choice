defmodule NoughtsTest do
  use ExUnit.Case
  doctest Noughts

  test "greets the world" do
    assert Noughts.hello() == :world
  end
end
