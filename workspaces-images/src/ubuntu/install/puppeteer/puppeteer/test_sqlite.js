var createTable = `CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    url TEXT NOT NULL,
    ext TEXT NOT NULL
);`

var createIndex =`
CREATE UNIQUE INDEX idx_book
on books (ext,title);
`

var SqliteDB = require('./sqlite.js').SqliteDB;
var file = "books.db";
var sqliteDB = new SqliteDB(file);
let getFn = function () {
    //查
    var querySql = `select * from books `;
    sqliteDB.queryData(querySql, (code, res) => {
        if (code == 200) {
            console.log(res);
        }
    });
}

tableName = 'books'
var tileData = [['计算机技术', 'https://www.baid.com',"pdf"]];//这里是数组可以批量增,key可重复
var insertTileSql = `insert into ${tableName}(title,url,ext) values(?, ?,?)`;
sqliteDB.insertData(insertTileSql, tileData);
getFn()
sqliteDB.close()


/**
 * File: callSqlite.js.
 * 对 文件数据库-sqlite3封装后的调用
 * 
 * 22-10-12 KUN
 * 
 */

//创建连接
var SqliteDB = require('./sqlite.js').SqliteDB;
var file = "thenKeys.db";
var sqliteDB = new SqliteDB(file);

//创建数据库:如果没有则创建
let tableName = 'tiles'//表名
let keys = [//表内字段  ---字段名 存储类型---
    "key VARCHER",//VARCHER-字符
    "value VARCHER",
]
let strKeys = keys.join(',')//转换为可用字符串
var createTableSql = `create table if not exists ${tableName}(${strKeys});`;
sqliteDB.createTable(createTableSql);

let getFn = function () {
    //查
    var querySql = `select * from ${tableName} where key = 'A1001'`;
    sqliteDB.queryData(querySql, (code, res) => {
        if (code == 200) {
            console.log(res);
        }
    });
}

//增
var tileData = [['A1001', '123456']];//这里是数组可以批量增,key可重复
var insertTileSql = `insert into ${tableName}(key,value) values(?, ?)`;
sqliteDB.insertData(insertTileSql, tileData);

getFn()//查一下看看

//改
var updateSql = `update ${tableName} set value = '789' where key = 'A1001'`;
sqliteDB.upData(updateSql, (code) => {
    console.log(code);
});

//删
var delSql = `delete from ${tableName} where key = 'A1001'`;
sqliteDB.delData(delSql, (code) => {
    console.log(code);
});

getFn()//查一下看看  因为是异步,所有多次查的顺序不确定

//关闭连接
sqliteDB.close();
