MidiIn midiInput;

// open Window -> Device Browser -> MIDI
// replace the number with the corresponding one to "TODO"
2 => int midiPort;

MidiMsg message;

// try to open the port
midiInput.open (midiPort) => int isOpen;

// if the port did not open, exit
if (!isOpen) {
	me.exit();
}

// declare sine wave oscillator
SinOsc myOsc; 

// connect oscillator to dac
myOsc => dac;

440 => myOsc.freq;
0.5 => myOsc.gain;

// infinite loop
while (10 :: ms => now) {
	
	Std.mtof(message.data2) => myOsc.freq;
	message.data3 / 127.0 => myOsc.gain;
	
	while (midiInput.recv(message)) {
		<<< message.data1, message.data2, message.data3, "MIDI message" >>>;
	}
	
	
}