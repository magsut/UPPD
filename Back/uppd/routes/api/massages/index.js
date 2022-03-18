'use strict';
const express = require('express');
const router = express.Router();
const multer = require('../../../middleware/multer');
const massage = require('../../../controllers/massages');

router.post('/sendMessage',multer.single('photo'), async (req, res) => massage.sendMassage(req, res));

module.exports = router;