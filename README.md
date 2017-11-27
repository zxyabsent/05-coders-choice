How to play the game?
   1.Open one terminal window as a server, give the node a long name and set its cookie. iex --name x@x --cookie secret_token -S mix
   2.Open one terminal window as a client, give the node a long name and set its cookie. iex --name x@x --cookie secret_token -S mix
   3.Create another client as player_two
   4.At the client, run 'HumanPlayer.new_game(arg)' where 'arg' is the long name of the server node.
   5.Here we go! Enjoy the game and take a look at the server terminal. It will inform you of what is going on!
   6.After a game ends,u can directly start another game at the current two clients with Step four.