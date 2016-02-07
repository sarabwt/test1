 var 
        gameport        = process.env.PORT || 4004,
		
        io              = require('socket.io'),
        express         = require('express'),
        UUID            = require('node-uuid'),
		http			= require('http'),
        verbose         = false,
        app             = express(),
		server			= http.createServer(app);
		

/* Express server set up. */

//The express server handles passing our content to the browser,
//As well as routing users where they need to go. This example is bare bones
//and will serve any file the user requests from the root of your web server (where you launch the script from)
//so keep this in mind - this is not a production script but a development teaching tool.

        //Tell the server to listen for incoming connections
    server.listen( gameport );

        //Log something so we know that it succeeded.
    console.log('\t :: Express :: Listening on port ' + gameport );

        //By default, we forward the / path to index.html automatically.
    app.get( '/', function( req, res ){ 
        res.sendfile( __dirname + '/simplest.html' );
    });


        //This handler will listen for requests on /*, any file from the root of our server.
        //See expressjs documentation for more info on routing.

    app.get( '/*' , function( req, res, next ) {

            //This is the current file they have requested
        var file = req.params[0]; 

            //For debugging, we can track what files are requested.
        if(verbose) console.log('\t :: Express :: file requested : ' + file);

            //Send the requesting client the file.
        res.sendfile( __dirname + '/' + file );

    }); //app.get *
	
	 var sio = io.listen(server);

        //Configure the socket.io connection settings. 
        //See http://socket.io/
    sio.configure(function (){

        sio.set('log level', 0);

        sio.set('authorization', function (handshakeData, callback) {
          callback(null, true); // error first callback style 
        });

    });

        //Socket.io will call this function when a client connects, 
        //So we can send that client a unique ID we use so we can 
        //maintain the list of players.
    sio.sockets.on('connection', function (client) {
        
            //Generate a new UUID, looks something like 
            //5b2ca132-64bd-4513-99da-90e838ca47d1
            //and store this on their socket/connection
        client.userid = UUID();

            //tell the player they connected, giving them their id
        client.emit('onconnected', { id: client.userid } );

            //Useful to know when someone connects
        console.log('\t socket.io:: player ' + client.userid + ' connected');
        
            //When this client disconnects
        client.on('disconnect', function () {

                //Useful to know when someone disconnects
            console.log('\t socket.io:: client disconnected ' + client.userid );

        }); //client.on disconnect
     
    }); //sio.sockets.on connection

<!DOCTYPE html>
<html>
	<head>
		<title> Real time multi-player games with HTML5</title>
		<style type="text/css">
			html , body {
				background: #212121; 
				color: #fff; 
				margin: 0; 
				padding: 0;
			}
			#canvas {
				position: absolute;
				left: 0; right: 0; top: 0; bottom: 0; 
				margin: auto;
			}
		</style>
	 	
		 	<!-- Notice the URL, this is handled by socket.io on the server automatically, via express -->
		<script type="text/javascript" src="/socket.io/socket.io.js"></script>
		
			<!-- This will create a connection to socket.io, and print the user serverid that we sent from the server side. --> 
		<script type="text/javascript">
				//This is all that needs
			var socket = io.connect('/');
				//Now we can listen for that event
			socket.on('onconnected', function( data ) {
					//Note that the data is the object we sent from the server, as is. So we can assume its id exists. 
		  		console.log( 'Connected successfully to the socket.io server. My server side ID is ' + data.id );
		  	});
		</script>

	</head>

	<body>
		<canvas id="canvas"> </canvas>	
	</body>
</html>
