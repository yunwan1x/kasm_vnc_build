
//每个周一打开
// 本地chrome执行文件路径
const puppeteer = require('puppeteer');

//复制"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --remote-debugging-port=9222
// /Users/changhui.wy/.cache/puppeteer/chrome/mac_arm-119.0.6045.105/chrome-mac-arm64/Google Chrome for Testing.app  --remote-debugging-port=9222


async function getAjax(page, url) {
  //   endpoint = `https://zh.z-library.se/booklists/favorite?page=${pagenum}`
  const result = await page.evaluate(async (url) => {
    try {
      const response = await fetch(url, {
        method: 'GET', // 如果需要，这里可以设置请求方法，头部信息等
        headers: {
          // 设置请求头，如有必要
          'Content-Type': 'application/json'
        }
      });
      if (!response.ok) {
        throw new Error('Network response was not ok ' + response.statusText);
      }
      return response.json(); // 将响应解析为 JSON
    } catch (error) {
      return { error: error.message };
    }
  }, url);
  return result
}

function getTime() {
  const date = new Date();
  const year = date.getFullYear();
  const month = (date.getMonth() + 1).toString().padStart(2, '0'); // 月份是从0开始的
  const day = date.getDate().toString().padStart(2, '0');
  const hours = date.getHours().toString().padStart(2, '0');
  const minutes = date.getMinutes().toString().padStart(2, '0');
  const seconds = date.getSeconds().toString().padStart(2, '0');
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}


module.exports = { getAjax,getTime }


