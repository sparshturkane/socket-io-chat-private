// importing stuff
var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var mysql = require('mysql');
var async = require("async");
var moment = require("moment");
var request = require('request');

// server
// var rootUrl = 'http://faarbetterfilms.com/rockabyteServicesV4Test/index.php/api/'; //production
// var dbPassword = 'faar@2015'; //server

// localhost
var rootUrl = 'http://localhost/projects/rockabyte/rockabyteServicesV4Test/index.php/api/' //local
var dbPassword = '123456'; //local


// Global variable
var myUserIDG;
var friendUserIDG;
var myUserNameG;
var friendUserNameG;
// creating two arrays user and connections
connectedUserID = [];

// private Chat connectedUserID
privateChatConnectedUserID = [];

// using db connection
var dbConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: dbPassword,
    database: 'rockabyteServiceV3Test'
});

// using pool connection
var pool  = mysql.createPool({
    connectionLimit : 10,
    host: 'localhost',
    user: 'root',
    password: dbPassword,
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

function userDetails(myUserID,friendUserID) {
    this.myUserID = myUserID;
    this.friendUserID = friendUserID;
}

io.on('connection', function(socket) {
    console.log('a user connected');

    socket.on('INITIAL_SETUP', function(friendUserID, myUserID, chatTypeID) {
        chatTypeIDG = chatTypeID;
        if (chatTypeID == 1) {

            //pushing connected users in array
            // privateChatConnectedUserID.push(myUserID);

            // friendUserID = (typeof friendUserID !== 'undefined') ?  friendUserID : 1;
            // myUserID = (typeof myUserID !== 'undefined') ?  myUserID : 1;

            // friendUserID = friendUserID+1;
            // myUserID = myUserID+1;
            var friendOne = 1;
            var userOne = 1;
            friendOne = friendOne + friendUserID;
            userOne = userOne + myUserID
            console.log(friendOne);
            console.log(userOne);
            // if (((typeof friendUserID != '')||(typeof friendUserID != 'undefined'))
            // && ((typeof myUserID != '')||(typeof friendUserID != 'undefined'))) {
            if((friendOne != 1) && (userOne != 1)){
                myUserIDG = myUserID;
                friendUserIDG = friendUserID;
                console.log(myUserID);
                console.log(friendUserID);

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

                                // // console.log(results[0].fullName);
                                myUserNameG = results[0].fullName;
                                accessToken = results[0].accessToken;
                                profilePicG = results[0].profilePic;

                                callback();
                            });
                        });
                    },function(callback){
                        pool.getConnection(function queryExecutionFriendUserID(err, connection) {
                            var query = connection.query('SELECT * FROM userProfile WHERE userID = ?', [friendUserIDG], function (error, results, fields) {

                                connection.release();// And done with the connection.

                                if (error) throw error; // Handle error after the release.

                                // // console.log(results[0].fullName);
                                friendUserNameG = results[0].fullName;
                                callback();
                            });
                        });
                    }
                    ], function(err, results) {
                        socket.room = roomname; //we have this from both the userID's
                        socket.join(roomname); //we have this from both the userID's
                        socket.username = myUserNameG; //myUserName
                        socket.friendID = friendUserID;
                        socket.userID = myUserID;
                        socket.accessToken = accessToken;
                        socket.chatTypeID = chatTypeID;
                        if (profilePicG == '') {
                            profilePicG = "";
                        }
                        socket.profilePic = profilePicG
                        // here i will have to emmit details based on which the page will be setuped
                        // displayFriendName
                        // and older messages object which can be recovered later

                        var options = {
                            url: rootUrl+'getAllChats',
                            headers: {
                                'accesstoken': socket.accessToken
                            },
                            form: {
                                userID: socket.userID,
                                userFriendID: socket.friendID,

                            },
                            json:false

                        };
                        request.post(options, function(error, response, body){
                        var firstChar = body.substring(0, 1);
                        var firstCharCode = body.charCodeAt(0);
                        if (firstCharCode == 65279) {
                            // console.log('First character "' + firstChar + '" (character code: ' + firstCharCode + ') is invalid so removing it.');
                            body = body.substring(1);
                        }

                        firstChar = body.substring(0, 1);
                        firstCharCode = body.charCodeAt(0);
                        if (firstCharCode == 65279) {
                            // console.log('First character "' + firstChar + '" (character code: ' + firstCharCode + ') is invalid so removing it.');
                            body = body.substring(1);
                        }

                        earlierChat = JSON.parse(body);

                        if (earlierChat.allChats.length>0) {
                            lastChatID = parseInt(earlierChat.allChats[earlierChat.allChats.length-1].chats[earlierChat.allChats[earlierChat.allChats.length-1].chats.length - 1].chatID);
                            console.log(lastChatID);

                            // document for lastChatID code
                            // https://docs.google.com/drawings/d/1m6Za8Va2UPbBK8NgUjcPZbkbnUjvKorauxFBEdF3Qik/pub?w=1428&h=1111
                        } else {
                            lastChatID = 0;
                        }

                        var initialDetailsObj = {
                            friendUserName : friendUserNameG,
                            currentUserName: myUserNameG,
                            earlyMessages : earlierChat,
                            accessToken :socket.accessToken,
                        };

                        this[myUserNameG] = new userDetails(myUserID, friendUserID);
                        // // console.log(myUserNameG+" ======= "+friendUserNameG);
                        // //console.log(initialDetailsObj);
                        io.to(socket.id).emit('INITIAL_DETAILS', initialDetailsObj);
                    });

                        // online offline status of user
                        privateUserOnlineOfflineStatus('1');
                } );

                // pool.getConnection(queryExecutionMyUserID);
            }


        } else if (chatTypeID == 2) {

            // var connectedIDPushData = {
            //     groupID : friendUserID,
            //     userID : myUserID
            // };

            // connectedUserID.push(connectedIDPushData);
            // console.log(connectedUserID);

            

            var friendOne = 1;
            var userOne = 1;
            friendOne = friendOne + friendUserID;
            userOne = userOne + myUserID
            console.log(friendOne);
            console.log(userOne);

            if((friendOne != 1) && (userOne != 1)){
                myUserIDG = myUserID;
                friendUserIDG = friendUserID;
                console.log(myUserID);
                console.log(friendUserID);

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

                                // // console.log(results[0].fullName);
                                myUserNameG = results[0].fullName;
                                accessToken = results[0].accessToken;
                                profilePicG = results[0].profilePic;

                                callback();
                            });
                        });
                    },function(callback){
                        pool.getConnection(function queryExecutionFriendUserID(err, connection) {
                            var query = connection.query('SELECT * FROM groups WHERE groupID = ?', [friendUserIDG], function (error, results, fields) {

                                connection.release();// And done with the connection.

                                if (error) throw error; // Handle error after the release.

                                // // console.log(results[0].fullName);
                                friendUserNameG = results[0].groupName;
                                callback();
                            });
                        });
                    }
                    ], function(err, results) {
                        socket.room = friendUserIDG; //we have this from both the userID's
                        socket.join(friendUserIDG); //we have this from both the userID's
                        socket.username = myUserNameG; //myUserName
                        socket.friendID = friendUserID;
                        socket.userID = myUserID;
                        socket.accessToken = accessToken;
                        socket.chatTypeID = chatTypeID;
                        if (profilePicG == '') {
                            profilePicG = "";
                        }
                        socket.profilePic = profilePicG
                        // here i will have to emmit details based on which the page will be setuped
                        // displayFriendName
                        // and older messages object which can be recovered later

                        var options = {
                            url: rootUrl+'getAllGroupChats',
                            headers: {
                                'accesstoken': socket.accessToken
                            },
                            form: {
                                userID: socket.userID,
                                userFriendID: socket.friendID,

                            },
                            json:false

                        };
                        request.post(options, function(error, response, body){
                        var firstChar = body.substring(0, 1);
                        var firstCharCode = body.charCodeAt(0);
                        if (firstCharCode == 65279) {
                            console.log('First character "' + firstChar + '" (character code: ' + firstCharCode + ') is invalid so removing it.');
                            body = body.substring(1);
                        }

                        firstChar = body.substring(0, 1);
                        firstCharCode = body.charCodeAt(0);
                        if (firstCharCode == 65279) {
                            console.log('First character "' + firstChar + '" (character code: ' + firstCharCode + ') is invalid so removing it.');
                            body = body.substring(1);
                        }

                        earlierChat = JSON.parse(body);

                        if (earlierChat.allChats.length>0) {
                            lastChatID = parseInt(earlierChat.allChats[earlierChat.allChats.length-1].chats[earlierChat.allChats[earlierChat.allChats.length-1].chats.length - 1].chatID);
                            console.log(lastChatID);

                            // document for lastChatID code
                            // https://docs.google.com/drawings/d/1m6Za8Va2UPbBK8NgUjcPZbkbnUjvKorauxFBEdF3Qik/pub?w=1428&h=1111
                        } else {
                            lastChatID = 0;
                        }

                        var initialDetailsObj = {
                            friendUserName : friendUserNameG,
                            currentUserName: myUserNameG,
                            earlyMessages : earlierChat,
                            accessToken :socket.accessToken,
                        };

                        this[myUserNameG] = new userDetails(myUserID, friendUserID);
                        // // console.log(myUserNameG+" ======= "+friendUserNameG);
                        // //console.log(initialDetailsObj);
                        io.to(socket.id).emit('INITIAL_DETAILS', initialDetailsObj);
                    });

                    //calling api groupUsersOnlineOffline()
                    groupUserOnlineOfflineStatus('1');

                } );

                // pool.getConnection(queryExecutionMyUserID);
            }
        }
    });

    socket.on('SEND_MESSAGE_CLIENT', function(message) {
        // console.log('hitting SEND_MESSAGE_CLIENT');
        // console.log(privateChatConnectedUserID);
        console.log(Math.round(+new Date()/1000));
        if (socket.room !== undefined) {
            var date = moment.utc().format('YYYY-MM-DD HH:mm:ss');

            // console.log(date); // 2015-09-13 03:39:27

            var stillUtc = moment.utc(date).toDate();
            var local = moment(stillUtc).utcOffset("+05:30").format('YYYY-MM-DD HH:mm:ss');
            // console.log(local);
            // myUserIDG;
            // friendUserIDG;
            // // console.log("myUserIDG :"+socket.friendID);
            // // console.log("friendUserID :"+socket.userID);
            // // console.log("userName :"+socket.username);
            // storing message in database
            // pool.getConnection(function(err, connection) {
            //     var insertObj = {
            //         userID: socket.userID,
            //         userFriendID: socket.friendID,
            //         groupID: 0,
            //         message: message,
            //         videoID: 0,
            //         messageTypeID: 2,
            //         chatTypeID: 1,
            //         created: local
            //     }
            //     // var query = connection.query('INSERT INTO chats SET ?', insertObj, function (error, results, fields) {
            //     //
            //     //     connection.release();// And done with the connection.
            //     //
            //     //     if (error) throw error; // Handle error after the release.
            //     // });
            //
            //     // here now i will have to do selection , and then insertion or updation on the basis of that selection
            //     selectFromNotification(message);
            // });

            if (chatTypeIDG == 1) {
                console.log("private chat");
                selectFromNotification(message, local);
            }


            if (chatTypeIDG == 2) {
                console.log("group chat");
                selectFromNotificationGroup(message, local);
            }
            lastChatID = lastChatID+1;

            var forwardMessageServerData = {
                message : message,
                profilePic: socket.profilePic,
                userName: socket.username,
                userID: socket.userID,
                dateTime: local,
                messageTypeID: '2',
                chatID: lastChatID,
                videoLink: '',
                thumbnail: '',
                duration: '',

            }
            // console.log(io.sockets.adapter.rooms[socket.room]);
            io.to(socket.room).emit('FORWARD_MESSAGE_SERVER',forwardMessageServerData);
        }

    });

    socket.on('SEND_VIDEO_MESSAGE_CLIENT', function(videoMessageObj) {
        io.to(socket.room).emit('FORWARD_MESSAGE_SERVER',videoMessageObj);
    });

    // function callbackForwardMessageServer(message, local, chatID) {
    //     var forwardMessageServerData = {
    //         message : message,
    //         userName: socket.username,
    //         userID: socket.userID,
    //         dateTime: local,
    //         messageTypeID: '2',
    //         chatID: chatID
    //
    //     }
    //     io.to(socket.room).emit('FORWARD_MESSAGE_SERVER',forwardMessageServerData);
    // }

    function selectFromNotification(message, local) {
        // console.log('service call');
        var options = {
            url: rootUrl+'socketInsertUpdateNotifications',
            headers: {
                'accesstoken': socket.accessToken
            },
            form: {
                userID: socket.userID,
                userFriendID: socket.friendID,
                message: message,
                messageTypeID: 2,
                chatTypeID: 1,
                groupID: socket.room,
                // onlineUsersData: privateChatConnectedUserID,

            },
            json:false

        };
        request.post(options, function(error, response, body){
            // // console.log(body);
            // // console.log("----");
            // // console.log(response);
            // var firstChar = body.substring(0, 1);
            // var firstCharCode = body.charCodeAt(0);
            // if (firstCharCode == 65279) {
            //     // console.log('First character "' + firstChar + '" (character code: ' + firstCharCode + ') is invalid so removing it.');
            //     body = body.substring(1);
            // }

            // firstChar = body.substring(0, 1);
            // firstCharCode = body.charCodeAt(0);
            // if (firstCharCode == 65279) {
            //     // console.log('First character "' + firstChar + '" (character code: ' + firstCharCode + ') is invalid so removing it.');
            //     body = body.substring(1);
            // }

            // var resp = JSON.parse(body);
            // // var resp = response.body;
            // // // console.log(resp);
            // var chatID = resp.chatID;
            // // console.log(chatID);
            // // callbackForwardMessageServer(message, local, chatID)
            // // response.body gives me access to the json data which i have entered
        });

        // pool.getConnection(function(err, connection) {
        //     // var insertObj = {
        //     //     userID: socket.userID,
        //     //     userFriendID: socket.friendID,
        //     //     groupID: 0,
        //     //     message: message,
        //     //     videoID: 0,
        //     //     messageTypeID: 2,
        //     //     chatTypeID: 1,
        //     //     created: local
        //     // }
        //     var query = connection.query("SELECT * FROM notifications WHERE notificationTypeID = ? AND ((userID = ? AND userFriendID = ?) OR (userID = ? AND userFriendID = ?))", ['6',socket.userID, socket.friendID, socket.friendID, socket.userID ], function (error, results, fields) {
        //
        //         connection.release();// And done with the connection.
        //
        //         if (error) throw error; // Handle error after the release.
        //         console.log(results);
        //     });
        // });
        // // insertNotification();
    }

    function selectFromNotificationGroup(message, local) {
        // console.log('service call');
        var options = {
            url: rootUrl+'socketInsertUpdateGroupNotifications',
            headers: {
                'accesstoken': socket.accessToken
            },
            form: {
                userID: socket.userID,
                userFriendID: socket.friendID,
                message: message,
                messageTypeID: 2,
                chatTypeID: 2,

            },
            json:false

        };
        request.post(options, function(error, response, body){
            // // console.log(body);
            // // console.log("----");
            // var firstChar = body.substring(0, 1);
            // var firstCharCode = body.charCodeAt(0);
            // if (firstCharCode == 65279) {
            //     // console.log('First character "' + firstChar + '" (character code: ' + firstCharCode + ') is invalid so removing it.');
            //     body = body.substring(1);
            // }

            // firstChar = body.substring(0, 1);
            // firstCharCode = body.charCodeAt(0);
            // if (firstCharCode == 65279) {
            //     // console.log('First character "' + firstChar + '" (character code: ' + firstCharCode + ') is invalid so removing it.');
            //     body = body.substring(1);
            // }

            // var resp = JSON.parse(body);
            // // var resp = response.body;
            // // // console.log(resp);
            // var chatID = resp.chatID;
            // // console.log(chatID);
            // // callbackForwardMessageServer(message, local, chatID)
            // // response.body gives me access to the json data which i have entered
        });

        // pool.getConnection(function(err, connection) {
        //     // var insertObj = {
        //     //     userID: socket.userID,
        //     //     userFriendID: socket.friendID,
        //     //     groupID: 0,
        //     //     message: message,
        //     //     videoID: 0,
        //     //     messageTypeID: 2,
        //     //     chatTypeID: 1,
        //     //     created: local
        //     // }
        //     var query = connection.query("SELECT * FROM notifications WHERE notificationTypeID = ? AND ((userID = ? AND userFriendID = ?) OR (userID = ? AND userFriendID = ?))", ['6',socket.userID, socket.friendID, socket.friendID, socket.userID ], function (error, results, fields) {
        //
        //         connection.release();// And done with the connection.
        //
        //         if (error) throw error; // Handle error after the release.
        //         console.log(results);
        //     });
        // });
        // // insertNotification();
    }

    function groupUserOnlineOfflineStatus(onlineOfflineStatus) {
        var options = {
            url: rootUrl+'groupUserOnlineOfflineStatus',
            headers: {
                'accesstoken': socket.accessToken
            },
            form: {
                userID: socket.userID,
                groupID: socket.room,
                onlineOfflineStatus: onlineOfflineStatus

            },
            json:false

        };
        request.post(options, function(error, response, body){
            // response is not needed
        });
    }

    function privateUserOnlineOfflineStatus(onlineOfflineStatus) {
        var options = {
            url: rootUrl+'privateUserOnlineOfflineStatus',
            headers: {
                'accesstoken': socket.accessToken
            },
            form: {
                userID: socket.userID,
                groupID: socket.room,
                onlineOfflineStatus: onlineOfflineStatus

            },
            json:false

        };
        request.post(options, function(error, response, body){
            // response is not needed
        });
    }

    socket.on('FRIEND_TYPING',function() {
        if (socket.room !== undefined) {
            // console.log('friend typing');
            socket.broadcast.to(socket.room).emit('FRIEND_TYPING_CLIENT');
        }
    });

    socket.on('disconnect', function(data) {
        console.log('user disconnected'+data);
        if (socket.chatTypeID == 2) {
            //calling api groupUsersOnlineOffline()
            groupUserOnlineOfflineStatus('0');
        }

        // private chat disconnect 
        if (socket.chatTypeID == 1) {
            // privateChatConnectedUserID.splice(privateChatConnectedUserID.indexOf(socket.userID), 1);
            privateUserOnlineOfflineStatus('0')
        }
        
    });
});

http.listen(3000, function() {
    console.log('listening on *:3000');
});
