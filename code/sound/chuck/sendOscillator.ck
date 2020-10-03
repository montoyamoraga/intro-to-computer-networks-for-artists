OscSend mySender;

"127.0.0.1" => string sendAddress;
13000 => int sendPort;

mySender.setHost(sendAddress, sendPort);

mySender.startMsg("newEvent/, i");

mySender.addInt(10);

