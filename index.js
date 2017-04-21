var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var mysql = require('mysql');

// using db connection
var dbConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '123456',
    database: 'rockabyteServiceV3Test'
});

// using pool connection
var pool  = mysql.createPool({
    connectionLimit : 10,
    host: 'localhost',
    user: 'root',
    password: '123456',
    database: 'rockabyteServiceV3Test'
});

// dbConnection.connect();
app.get('/', function(req, res) {
    // res.send('<h1>Hello world</h1>');
    res.sendFile(__dirname + '/index.html');
});

var someVar = [];

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

        var friendUserName ;

        pool.getConnection(function(err, connection) {
            // Use the connection
            var query = connection.query('SELECT * FROM userProfile WHERE userID = ?', [myUserID], function (error, results, fields) {
                // And done with the connection.
                connection.release();

                // Handle error after the release.
                if (error) throw error;
                console.log(results);
                // Don't use the connection here, it has been returned to the pool.

                socket.room = roomname; //we have this from both the userID's
                socket.join(roomname); //we have this from both the userID's
                socket.username = username; //myUserName
                // here i will have to emmit details based on which the page will be setuped
                // displayFriendName
                // and older messages object which can be recovered later

                console.log(friendUserName);
                console.log(someVar);
                var initialDetailsObj = {
                    friendUserName : results[0].userName,
                    earlyMessages : [
                        {
                            msg:'hello'
                        },
                        {
                            msg: 'reply asap',
                        }
                    ],
                };

                console.log(initialDetailsObj);
                io.to(socket.room).emit('INITIAL_DETAILS', initialDetailsObj);
            });
            console.log(query.results);
        });
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
