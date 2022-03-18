'use strict';
const API_BASE_URL = '/api/';

const AVAILABLE_ENDPOINTS = [
    'testEndpoint',
    'massages'
];

module.exports = server => {
    AVAILABLE_ENDPOINTS.forEach(endpoint => {
        server.use(API_BASE_URL + endpoint, require(`./${endpoint}`));
    })
};