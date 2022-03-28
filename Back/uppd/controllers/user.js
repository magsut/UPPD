'use strict';

const {insertUser} = require("../utils/mysql");
const {getJWToken} = require('../lib/generateToken');
const bcrypt = require('bcrypt');

class User{
    async createAc(req, res){

        const salt = await bcrypt.genSalt(10);
        const password = await bcrypt.hash(req.body.pas, salt);

        let jwt = getJWToken(req.body.pas, req.body.name);
        let id = insertUser(password, req.body.name, jwt);
        if (id){
            res.end(jwt);
        } else {
            res.status(500).end("We have some problems");
        }
    }
}

module.exports = new User();