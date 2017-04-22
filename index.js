// importing stuff
var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var mysql = require('mysql');
var async = require("async");

// Global variable
var myUserIDG;
var friendUserIDG;
var myUserNameG;
var friendUserNameG;

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

// pool callback functions
// function queryExecutionMyUserID(err, connection) {
//     var query = connection.query('SELECT * FROM userProfile WHERE userID = ?', [myUserIDG], function (error, results, fields) {
//
//         connection.release();// And done with the connection.
//
//         if (error) throw error; // Handle error after the release.
//
//         console.log(results[0].userName);
//         myUserNameG = results[0].userName;
//         callback();
//     });
// }
//
// function queryExecutionFriendUserID(err, connection) {
//     var query = connection.query('SELECT * FROM userProfile WHERE userID = ?', [friendUserIDG], function (error, results, fields) {
//
//         connection.release();// And done with the connection.
//
//         if (error) throw error; // Handle error after the release.
//
//         console.log(results[0].userName);
//         friendUserNameG = results[0].userName;
//         callback();
//     });
// }

// dbConnection.connect();
app.get('/', function(req, res) {
    // res.send('<h1>Hello world</h1>');
    res.sendFile(__dirname + '/index.html');
});

function userDetails(userName) {
    this.userName = userName;
}

io.on('connection', function(socket) {
    console.log('a user connected');

    socket.on('INITIAL_SETUP', function(friendUserID, myUserID) {
        myUserIDG = myUserID;
        friendUserIDG = friendUserID;

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

        // async.parallel([
        //     function(callback) { function1(callback); },
        //     function(callback) { function2(callback); }
        // ], function(err, values) {
        //     function3(values[0], values[1]);
        // });

        // async.parallel([
        //     function(callback) { function1(callback); },
        //     function(callback) { function2(callback); }
        // ], function(err, values) {
        //     function3(values[0], values[1]);
        // });

        async.parallel([
            function(callback){
                pool.getConnection(function queryExecutionMyUserID(err, connection) {
                    var query = connection.query('SELECT * FROM userProfile WHERE userID = ?', [myUserIDG], function (error, results, fields) {

                        connection.release();// And done with the connection.

                        if (error) throw error; // Handle error after the release.

                        console.log(results[0].userName);
                        myUserNameG = results[0].userName;
                        callback();
                    });
                });
            },function(callback){
                pool.getConnection(function queryExecutionFriendUserID(err, connection) {
                    var query = connection.query('SELECT * FROM userProfile WHERE userID = ?', [friendUserIDG], function (error, results, fields) {

                        connection.release();// And done with the connection.

                        if (error) throw error; // Handle error after the release.

                        console.log(results[0].userName);
                        friendUserNameG = results[0].userName;
                        callback();
                    });
                });
            }
        ], function(err, results) {
            socket.room = roomname; //we have this from both the userID's
            socket.join(roomname); //we have this from both the userID's
            socket.username = myUserNameG; //myUserName
            // here i will have to emmit details based on which the page will be setuped
            // displayFriendName
            // and older messages object which can be recovered later
            var initialDetailsObj = {
                friendUserName : friendUserNameG,
                currentUserName: myUserNameG,
                earlyMessages : [
                    {
                        msg:'hello'
                    },
                    {
                        msg: 'reply asap',
                    }
                ],
            };

            console.log(myUserNameG+" ======= "+friendUserNameG);
            console.log(initialDetailsObj);
            io.to(socket.id).emit('INITIAL_DETAILS', initialDetailsObj);
        } );

        // pool.getConnection(queryExecutionMyUserID);
    });

    socket.on('SEND_MESSAGE_CLIENT', function(message) {
        io.to(socket.room).emit('FORWARD_MESSAGE_SERVER', message, socket.username);
    });

    socket.on('FRIEND_TYPING',function() {
        console.log('friend typing');
        socket.broadcast.to(socket.room).emit('FRIEND_TYPING_CLIENT');
    });

    socket.on('disconnect', function() {
        console.log('user disconnected');
    });
});

http.listen(3000, function() {
    console.log('listening on *:3000');
});
