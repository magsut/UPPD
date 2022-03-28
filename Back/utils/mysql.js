'use strict';

const mysql = require('mysql');

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

exports.initCon = initCon;

exports.insertUser = insertUser;
