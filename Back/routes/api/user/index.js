'use strict';
const express = require('express');
const router = express.Router();
const multer = require('../../../middleware/multer');
const User = require("../../../controllers/user");

router.post('/createAc', multer.single('avatar'),async (req, res) =>  User.createAc(req, res));

//router.post('/login', express.json(), async (req,res) => User.login(req, res));

module.exports = router;