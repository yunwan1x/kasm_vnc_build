const fs = require('fs').promises;
const fssync = require('fs')

const {del,query,queryAll,update,insert} = require('./sqlite');


async function readTask(task_txt){
  try {
    const data =  await fs.readFile(task_txt, { encoding: 'utf8' });
    return data.split("\n")
  } catch (error) {
    console.error('读取文件发生错误:', error);
  }
}

async function download(url,cookie) {
  response = await fetch(url, {
    "headers": {
      "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
      "accept-language": "zh-CN,zh;q=0.9",
      "cache-control": "no-cache",
      "pragma": "no-cache",
      "sec-ch-ua": "\"Not_A Brand\";v=\"8\", \"Chromium\";v=\"120\", \"Google Chrome\";v=\"120\"",
      "sec-ch-ua-mobile": "?0",
      "sec-ch-ua-platform": "\"macOS\"",
      cookie: cookie,
      "sec-fetch-dest": "document",
      "sec-fetch-mode": "navigate",
      "sec-fetch-site": "none",
      "sec-fetch-user": "?1",
      "upgrade-insecure-requests": "1"
    },
    "referrerPolicy": "strict-origin-when-cross-origin",
    "body": null,
    "method": "GET",
    "mode": "cors",
    "credentials": "include"
  });

  const body = await response.text(); // 如果返回的是JSON，可以使用 response.json()
  const match_txt = body.match(/\/dl\/[0-9]+\/[0-9|a-z]+/)


  if (!match_txt) {
    console.log("没发现url");
    return 0;
  }
  const new_url = match_txt[0]

  response = await fetch(`https://zh.z-library.se${new_url}`, {
    redirect: "manual",
    "headers": {
      "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
      "accept-language": "zh-CN,zh;q=0.9",
      "cache-control": "no-cache",
      "pragma": "no-cache",
      cookie: cookie,
      "sec-ch-ua": "\"Not_A Brand\";v=\"8\", \"Chromium\";v=\"120\", \"Google Chrome\";v=\"120\"",
      "sec-ch-ua-mobile": "?0",
      "sec-ch-ua-platform": "\"macOS\"",
      "sec-fetch-dest": "document",
      "sec-fetch-mode": "navigate",
      "sec-fetch-site": "same-origin",
      "sec-fetch-user": "?1",
      "upgrade-insecure-requests": "1"
    },
    "referrerPolicy": "strict-origin-when-cross-origin",
    "body": null,
    "method": "GET",
    "mode": "cors",
    "credentials": "include"
  });
  const data= await response.text()
  for (const [key, value] of response.headers) {
    if (key == "location") {
      return value
    }
  }
  return null
}
const download_txt = "download.txt"
async function start(task_txt,start_user_index){
  const tasks = await readTask(task_txt);
  var cookies = await queryAll("select cookie,name from user")
  cookie_user = cookies.slice(start_user_index)
  cookies = cookie_user.map(c=>c.cookie)
  users = cookie_user.map(c=>c.name)
  for (cookie_index=0; cookie_index<cookies.length; cookie_index++){
    for(i=0;i<10;i++){
      let task = tasks[cookie_index*10+i]
      let cookie = cookies[cookie_index]
      let user = users[cookie_index]
      if(task&& cookie){
        console.log(`task:${task}, user:${user},cookie:${cookie}`)
        let download_url = await download(task,cookie)
        if(download_url){
          let res = await update("update books set from_url=? where url=?",[download_url,task])
          console.log(`${cookie_index*10+i}: download success ${task} with ${download_url}`)
          await fs.appendFile(download_txt,download_url+"\n")
        }else{
          console.log(`download fail: ${task}`)
        }
       
      }else{
        return 0
      }
    }
  }
  // console.log(tasks)
}


start("/home/kasm-user/Desktop/puppeteer/test.txt",62)