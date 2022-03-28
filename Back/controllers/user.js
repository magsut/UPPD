'use strict';

const {insertUser} = require("../utils/mysql");
const {getJWToken} = require('../lib/generateToken');

class User{
    async createAc(req, res){
        try {
            let jwt = getJWToken(req.body.pas, req.body.name);
            await insertUser(req.body.pas, req.body.name, jwt, res);
        } catch (e) {
            console.log(e.massage);
            res.status(500).end("We have some problems! " + e.massage);
        }
    }
}

module.exports = new User();