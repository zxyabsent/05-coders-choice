Name: Xinyuan Zong           ID:   47524819

## Proposed Project

My project is a command-line-based noughts-and-crosses game. One player
at one client finds a matching player at another client and then they play
the game. Thy strategy of the game itself is easy and I focus on the concurrent
matching and gaming system at the server. Clients should communicate only
through the server. I also consider enhancing the game based on a webpage if
it is not a big enough project and recording the players' information,
e.g. winrates by the implementation of database in order to provide a better matching.

## Outline Structure

Starting as a command-line-based game, the client works as a single process
receiveing and sending data, and drawing some basic UI. The server would have
a three-level hierarchy,i.e.
(1) a highest supervisor,
(2a)a second-level controller to communicate with clients, and to do some logical processing,
(2b)a second-level supervisor to manage genservers
and (3)some third-level servers to store the games' information.
I may put the game into a phoenix framework with a simple implementation if i have time. :-)
