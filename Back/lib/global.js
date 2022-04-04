'use strict';

const {
    name: APP_NAME,
    version: APP_VERSION
} = require('../package.json');

const{
    SocketPath: Socket_Path,
    StoragePath: Storage_Path
} = require('../config.json');

if(!global.hasOwnProperty('UppdApi')){
    global.UppdApi = Object.freeze({
        SocketPath: Socket_Path,
        name: APP_NAME,
        Route: APP_NAME,
        StoragePath: Storage_Path
    });
}

module.exports = Object.freeze({
    APP_NAME,
    APP_VERSION,
    Storage_Path
});