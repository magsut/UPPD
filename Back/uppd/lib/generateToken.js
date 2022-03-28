'use strict';

const jwt = require('jsonwebtoken');
const key = require('../config/constants');

function getJWToken(userPas, userName){
    let data = {
        time : Date(),
        userPas : userPas,
        userName : userName
    };

    return jwt.sign(data, key);
}

exports.getJWToken = getJWToken;
