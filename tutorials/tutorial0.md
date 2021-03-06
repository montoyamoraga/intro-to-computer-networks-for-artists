# tutorial0

## Summary

This tutorial introduces you to the introductory concepts of computer networks, and shows you how to know the IP address of your computer.

This tutorial has no pre-requisites.

## Concepts

###  Bit

A bit is a piece of information.

A bit can have one of two values, 0 or 1.

### Bit resolution

With more bits, we can represent more data.

Bit resolution (B) is the amount of bits we are using to represent data.

The amount of different values grows exponentially with bit resolution.

Number of different values = 2^B

Some examples of different resolutions and all the possible values:

Using 1 bit ; 2^1 = 2 values ; 0, 1

Using 2 bit ; 2^2 = 4 values ; 00, 01, 10, 11

Using 3 bit ; 2^3 = 8 values ; 000, 001, 010, 011, 100, 101, 110, 111

Using 4 bit ; 2^4 = 16 values ; 0000, 0001, 0010, 0011, 0100, 0101, 0110, 0111, 1000, 1001, 1010, 1011, 1100, 1101, 1110, 1111

### IP address

IP address stands for "Internet Protocol address".

It is a number assigned to a computer connected to a computer network.

We will learn and use the flavor IPv4, there is also IPv6.

### IPv4

IPv4 defines an IP address as a number with 32 bit resolution.

We write this address with 4 numbers, each with 8 bit resolution.

Since each number is 8 bit resolution, their range is 0-255.

The typical syntax is each number separated by a ".".

One example of an IP address is 127.0.0.1

### 127.0.0.1

This is an address you see often, because it means "this computer".

It is useful when you want your code to refer to the computer it is running it.

### localhost

127.0.0.1 and localhost mean the same, "this computer".

### Computer ports

Computer ports are needed for communication between computers.

For receiving data on your computer, you need to open a port.

For sending data to a computer, you need to know the address of the computer you are sending to, and you also need to specify the target port.

Ports have 16 bit resolution, so their range is from 0 to 65,535.

## Tasks

### Understand your private IP address

Your computer is connected to the internet through a router.

Your router sets up a computer network, where all your devices are connected to.

Each device connects to the internet through your router.

Each device on your home computer network has a unique private IP address.

Each private IP address looks like this: 192.168.X.Y, where X and Y are numbers between 0 and 255.

With these private IP addresses you can make your devices send messages to each other through the same network.

You can check your IP address by opening your terminal application and executing ```ifconfig``` on Linux / Mac, or ```ipconfig``` on Windows.

### Understand your public IP address

The private IP address of your computer allows other devices on your home computer network to send messages to it.

If you want other computers across the internet, at the other side of your router, to send messages to your computer, you need a public IP address.

To know your public IP address, open your internet browser and do a search for "my IP address", or go to a website like [https://whatismyipaddress.com/](https://whatismyipaddress.com/).

This public IP address is the one your router has right now, and it is assigned by your internet service provider (ISP), and most probably it changes often.

You can use your public IP address to approximately estimate where you geographically are in the world.

For this tutorial, we embrace this constraint, and we acknowledge that our connections will work for the moment, and will break in the future.

### Enable port forwarding on your router

This is the trickiest part of the tutorial, and it depends on the router and/or internet service provider you are using.

Please adapt this example to your case, and help by contributing with more examples.

I am using the Starry internet service provider. On their mobile app, I enabled a port forwarding from port X to Y on the private IP address of my computer, using protocols TCP and UDP.

With this, I made my computer accesible to the internet.

#### Send messages to the computer

After you enable the port forwarding, you can send messages to the computer.

### Understand the data flow

In these tutorials, you need the following:

* One computer acting as receiver
* One computer acting as sender

The communication is unidirectional, and there is no guarantee that the data is received.

The bits might be lost midway, and nobody will know where they go :(


We want senders to be able to send messages such as "draw a triangle" or "play a snare drum sound", and have the software on the receiver's side to interpret this message.




## Receive the messages

The receiver needs to be connected over the internet.

We assume the receiver is connected to the internet through a router at their home. 

Our computer has an address at home, as well as all the other devices.

## Receiver

### Installation

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
