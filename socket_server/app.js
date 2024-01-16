const express = require('express');
const http = require('http');
const socketIO = require('socket.io');

// Set up an Express app
const app = express();

// Create a server from the Express app
const server = http.createServer(app);

// Attach socket.io to the server
const io = socketIO(server);

// Serve a simple message on the root route
app.get('/', (req, res) => {
    res.send('Socket.IO with Express');
});

// Handle connection events and setup event listeners
io.on('connection', (socket) => {
    console.log('A user connected');

    // Handle 'message' events from clients
    socket.on('message', (data) => {
        console.log('Message received on server:', data);
        io.emit('newMessage', "Echo from server: " + data);
    });

    socket.on('word', (data) => {
        console.log('Message received on server:', data);
        io.emit('word', "Echo from server: " + data);
    });


    socket.on('increment', (count) => {
        console.log('Increment count:', count);
        // Broadcast the new count to all clients
        io.emit('countUpdated', count);
    });

    // Handle disconnection events
    socket.on('disconnect', () => {
        console.log('User disconnected');
    });
});

// Start the server on port 3000
server.listen(3000, () => {
    console.log('Server running on port 3000');
});
