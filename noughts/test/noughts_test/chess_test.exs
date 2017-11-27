defmodule NoughtsTest.ChessTest do
  use ExUnit.Case
  doctest Noughts.Chess

  test "init the board" do
    assert Noughts.Chess.initChess(3) == ["_","_","_"]
  end

  test "win the game" do
    board = [ "x", "x", "x", "o", "o", "_", "o", "_", "_"]
    assert Noughts.Chess.won(board) == :true
  end

  test "end up a tie" do
    board = [ "o", "x", "o", "o", "x", "x", "x", "o", "o" ]
    assert Noughts.Chess.won(board) == :tie
  end

  test "normal sequence" do
    board = [ "o", "_", "o", "o", "x", "x", "x", "o", "_" ]
    assert Noughts.Chess.won(board) == :false
  end

end
