defmodule StashTest do
  use ExUnit.Case
  doctest Noughts.Stash

  test "init the GenServer" do
    assert Noughts.Stash.fetch(:tom) == :error
  end

  test "put in a new value then delete it" do
    Noughts.Stash.update(:tom, ["_", "_", "y"])
    assert Noughts.Stash.fetch(:tom) == {:ok, ["_", "_", "y"]}
    Noughts.Stash.delete(:tom)
    assert Noughts.Stash.fetch(:tom) == :error
  end

  #####
  # Here I found that I couldn't test a GenServer simply.
  # It seems that when I run "mix test", a GenServer has been started.
  # Since I named it, I couldn't start it again in my tests.
  # Therefore, I have to test all cases on the same GenServer, and undo
  # all the changes every time a test case ends.
  # Is there a better way to test a GenServer?

end
    
