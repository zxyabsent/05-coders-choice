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

  def won([ "x", "x", "x", _, _, _, _, _, _ ]), do: true
  def won([ _, _, _, "x", "x", "x", _, _, _ ]), do: true
  def won([ _, _, _, _, _, _, "x", "x", "x" ]), do: true
  def won([ "x", _, _, "x", _, _, "x", _, _ ]), do: true
  def won([ _, "x", _, _, "x", _, _, "x", _ ]), do: true
  def won([ _, _, "x", _, _, "x", _, _, "x" ]), do: true
  def won([ "x", _, _, _, "x", _, _, _, "x" ]), do: true
  def won([ _, _, "x", _, "x", _, "x", _, _ ]), do: true

  def won([ "o", "o", "o", _, _, _, _, _, _ ]), do: true
  def won([ _, _, _, "o", "o", "o", _, _, _ ]), do: true
  def won([ _, _, _, _, _, _, "o", "o", "o" ]), do: true
  def won([ "o", _, _, "o", _, _, "o", _, _ ]), do: true
  def won([ _, "o", _, _, "o", _, _, "o", _ ]), do: true
  def won([ _, _, "o", _, _, "o", _, _, "o" ]), do: true
  def won([ "o", _, _, _, "o", _, _, _, "o" ]), do: true
  def won([ _, _, "o", _, "o", _, "o", _, _ ]), do: true
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
