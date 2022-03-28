'use strict';

const mysql = require('mysql');

const connection = mysql.createConnection({
    host: "127.0.0.1",
    port: "3306",
    user: "root",
    database: "uppd",
    password: "1234"
})

function initCon(){
    connection.connect( err => {
        if(err) {
            console.log(err);
            throw err;
        }
        else console.log("Connection - ok");
    })
}

function insertUser(userPas, userName, userToken){
    let id;
    let query = `insert into uppd.user (token, UserName, Password) values ('${userToken}', '${userName}', '${userPas}');`;
    connection.query(query, (err, result) => {
        if(err){
            throw err;
        }
        console.log(result.insertId);
        id = result.insertId;
    })
    return id;
}

exports.initCon = initCon;

exports.insertUser = insertUser;
