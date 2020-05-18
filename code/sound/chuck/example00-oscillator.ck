// declare variable for MIDI input
MidiIn midiInput;

// open Window -> Device Browser -> MIDI
// replace the number with the corresponding one to
// the input "node.js MIDI output port"
2 => int midiPort;

// declare variable for MIDI message
MidiMsg message;

// try to open the port
midiInput.open (midiPort) => int isOpen;

// if the port did not open, quit the program
if (!isOpen) {
	me.exit();
}

// declare 16 sine wave oscillators
// one oscillator per channel
SinOsc myOscillators[16];

// each oscillator will be fed to speakers
// and the audio needs to be normalized by this factor
myOscillators.cap() => float normalize;

// connect all oscillators to dac
for(0 => int i; i < myOscillators.cap(); i++) {
	60.0 => myOscillators[i].freq;
	1.0 => myOscillators[i].gain;
}

// infinite loop
while (10 :: ms => now) {
	
	// receive MIDI messages
	// each message is comprised of data1, data2, data3
	while (midiInput.recv(message)) {
		
		// check for noteOn by checking if data1 is in range 144-159
		if (message.data1 >= 144 && message.data1 < 159) {
			
			// retrieve channel
			// by % 144, newChannel in range 0-15
			// we use this to access each oscillator in our array
			message.data1 % 144 => int newChannel;
			
			// retrieve note and velocity
			message.data2 => int newNote;
			message.data3 => int newVelocity;
			
			// calculate new frequency and gain
			// mtof for converting from MIDI note value to frequency
			Std.mtof(newNote) => float newFreq;
			// divide by 127 and norm by normFactor for gain
			(newVelocity / 127.0) / normalize => float newGain;
			
			<<< newChannel, newFreq, newGain >>>;
			
			// update corresponding oscillator
			newFreq => myOscillators[newChannel].freq;
			newGain => myOscillators[newChannel].gain;
			
		}
		<<< message.data1, message.data2, message.data3, "MIDI message" >>>;
	}	
}
