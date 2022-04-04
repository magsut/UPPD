'use strict';
const express = require('express');
const router = express.Router();
const User = require("../../../controllers/user");

router.post('/createAc', express.json(),async (req, res) =>  User.createAc(req, res));

router.post('/login', express.json(), async (req,res) => User.login(req, res));

router.post('/newChat', express.json(), async (req, res) => User.newChat(req, res));

module.exports = router;