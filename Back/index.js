'use strict';

const {APP_NAME} = require('./lib/global');
const express = require('express');
const server = express();
const {initCon} = require('./utils/mysql');


serverInit();

function serverInit(){
    try {
        initCon();
        server.listen(global.UppdApi.SocketPath, () => {
            console.log(`${APP_NAME} listening in ${global.UppdApi.SocketPath}`);
        })
    } catch (err){
        console.log("произошла хуйня");
    }
}

require('./routes/api')(server);