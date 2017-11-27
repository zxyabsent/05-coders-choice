defmodule HumanPlayer do
  defdelegate new_game(node), to: HumanPlayer.Impl
end
