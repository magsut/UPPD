const fs = require('fs');
const path = require('path');

async function copyFile(filename, newname) {
    if (filename === newname) throw new Error('FileStorage: New name should be different from original name');

    let tmplPath = path.resolve(global.UppdApi.StoragePath);

    filename = path.join(tmplPath, filename);
    newname = path.join(tmplPath, newname);

    fs.copyFile(filename, newname, err => {
        if(err) throw err; // не удалось скопировать файл
        console.log('Файл успешно скопирован');
    });
}

async function deleteFile(filename){
    fs.unlink(path.join(path.resolve(global.UppdApi.StoragePath), filename), err => {
        if(err) throw err;// не удалось удалить файл
        console.log('Файл успешно удалён');
    });
}

module.exports = {copyFile, deleteFile};
