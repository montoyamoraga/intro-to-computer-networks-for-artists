# tutorial0

## Summary

This tutorial introduces you to the introductory concepts of computer networks, and shows you how to know the IP address of your computer.


## Concepts

###  Bits

A bit is a piece of information.

A bit can have one of two values, 0 or 1.

If we want to represent the decimal numbers 0, 1, 2, 3 with bits, we can use this conversion:

* 0 - 00
* 1 - 01
* 2 - 10
* 3 - 11



## Steps

There is one receiver, one or more senders.

Receivers are people who run software for audiovisual generation, and open it to the internet and enjoy the experience.

Senders are people who run software so that they can trigger or control the audiovisual software on the receiver.

### Human message to bits

We want senders to be able to send messages such as "draw a triangle" or "play a snare drum sound", and have the software on the receiver's side to interpret this message.

On this tutorial we will be using MIDI to codify our messages. MIDI is a way of packaging information. It is usually done for music, and here we will use it for audiovisual parameters in general.

We will use MIDI, which allows to send messages with seven bit resolution. Seven bits means we have pow(2, 7) = 128 different values. In computers we usually start counting from 0, so our values will go from a minimum of 0 to a maximum of 127.

## Bits over the internet

The sender will now be able to send these bits over the internet.

This communication will be unidirectional, the sender cannot send information back.

The bits might be lost midway, and nobody will know where they go :(


## Receive the messages

The receiver needs to be connected over the internet.

We assume the receiver is connected to the internet through a router at their home. 

Our computer has an address at home, as well as all the other devices.

## Receiver

### Dependencies

We will use the following software on your computer:

* Terminal application
* Node.js
* A web browser

Additionally, you have the option use any combination of these four softwares for media arts:

* [ChucK](https://chuck.cs.princeton.edu/)
* [openFrameworks](https://openframeworks.cc/)
* [Processing](https://processing.org/)
* [Pure Data](https://puredata.info/)

### Setup

* Open your terminal application
* Run the command ```node --version``` to check if you have Node.js installed
  * If your terminal outputs something like ```v14.1.0```, you have Node.js installed, yay.
  * If you don't have Node.js installed, please follow the instructions here: [https://nodejs.org/](https://nodejs.org/)
* Download this repository TODO: add link to releases.
* Uncompress the folder and place it on your Desktop.


## Sender

* There can be many senders per every receiver
* The sender will have to give you many 
