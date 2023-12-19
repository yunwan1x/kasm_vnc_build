// https://zh.z-library.se/papi/booklist/433253/get-books/4?order=date_savedA


const puppeteer = require('puppeteer');
const {del,query,queryAll,update,insert} = require('./sqlite');
const {getAjax} = require('./zlib')
const fs = require('fs');
const { mainModule } = require('process');


async function get_obj(booksid, page) {
  var endpoint = `https://zh.z-library.se/papi/booklist/${booksid}/get-books/1?order=date_savedA`
  let { pagination, books } = await getAjax(page, endpoint)
  console.log(pagination)
  const toobj = (books) => books.filter(item=>item.book.dl).map(item => { return { suffix: item.book.extension, downloadlink: "https://zh.z-library.se" + item.book.dl, title: item.book.title } })
  donwloads = toobj(books)
  if (pagination && pagination.total_pages > 1) {
    for (let i = 2; i <= pagination.total_pages; i++) {
      endpoint = `https://zh.z-library.se/papi/booklist/${booksid}/get-books/${i}?order=date_savedA`
      let { books } = await getAjax(page, endpoint)
      await page.waitForTimeout(1000);
      donwloads = donwloads.concat(toobj(books))
    }
  }
  return donwloads
}

function saveUrl(arrayOfObjects, className) {
  // const arrayOfObjects = [{ url: 'http://example.com' }, { url: 'http://example2.com' }];
  const dataToWrite = arrayOfObjects.map(obj => obj).join('\n');
  fs.writeFileSync(`books/${className}.txt`, dataToWrite);
  console.log('URLs have been written to the file.');
}

const getFormattedDate = () => {
  const date = new Date();

  const year = date.getFullYear();
  
  // getMonth() 返回的月份是从0开始的，所以需要+1
  // padStart(2, '0') 确保月份是两位数的字符串
  const month = (date.getMonth() + 1).toString().padStart(2, '0');
  
  // getDate() 返回当前的天数，同样使用padStart确保两位数
  const day = date.getDate().toString().padStart(2, '0');

  // 组合字符串
  return `${year}${month}${day}`;
};

async function start(book_text) {
  // var arguments = process.argv;
  // if(arguments.length != 3){
  //   console.error(`参数数量错误,使用方式 node download_book.js "198346 AT-计算机"`)
  //   return 0
  // }
  arg =  book_text.match(/^(\d+)(.+)/)
  booksid = arg[1]
  className = book_text
  if(!booksid){
    console.error(`未获取到书单id: booksid。使用方式node download_book.js "198346 AT-计算机"`)
    return 0
  }
  console.log(booksid,className)
  const browser = await puppeteer.connect({ browserURL: 'http://localhost:9222' });
  const pages = await browser.pages()
  const page  = pages[0]
  downloadlinks = await get_obj(booksid, page)

  const save_urls=[]
  for (book of downloadlinks) {
    try {
      await insert(`insert into books (title,url,ext,date,from_url) values(?, ?,?,?,?)`,[book.title, book.downloadlink, book.suffix, className, ""])
      save_urls.push(book.downloadlink)
    } catch (error) {
      
    }
  }
  saveUrl(save_urls,className)
  await update("update fav set downloaded=?,date=? where list_id=?",[save_urls.length,getFormattedDate(),booksid])
}


// start()
async function main(){
  books = await  queryAll("select * from fav where date is null")
  const classNames = books.map(book=>book.title)
  for(className of classNames){
    result = await start(className)
  }

}
main()
