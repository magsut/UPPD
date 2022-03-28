'use strict';

const {APP_NAME} = require('./lib/global');
const express = require('express');
const server = express();
const massage = require('./utils/firebase');
const {initCon} = require('./utils/mysql');


serverInit();

function serverInit(){
    try {
        massage.initServer();
        initCon();
        server.listen(global.UppdApi.SocketPath, () => {
            console.log(`${APP_NAME} listening in ${global.UppdApi.SocketPath}`);
        })
    } catch (err){
        console.log("произошла хуйня");
    }
}

require('./routes/api')(server);