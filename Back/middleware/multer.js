const multer = require('multer');
const {getDate} = require('../lib/DateFormat');

const storage = multer.diskStorage({
    destination(req, file, cb){
        cb(null, 'icons/')
    },
    filename(req, file, cb){
        cb(null, getDate() + '-' + file.originalname)
    }
});


module.exports = multer({storage});
