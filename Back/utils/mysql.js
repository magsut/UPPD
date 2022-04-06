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

async function insertUser(passHash, login, name, age, token, filename, res){
    let query = `insert into uppd.user (token, UserName, Password, UserLogin, Age, Icon) values ('${token}', '${name}', '${passHash}', '${login}', '${age}', '${filename}');`;
    connection.query(query, (err, result) => {
        if(err){
            console.log(err);
            res.status(500).end(err.toString());
        }
        res.end(filename);
    });
}

async function searchUser(userPas, UserLogin, res){
    let query = `SELECT iduser FROM uppd.user where user.UserLogin = '${UserLogin}' and user.Password = '${userPas}';`;
    connection.query(query, (err, result) => {
        if(err){
            console.log(err);
            return res.status(500).end(err.toString());
        }
        if(!result.length){
            return res.status(400).end("User is not found");
        }
        const id = result[0].iduser;
        connection.query(query, (err, result) => {
            if(err){
                console.log(err);
                return res.status(500).end("UUUUUPS: " + err.toString());
            }
            query = `SELECT UserName,UserLogin,Age,Icon FROM uppd.user where user.idUser = '${id}';`;
            connection.query(query, (err, result) => {
                if(err){
                    console.log(err);
                    return res.status(500).end("UUUUUPS: " + err.toString());
                }
                res.status(200).end(JSON.stringify({
                    UserName: result[0].UserName,
                    UserLogin: result[0].UserLogin,
                    Age: result[0].Age,
                    Icon: result[0].Icon,
                }))
            })
        })
    })
}

exports.searchUser = searchUser;

exports.initCon = initCon;

exports.insertUser = insertUser;
