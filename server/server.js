// import Node.js modules
const http = require("http");
const url = require("url");
const events = require("events");
const midi = require("midi");

// event emitter
let eventEmitter = new events.EventEmitter();
eventEmitter.on('noteOn', handleNoteOn);

function handleNoteOn(channel, note, velocity) {

  if (isPortOpen) {
    
    console.log("note: " + ('000'+ note).slice(-3) +
                ", velocity: " + ('000'+ velocity).slice(-3) +
                ", channel: " + ('00'+ channel).slice(-2) );

    let noteOnMidiMessage = [143+Number(channel), Number(note), Number(velocity)];
    midiOutput.sendMessage(noteOnMidiMessage);
  }
}

// declare variable for MIDI output
const midiOutput = new midi.Output();

// create a virtual port for output
midiOutput.openVirtualPort("node.js MIDI output port");

// boolean for checking if port has been opened
let isPortOpen = false;

// create http server
http.createServer(function (req, res) {

  // handle favicon.ico request
  if (req.url === "/favicon.ico") {
    res.writeHead(404);
    res.end();
  }
  // for all other requests
  else {
    res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
    res.write('<p>hi!<p>');
    res.write('<p>you can send messages to the server like this:</p>')
    res.write('<p>http://IP:PORT/?type=TYPE&channel=CHANNEL&number=NUMBER&value=VALUE</p>');
    res.write('<br/>');
    
    res.write('<p>where:</p>');
    res.write('<p>IP: a.b.c.d with a, b, c, d 8-it resolution, 0-255</p>');
    res.write('<p>PORT: 9000</p>');
    res.write('<p>TYPE: noteOn, noteOff, controlChange</p>');
    res.write('<p>CHANNEL: integer 4-bit resolution, 0-15</p>');
    res.write('<p>NUMBER: integer 7-bit resolution, 0-127</p>');
    res.write('<p>VALUE: integer 7-bit resolution, 0-127</p>');
    res.write('<br/>');

    res.write('<p>today, these values are fixed:</p>');
    res.write('<p>IP = 216.180.89.221</p>');
    res.write('<p>PORT = 12345</p>');
    res.write('<p>TYPE = noteOn</p>');
    res.write('<br/>');

    res.write('<p>today, you can experiment with these values</p>');
    res.write('<p>CHANNEL = selects a different instrument to play</p>');
    res.write('<p>NUMBER = selects a different note on the instrument</p>');
    res.write('<p>VALUE = selects a different velocity for the note</p>');
    res.write('<br/>');
   
    res.write('<p>examples:</p>');
    res.write('<p>http://IP:PORT/?type=noteOn&channel=1&number=60&value=90</p>');
    
    // retrieve query and parse it
    let queryParsed = url.parse(req.url, true).query;

    // update query variables
    let queryType = queryParsed.type;
    let queryChannel = queryParsed.channel;
    let queryNumber = queryParsed.number;
    let queryValue = queryParsed.value;
    
    // populate body of html
    res.write('<br/>');
    res.write('<p>you asked for: </p>');
    res.write('<p>type: ' + queryParsed.type + '</p>');
    res.write('<p>channel: ' + queryChannel + '</p>');
    res.write('<p>number: ' + queryNumber + '</p>');
    res.write('<p>value: ' + queryValue + '</p>');
    
    // handle different responses and emit events
    if (queryType == "noteOn") {
      eventEmitter.emit('noteOn', queryChannel, queryNumber, queryValue);
    }

    // end the response
    res.end();    
  }

}).listen(9000);
