const http = require('http');
const url = require('url');
const events = require('events');
const midi = require('midi');

// create event emitter
let eventEmitter = new events.EventEmitter();
// set callback for noteOn event
eventEmitter.on('noteOn', handleNoteOn);

// callback function for noteOn event
function handleNoteOn(note, velocity, channel) {

  if (isPortOpen) {
    
    console.log("note: " + ('000'+ note).slice(-3) +
                ", velocity: " + ('000'+ velocity).slice(-3) +
                ", channel: " + ('00'+ channel).slice(-2) +
                ", instrument: " + (instrument));

    let noteOnMidiMessage = [143+Number(channel), Number(note), Number(velocity)];

    midiOutput.sendMessage(noteOnMidiMessage);
  }
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
    res.write('<p>http://IP:PORT/?posX=NUMBER&posY=NUMBER&color=NUMBEr</p>');
    res.write('<br/>');
    
    res.write('<p>where:</p>');
    res.write('<p>IP: a.b.c.d with a, b, c, d in range [0,255]</p>');
    res.write('<p>PORT: 9000</p>');
    res.write('<p>posX: integer between 0-999</p>');
    res.write('<p>posY: integer between 0-999</p>');
    res.write('<p>color: integer between 0-15</p>');
    res.write('<br/>');

    res.write('<p>for today, the ip is 216.180.89.221 and the port is 12345</p>');
    res.write('<p>examples:</p>');
    res.write('<p>http://216.180.89.221:12345/?posX=500&posY=300&color=0</p>');
    res.write('<p>http://216.180.89.221:12345/?posX=0&posY=100&color=12</p>');
    
    // retrieve query and parse it
    let queryParsed = url.parse(req.url, true).query;
  
    let queryNote = queryParsed.posX;
    let queryVelocity = queryParsed.posY;
    let queryChannel = queryParsed.color;

    // populate body of html
    res.write('<br/>');
    res.write('<p>you asked for: </p>');
    res.write('<p>posX: ' + queryNote + '</p>');
    res.write('<p>posY: ' + queryVelocity + '</p>');
    res.write('<p>color: ' + queryChannel + '</p>');
    // end the response
    res.end();

    // emit noteOn event 
    eventEmitter.emit('noteOn', queryNote, queryVelocity, queryChannel);
  }

}).listen(9000);
