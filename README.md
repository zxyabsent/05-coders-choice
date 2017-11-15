The basic structure has been implemented.
The main five modules have been implemented:
(1) Top Supervisor
(2) A Second-Level Server Controller to monitor clients' requests and send data
(3) A Second-Level Stash to retain game data
(4) A Second-Level Supervisor to manage game GenServers
(5) A prototype of a third-level game GenServer.

Stash and game GenServer have passed several test cases repectively.
The other three modules as a whole have passed a simple test case.

Follow-ups:
(1) The implementation of the complete game logic.
(2) The implementation of a client.
(3) Put the game prototype into a pheonix framework if possible. 