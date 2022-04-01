'use strict';

const mysql = require('mysql');
const {getJWToken} = require('../lib/generateToken');

const connection = mysql.createConnection({
    host: "127.0.0.1",
    port: "3306",
    user: "root",
    database: "uppd",
    password: "1234"
})

async function initCon(){
    connection.connect( err => {
        if(err) {
            console.log(err);
            throw new Error(err);
        }
        else console.log("Connection - ok");
    })
}

async function insertUser(userPas, userName, userToken, res){
    let query = `insert into uppd.user (token, UserName, Password) values ('${userToken}', '${userName}', '${userPas}');`;
    connection.query(query, (err, result) => {
        if(err){
            console.log(err);
            res.status(500).end(err.toString());
        }
        res.end(userToken);
    });
}

async function searchUser(userPas, userName, res){
    let query = `SELECT iduser FROM uppd.user where user.UserName = '${userName}' and user.Password = '${userPas}';`;
    connection.query(query, (err, result) => {
        if(err){
            console.log(err);
            return res.status(500).end(err.toString());
        }
        if(!result.length){
            return res.status(400).end("User is not foundUser is not found");
        }
        console.log(result[0].iduser);
        res.status(200).end(getJWToken(userPas, userName));
    })
}

exports.searchUser = searchUser;

exports.initCon = initCon;

exports.insertUser = insertUser;
