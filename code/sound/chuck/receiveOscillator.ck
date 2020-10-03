OscRecv myReceiver;

13000 => myReceiver.port;

myReceiver.listen();

myReceiver.event("newEvent/, i") @=> OscEvent newEvent;

while (true) {
	
	newEvent => now;
	
	while (newEvent.nextMsg() != 0) {
		newEvent.getInt() => int theNumber;
		<<< theNumber >>>;
	}
}