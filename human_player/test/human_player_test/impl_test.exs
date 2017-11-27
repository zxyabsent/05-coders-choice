defmodule HumanPlayerTest.ImplTest do
  use ExUnit.Case
  doctest HumanPlayer.Impl

  test "return the right state" do
    state = {"x", :"server@MSI.smu.edu"}
    observe = HumanPlayer.Impl.get_next_move({:matching}, state)
    assert state == observe
  end

  test "return the exit signal" do
    state = {"x", :"server@MSI.smu.edu"}
    observe = HumanPlayer.Impl.get_next_move({:lucky_won}, state)
    assert observe == :exit
    list_test = [1,2,3,4,5,6,7,8,9]
    assert HumanPlayer.Impl.get_next_move({:won}, state) == :exit
    assert HumanPlayer.Impl.get_next_move({:lost, list_test}, state) == :exit
    assert HumanPlayer.Impl.get_next_move({:tie}, state) == :exit
    assert HumanPlayer.Impl.get_next_move({:tie, list_test}, state) == :exit
  end

  
end
