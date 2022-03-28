'use strict'

const { initializeApp } = require( 'firebase/app');
const { getDatabase } = require( "firebase/database");

const firebaseConfig = {
    apiKey: "AIzaSyCtke7fX16Hur0tGs638zJxAtxnt8nDIe0",
    authDomain: "urrd-bf3fb.firebaseapp.com",
    projectId: "urrd-bf3fb",
    storageBucket: "urrd-bf3fb.appspot.com",
    messagingSenderId: "1097775623337",
    appId: "1:1097775623337:web:330c8190d83d11a6b5cdb8",
    measurementId: "G-XMC93J2DDE"
};

let app;

let database;

class Massage{
    initServer(){
        app = initializeApp(firebaseConfig);

        database = getDatabase(app);
    }

}


module.exports = new Massage();



