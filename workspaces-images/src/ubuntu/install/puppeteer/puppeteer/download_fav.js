// https://zh.z-library.se/papi/booklist/433253/get-books/4?order=date_savedA


const puppeteer = require('puppeteer');
const {del,query,queryAll,update,insert} = require('./sqlite');
async function start() {
  const browser = await puppeteer.connect({ browserURL: 'http://localhost:9222' });
  const page = await browser.newPage()
  await page.goto("https://zh.z-library.se/booklists/favorite",{ waitUntil: 'networkidle2',timeout:0 })
  await page.waitForSelector('.paginator');
  page.on('console', msg => {
    for (let i = 0; i < msg.args().length; ++i)
      console.log(`${i}: ${msg.args()[i]}`);
  });
  const lastLinkText = await page.$$eval('.paginator td span a', links => {
    // Select the last 'a' element
    const lastLink = links[links.length - 1];
    // Return the text content, trimmed of whitespace
    return lastLink ? lastLink.textContent.trim() : null;
  });
  var result=[]
  for(i =1;i<=parseInt(lastLinkText);i++){
    console.log("pagenum:",i)
    await page.goto(`https://zh.z-library.se/booklists/favorite?page=${i}`,{ waitUntil: 'networkidle2',timeout:0 })
    const aHrefs = await page.evaluate(()=>{
      const booklist  = document.querySelectorAll('z-booklist')
      return Array.from(booklist).map(item=>{
        const a = item.shadowRoot.querySelector('.title a')
        const valueStr = a.parentNode.parentNode.querySelector('.info-block[data-tooltip="Book quantity"] span.value').textContent
        console.log(a.textContent,a.href,valueStr)
        return {
          title: a.textContent,
          list_id: a.href.match(/booklist\/(\d+)/)[1],
          nums: valueStr
        }
      })
    })
    result = result.concat(aHrefs)
    for (item of result){
      try {
        const exsitNum = await queryAll("select count(*) as num from fav where list_id=?",[item.list_id])
        if(exsitNum[0].num>0){
          await update("update fav set title=? where list_id=?",[`${item.list_id} ${item.title}`,item.list_id])
        }else{
          await insert("insert into fav(title, list_id,books_num) values(?,?,?)",[`${item.list_id} ${item.title}`,item.list_id,item.nums])
        }
      } catch (error) {
        console.log(error)
      }
    }
  }
  await page.close()
}


start()
