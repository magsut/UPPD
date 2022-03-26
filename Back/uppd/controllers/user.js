'use strict';

class User{
    async createAc(req, res){
        console.log(req.body);
        res.end('while good');
    }
}

module.exports = new User();