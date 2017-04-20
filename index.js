var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

app.get('/', function(req, res) {
    // res.send('<h1>Hello world</h1>');
    res.sendFile(__dirname + '/index.html');
});

io.on('connection', function(socket) {
    console.log('a user connected');

    socket.on('INITIAL_SETUP', function(friendUserID, myUserID) {
        var first;
        var last;
        var roomname;
        var username = myUserID;
        if(friendUserID > myUserID){
            first = myUserID;
            last = friendUserID;
            roomname = first+last;
        }else{
            first = friendUserID;
            last = myUserID;
            roomname = first+last;
        }
        socket.room = roomname;
        socket.join(roomname);
        socket.username = username;
        console.log(socket);
        console.log(username +'---'+ roomname);
    });

    socket.on('SEND_MESSAGE_CLIENT', function(message) {
        io.to(socket.room).emit('FORWARD_MESSAGE_SERVER', message, socket.username);
    });

    socket.on('disconnect', function() {
        console.log('user disconnected');
    });
});

http.listen(3000, function() {
    console.log('listening on *:3000');
});
