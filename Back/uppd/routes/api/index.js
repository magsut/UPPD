'use strict';
const API_BASE_URL = '/api/';

const AVAILABLE_ENDPOINTS = [
    'testEndpoint'
];

module.exports = server => {
    AVAILABLE_ENDPOINTS.forEach(endpoint => {
        /*server.use((request, response, next) => {
            response.haeder("Access-Control-Allow-Origin", "*");
            response.haeder("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
            next();
        });*/
        server.use(API_BASE_URL + endpoint, require(`./${endpoint}`));
    })
};