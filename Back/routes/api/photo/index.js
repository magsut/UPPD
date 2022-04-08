'use strict';
const express = require('express');
const router = express.Router();
const Photos = require("../../../controllers/photos");


router.get('/:name', async (req, res) => Photos.getPhoto(req, res));

module.exports = router;