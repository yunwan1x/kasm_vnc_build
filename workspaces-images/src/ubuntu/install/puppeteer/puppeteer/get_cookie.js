const {del,query,queryAll,update,insert} = require('./sqlite');
async function name(username) {
    var password = "wy3426231987"
    var response = await fetch("https://zh.z-library.se/rpc.php", {
        "headers": {
            "accept": "application/json, text/javascript, */*; q=0.01",
            "accept-language": "zh-CN,zh;q=0.9",
            "cache-control": "no-cache",
            "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
            "pragma": "no-cache",
            "sec-ch-ua": "\"Not_A Brand\";v=\"8\", \"Chromium\";v=\"120\", \"Google Chrome\";v=\"120\"",
            "sec-ch-ua-mobile": "?0",
            "sec-ch-ua-platform": "\"macOS\"",
            "sec-fetch-dest": "empty",
            "sec-fetch-mode": "cors",
            "sec-fetch-site": "same-origin",
            "x-requested-with": "XMLHttpRequest"
        },
        "referrer": "https://zh.z-library.se/",
        "referrerPolicy": "strict-origin-when-cross-origin",
        "body": `isModal=true&email=${username}&password=${password}&site_mode=books&action=login&redirectUrl=https%3A%2F%2Fzh.z-library.se%2F&gg_json_mode=1`,
        "method": "POST",
        "mode": "cors",
        "credentials": "include"
    });


    var userid = "";
    var userkey = ""
    console.log('Headers:');
    for (const [key, value] of response.headers) {
        console.log(`${key}: ${value}`);
        if(value.includes("remix_userkey")){
            userkey=value.match(/(remix_userkey=[a-z|0-9]+;)/)[1]
        }
        if(value.includes("remix_userid")){
            userid = value.match(/(remix_userid=[a-z|0-9]+;)/)[1]
        }
    }
    const cookie =`${userkey} ${userid}`
    const exUser = await query("select name from user where name = ? ",[username])
    var res = ""
    if(exUser){
        await update("update user set cookie=? ,update_time=? where name =? ",[cookie,(new Date()).toString(),username])
        res = ` update ${username} cookie success`; 
    }else{
        await insert("insert into user(name,password,cookie) values(?,?,?)",[username,password,cookie])
        res = ` insert ${username} cookie success`; 

    }
    return res
}

async function start(){
    for(i=72;i<=81;i++){
        var res = await name(`wy${i}@vs2010wy.top`)
    }
}

start()



