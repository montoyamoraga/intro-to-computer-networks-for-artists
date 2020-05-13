// import Node.js modules
const http = require("http");
const url = require("url");
const events = require("events");
const midi = require("midi");

// event emitter
let eventEmitter = new events.EventEmitter();
eventEmitter.on('noteOn', handleNoteOn);

function handleNoteOn(channel, note, velocity) {
  console.log("note: " + ('000'+ note).slice(-3) +
              ", velocity: " + ('000'+ velocity).slice(-3) +
              ", channel: " + ('00'+ channel).slice(-2) );

  let noteOnMidiMessage = [143+Number(channel), Number(note), Number(velocity)];
  midiOutput.sendMessage(noteOnMidiMessage);
}

// declare variable for MIDI output
const midiOutput = new midi.Output();

// create a virtual port for output
midiOutput.openVirtualPort("node.js MIDI output port");

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
    res.write('<p>hi! to send messages to the server, use this syntax<p>');
    res.write('<p>http://IP:PORT/?type=TYPE&channel=CHANNEL&number=NUMBER&value=VALUE</p>');
    res.write('<p>IP = a.b.c.d with a, b, c, d 0-255 | PORT = 9000 </p>');
    res.write('<p>TYPE = noteOn, noteOff, controlChange | CHANNEL = 0-15</p>');
    res.write('<p>NUMBER = 0-127 | VALUE = 0-127</p>');
    res.write('<br/>');

    res.write('<p>today, these parameters are fixed:</p>');
    res.write('<p>IP = 216.180.89.221 , PORT = 12345 , TYPE = noteOn </p>');
    res.write('<p>and you can experiment with these ones:</p>');
    res.write('<p>CHANNEL = selects a different instrument to play</p>');
    res.write('<p>NUMBER = selects a different note on the instrument</p>');
    res.write('<p>VALUE = selects a different velocity for the note</p>');
    res.write('<br/>');
   
    res.write('<p>examples:</p>');
    res.write('<p>http://216.180.89.221:12345/?type=noteOn&channel=1&number=60&value=90</p>');
    
    // retrieve query and parse it
    let queryParsed = url.parse(req.url, true).query;

    // update query variables
    let queryType = queryParsed.type;
    let queryChannel = queryParsed.channel;
    let queryNumber = queryParsed.number;
    let queryValue = queryParsed.value;
    
    // populate body of html
    res.write('<br/>');
    res.write('<p>you just asked for: </p>');
    res.write('<p>type = ' + queryParsed.type + ', channel = ' + queryChannel + '</p>');
    res.write('<p>number = ' + queryNumber + ', value =' + queryValue +'</p>');
    
    // handle different responses and emit events
    if (queryType == "noteOn") {
      eventEmitter.emit('noteOn', queryChannel, queryNumber, queryValue);
    }

    // end the response
    res.end();    
  }

}).listen(9000);
