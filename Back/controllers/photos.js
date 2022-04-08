'use strict';

const path = require('path');

class Photo{
    async getPhoto(req, res){
        let name = req.params.name;
        let imagePath = path.resolve(global.UppdApi.StoragePath);

        res.sendfile(path.join(imagePath, name));
    }
}

module.exports = new Photo();