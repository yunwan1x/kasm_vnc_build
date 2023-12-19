var createTable = `CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    url TEXT NOT NULL,
    ext TEXT NOT NULL
);`

var fs = require('fs');
var sqlite3 = require('sqlite3').verbose();
var DB = DB || {};
var SqliteDB = function (file) {
    DB.db = new sqlite3.Database(file);
    DB.exist = fs.existsSync(file);
    if (!DB.exist) {
        fs.openSync(file, 'w');
    };
};

var file = "books.db";
new SqliteDB(file);


// tableName = 'books'
// var params = [['计算机技术', 'https://www.baid.com',"pdf"]];//这里是数组可以批量增,key可重复
function insert(sql,params){
    return new Promise((resolve, reject)=>{
        DB.db.run(sql, params, function (err) {
            if (err) {
                reject(err)
            }
            console.log("insert data:",this)
            resolve(1)
        })
    })
}



function update(sql,params){
    return new Promise((resolve, reject)=>{
        DB.db.run(sql, params, function(err){
            if (err) {
                reject(err)
            }
            resolve(1)
          });
    })
}



function queryAll(sql,params){
    return new Promise((resolve, reject)=>{
        DB.db.all(sql, params, function (err,rows) {
            if (err) {
                reject(err)
            }
            resolve(rows)
        })
    })
}

function query(sql,params){
    return new Promise((resolve, reject)=>{
        DB.db.get(sql, params, function (err,row) {
            if (err) {
                reject(err)
            }
            resolve(row)
        })
    })
}

function del(sql,params){
    return new Promise((resolve, reject)=>{
        DB.db.run(sql, params, function (err,row) {
            if (err) {
                reject(err)
            }
            resolve(row)
        })
    })
}

module.exports={del,query,queryAll,update,insert}