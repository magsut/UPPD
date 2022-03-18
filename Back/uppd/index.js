'use strict';

const {APP_NAME} = require('./lib/global');
const express = require('express');
const server = express();
const massage = require('./utils/firebase');


serverInit();

function serverInit(){
    massage.initServer();
    server.listen(global.UppdApi.SocketPath, () => {
        console.log(`${APP_NAME} listening in ${global.UppdApi.SocketPath}`);
    })
}

require('./routes/api')(server);