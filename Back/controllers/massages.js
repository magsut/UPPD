'use strict';

class Massage{
    sendMassage(req, res){
        try {
            const {chatId, massage, sender} = req.body;
            let filename = req.file && req.file.filename;
            if(req.file){
                console.log(filename);
            }
            console.log(req.body);
            res.end("while good");
        } catch (e) {
            console.log(e.massage);
            res.status(500).end(e.massage);
        }
    }
}

module.exports = new Massage();