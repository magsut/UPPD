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
            return res.status(400).end("User is not found");
        }
        console.log(result[0].iduser);
        res.status(200).end(getJWToken(userPas, userName));
    })
}

async function newChat(userName, token, chatName, res){
    let query = `SELECT iduser FROM uppd.user where user.UserName = '${userName}';`;
    connection.query(query, (err, result) => {
        if(err){
            console.log(err);
            return res.status(500).end(err.toString());
        }
        if(!result.length){
            return res.status(400).end("User is not found");
        }
        var findId = result[0].iduser;
        console.log(findId);
        query = `SELECT iduser FROM uppd.user where user.token = '${token}';`;
        connection.query(query, (err, result) => {
            if(err){
                console.log(err);
                return res.status(500).end('Что-то пошло не так, токен не действителен');
            }
            if(!result.length){
                return res.status(400).end("Что-то пошло не так, токен не действителен");
            }
            var userId = result[0].iduser;
            console.log(userId);
            query = `insert into uppd.chat (chatName) values ('${chatName}');`;
            connection.query(query, (err, result) => {
                if(err){
                    console.log(err);
                    return res.status(500).end('Что-то пошло не так');
                }
                var chatId = result.insertId;
                console.log(chatId);
                if (!chatId){
                    return res.status(500).end('Unexpected error');
                }
                query = `INSERT INTO uppd.user_has_chat (User_idUser, Chat_idChat) VALUES ('${findId}', '${chatId}');` +
                    `INSERT INTO uppd.user_has_chat (User_idUser, Chat_idChat) VALUES ('${userId}', '${chatId}');`
                connection.query(query, (err, result) => {
                    if(err){
                        console.log(err);
                        return res.status(500).end(err.toString());
                    }
                });
                // addChatToUser(findId, chatId);
                // addChatToUser(userId, chatId);
            });
        });
    })
}

async function addChatToUser(userId, chatId){
    let query = `INSERT INTO uppd.user_has_chat (User_idUser, Chat_idChat) VALUES ('${userId}', '${chatId}');`;
}

exports.searchUser = searchUser;

exports.newChat = newChat;

exports.initCon = initCon;

exports.insertUser = insertUser;
