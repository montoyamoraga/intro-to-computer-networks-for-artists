const http = require('http');
const url = require('url');
const events = require('events');
const midi = require('midi');

// create event emitter
let eventEmitter = new events.EventEmitter();

// set callbacks for events
eventEmitter.on('noteOn', handleNoteOn);
eventEmitter.on('controlChange', handleControlChange);

// callback function for noteOn event
function handleNoteOn(note, velocity, instrument) {

  if (isPortOpen) {
    
    console.log("note: " + ('000'+ note).slice(-3) +
                ", velocity: " + ('000'+ velocity).slice(-3) +
                ", channel: " + ('00'+ channel).slice(-2) +
                ", instrument: " + (instrument));

    let noteOnMidiMessage = [143+Number(channel), Number(note), Number(velocity)];

    midiOutput.sendMessage(noteOnMidiMessage);
  }
}

// callback function for controlChange
// TODO: change name of parameters and write this function
function handleControlChange(note, velocity, instrument) {

  console.log("there was a control change event");
  
}

// MIDI output setup

// declare midiOutput for outputting
const midiOutput = new midi.Output();

// declare name of port to be opened
const midiOutputPortName = "to Max 1";
// boolean for checking if port has been opened
let isPortOpen = false;

// iterate through all the ports all the available MIDI ports in output
for (let i = 0; i < midiOutput.getPortCount(); i++) {
  console.log(midiOutput.getPortName(i));
  if (midiOutput.getPortName(i) == midiOutputPortName) {
    console.log("opened MIDI output port \"" + midiOutput.getPortName(i) + "\"");
    midiOutput.openPort(i);
    isPortOpen = true;
    break;
  }
}

// print error message if port cannot be opened
if (!isPortOpen) {
  console.log("could not open MIDI output port \"" + midiOutputPortName + "\"");
}

// create http server
http.createServer(function (req, res) {

  // check if request is favicon.ico
  if(req.url === '/favicon.ico') {
    res.writeHead(404);
    res.end();
  }
  // for all other requests
  else {

    res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
    res.write('<p>hi welcome to this server!<p>');
    res.write('<br/>');
    
    res.write('<p>example:</p>')
    res.write('<p>http://IP:PORT/?instrument=INSTRUMENT&type=TYPE&number=NUMBER&value=VALUE</p>');
    res.write('<br/>');
    
    res.write('<p>where:</p>');
    res.write('<p>IP: a.b.c.d with a, b, c, d 8-it resolution, 0-255</p>');
    res.write('<p>PORT: 9000</p>');
    res.write('<p>INSTRUMENT: selects which instrument: volcaBass, volcaBeats, volcaKeys</p>');
    res.write('<p>TYPE: noteOn, controlChange</p>');
    res.write('<p>NUMBER: integer 7-bit resolution, 0-127</p>');
    res.write('<p>VALUE: integer 7-bit resolution, 0-127</p>');
    res.write('<br/>');

    res.write('<p>for today, the ip is 216.180.89.221 and the port is 12345</p>');
    res.write('<p>examples:</p>');
    res.write('<p>http://216.180.89.221:12345/?instrument=volcaBeats&type=noteOn&number=38&value=127</p>');
    res.write('<p>http://216.180.89.221:12345/?instrument=volcaKeys&type=noteOn&number=60&value=127</p>');
    
    // retrieve query and parse it
    let queryParsed = url.parse(req.url, true).query;
    let queryInstrument = queryParsed.instrument;
    let queryType = queryParsed.type;
    let queryNumber = queryParsed.number;
    let queryValue = queryParsed.value;

    // populate body of html
    res.write('<br/>');
    res.write('<p>you asked for: </p>');
    res.write('<p>instrument: ' + queryInstrument + '</p>');
    res.write('<p>type: ' + queryParsed.type + '</p>');
    res.write('<p>number: ' + queryNumber + '</p>');
    res.write('<p>value: ' + queryValue + '</p>');
    
    // handle different responses and emit events
    if (queryType == "noteOn") {
      eventEmitter.emit('noteOn', queryNumber, queryValue, queryInstrument);
    }
    else if (queryType == "controlChange") {
      eventEmitter.emit('controlChange', queryNumber, queryValue, queryInstrument);
    }

    // end the response
    res.end();    
  }

}).listen(9000);
