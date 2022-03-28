'use strict';
const API_BASE_URL = '/api/';

const AVAILABLE_ENDPOINTS = [
    'testEndpoint',
    'massages',
    'user'
];

module.exports = server => {
    AVAILABLE_ENDPOINTS.forEach(endpoint => {
        server.use(API_BASE_URL + endpoint, require(`./${endpoint}`));
    })
};