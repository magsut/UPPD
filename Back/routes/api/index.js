'use strict';
const {response} = require("express");
const API_BASE_URL = '/api/';

const AVAILABLE_ENDPOINTS = [
    'testEndpoint',
    'photo',
    'user'
];

module.exports = server => {
    AVAILABLE_ENDPOINTS.forEach(endpoint => {
        server.use((request, response, next) => {
            response.header('Access-Control-Allow-Origin', "*");
            response.header('Access-Control-Allow-Origin', "Origin, X-Requested-With, Content-Type, Accept");

            next();
        });

        server.use(API_BASE_URL + endpoint, require(`./${endpoint}`));
    })
};