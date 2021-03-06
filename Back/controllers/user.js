'use strict';

const {insertUser, searchUser} = require("../utils/mysql");
const sha256 = require('crypto-js/sha256');
const {getDate} = require('../lib/DateFormat');
const {copyFile, renameFile} = require('../lib/filestorage');

class User{
    async createAc(req, res){
        try {
            let {pas, login, name, age, token, fileName} = req.body;
            if(!pas || !name || !age || !token || !login){
                return res.status(400).end('Sosi');
            }

            fileName.split(' ').join('-');
            const passHash = sha256(pas).toString();
            let filename = req.file && req.file.filename;
            if(!filename){
                fileName = getDate() + '-' + 'standard.png';
                await copyFile('standart.png', fileName);
            } else{
                await renameFile(filename, fileName);
            }
            await insertUser(passHash, login, name, age, token, fileName, res);
        } catch (e) {
            console.log(e);
            res.status(500).end("We have some problems! " + e.massage);
        }
    }

    async login(req, res){
        try {
            const {pas, login} = req.body;
            let passHash = sha256(pas).toString();
            await searchUser(passHash, login, res);
        } catch (e){
            console.log(e.massage);
            res.status(500).end("We have some problems! " + e.massage);
        }
    }


}

module.exports = new User();