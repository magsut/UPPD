'use strict';

const {APP_NAME} = require('./lib/global');
const express = require('express');
const server = express();
const massage = require('./utils/firebase');
const {initCon} = require('./utils/mysql');


serverInit();

function serverInit(){
    try {
        console.log('ага');
        massage.initServer();
        console.log('ага');
        initCon();
        console.log('ага');
        server.listen(global.UppdApi.SocketPath, () => {
            console.log(`${APP_NAME} listening in ${global.UppdApi.SocketPath}`);
        })
        console.log('ага');
    } catch (err){
        console.log("произошла хуйня");
    }
}

require('./routes/api')(server);