defmodule Noughts.Chess do
  def chessboard do
    initChess(9)
  end
  
  def initChess(0) do
    []
  end

  def initChess(i) do
    ["_"] ++ initChess(i-1)
  end

  def won([ a, a, a, _, _, _, _, _, _ ]), do: true
  def won([ _, _, _, a, a, a, _, _, _ ]), do: true
  def won([ _, _, _, _, _, _, a, a, a ]), do: true
  def won([ a, _, _, a, _, _, a, _, _ ]), do: true
  def won([ _, a, _, _, a, _, _, a, _ ]), do: true
  def won([ _, _, a, _, _, a, _, _, a ]), do: true
  def won([ a, _, _, _, a, _, _, _, a ]), do: true
  def won([ _, _, a, _, a, _, a, _, _ ]), do: true
  def won(chessboard) do
    isFull(Enum.find(chessboard, fn(x) -> x == "_" end))
  end

  def isFull(nil) do
    :tie
  end

  def isFull(_) do
    :false
  end
end
