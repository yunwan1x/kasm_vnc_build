/**
 * File: sqlite.js
 * 对 文件数据库-sqlite3 的封装
 * 
 * 22-10-12 KUN
 * 
 * 回调参数统一{code,res} code:状态码 500/200 热水:如果有需要返回的内容则在二参
 */

var fs = require('fs');
var sqlite3 = require('sqlite3').verbose();
var DB = DB || {};

DB.SqliteDB = function (file) {
    DB.db = new sqlite3.Database(file);
    DB.exist = fs.existsSync(file);
    if (!DB.exist) {
        fs.openSync(file, 'w');
    };
};

DB.printErrorInfo = function (err, callback = () => { }) {
    callback(500)
    console.log("Error Message:" + err.message);
};

//创建数据表
DB.SqliteDB.prototype.createTable = function (sql) {
    DB.db.serialize(function () {
        DB.db.run(sql, function (err) {
            if (null != err) {
                DB.printErrorInfo(err);
                return;
            }
        });
    });
};

//新增
DB.SqliteDB.prototype.insertData = function (sql, objects) {
    DB.db.serialize(function () {
        var stmt = DB.db.prepare(sql);
        for (var i = 0; i < objects.length; ++i) {
            stmt.run(objects[i]);
        }
        stmt.finalize();
    });
};

//查询
DB.SqliteDB.prototype.queryData = function (sql, callback = () => { }) {
    DB.db.all(sql, function (err, rows) {
        if (null != err) {
            DB.printErrorInfo(err, callback);
            return;
        }
        if (callback) {
            callback(200, rows);
        }
    });
};

//修改 "update 表名 set 修改项 where 条件"
DB.SqliteDB.prototype.upData = function (sql, callback = () => { }) {
    DB.db.run(sql, function (err) {
        if (null != err) {
            DB.printErrorInfo(err, callback);
            return
        }
        callback(200);
    });
};

//删除 "delete from 表名 where 条件"
DB.SqliteDB.prototype.delData = function (sql, callback = () => { }) {
    DB.db.run(sql, function (err) {
        if (null != err) {
            DB.printErrorInfo(err, callback);
            return
        }
        callback(200);
    });
};

//其他sql    与删改相同-只是便于区分
DB.SqliteDB.prototype.onSql = function (sql, callback = () => { }) {
    DB.db.run(sql, function (err) {
        if (null != err) {
            DB.printErrorInfo(err, callback);
            return
        }
        callback(200);
    });
};

//关闭连接
DB.SqliteDB.prototype.close = function () {
    DB.db.close();
};

exports.SqliteDB = DB.SqliteDB;
