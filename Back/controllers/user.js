'use strict';

const {insertUser, searchUser, newChat} = require("../utils/mysql");
const {getJWToken} = require('../lib/generateToken');
const sha256 = require('crypto-js/sha256');

class User{
    async createAc(req, res){
        console.log('123');
        try {
            const {pas, name} = req.body;
            if(!pas || !name){
                return res.status(400).end('Sosi');
            }
            let passHash = sha256(pas).toString();
            let jwt = getJWToken(passHash, name);
            await insertUser(passHash, name, jwt, res);
        } catch (e) {
            console.log(e.massage);
            res.status(500).end("We have some problems! " + e.massage);
        }
    }

    async login(req, res){
        try {
            const {pas, name} = req.body;
            let passHash = sha256(pas).toString();
            await searchUser(passHash, name, res);
        } catch (e){
            console.log(e.massage);
            res.status(500).end("We have some problems! " + e.massage);
        }
    }

    async newChat(req, res){
        try {
            const {name, token, chatName} = req.body;
            await newChat(name, token, chatName, res);
        } catch (e){
            console.log(e.massage);
            res.status(500).end("We have some problems! " + e.massage);
        }
    }
}

module.exports = new User();