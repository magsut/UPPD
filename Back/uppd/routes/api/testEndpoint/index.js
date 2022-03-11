'use strict';
const express = require('express');
const router = express.Router();

router.get('/123', (req, res) => _testServer(req, res));

function _testServer(req, res){
    console.log('Server working! Routes is connected');
    res.end('GOOD');
}

module.exports = router;