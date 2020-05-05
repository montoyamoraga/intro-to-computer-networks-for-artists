const {PeerServer} = require("peer");

const peerServer = PeerServer(
  {
    port: 9000,
    path: "/mypapp"
  });
