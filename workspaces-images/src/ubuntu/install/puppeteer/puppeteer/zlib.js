
//每个周一打开
// 本地chrome执行文件路径
const puppeteer = require('puppeteer');

//复制"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --remote-debugging-port=9222
// /Users/changhui.wy/.cache/puppeteer/chrome/mac_arm-119.0.6045.105/chrome-mac-arm64/Google Chrome for Testing.app  --remote-debugging-port=9222

function find(items){
    if(!items) return null
    item = items[0]
    for (item of items){
        if(item.suffix=="pdf"){
            return item
        }else if(item.suffix=="epub"){
            return item
        }else if(item.suffix=="mobi"){
            return item
        }else if(item.suffix=="azw3"){
            return item
        }else{
            return null
        }
    }
}
async function getDownloadUrlFromBookPage(page , url){
    if(!url)return null
    await page.goto(url,{ waitUntil: 'networkidle2'});
    const downloadlinks = await page.$$eval('a.addDownloadedBook[data-book_id]', elements => {
        return elements.filter(element => {
            suffix =  element.textContent.toLowerCase().trim();
            return suffix.includes('epub')|| suffix.includes("pdf")||suffix.includes("mobi")||suffix.includes("azw3");
        }).map(element =>{
            suffix =  element.textContent.toLowerCase().trim();
            if(suffix.includes("pdf")){
                suffix = "pdf"
            }else if(suffix.includes("epub")){
                suffix = "epub"
            }else if(suffix.includes("mobi")){
                suffix = "mobi"
            }else if(suffix.includes("azw3")){
                suffix = "azw3"
            }else{
                suffix = 'unknown'
            }
            return { "suffix" :suffix,"downloadlink":element.href}
        } ); 
    });
    const text = await page.$eval('h1', element => element.textContent.toLowerCase().trim());
    
    ret = Array.from(downloadlinks).map(downloadlink=> {return {
        "suffix": downloadlink.suffix,
        "downloadlink": downloadlink.downloadlink,
        "title": text
    }});

    return find(ret)
}

async function start() {
    // const browser = await puppeteer.launch({
    //     defaultViewport: null,
    //     ignoreDefaultArgs: ["--enable-automation"],
    //     args: [
    //         '--disable-web-security',
    //         '--start-maximized'
    //     ],
    //     // devtools: true,
    //     ignoreHTTPSErrors: true,
    //     userDataDir: '/Users/changhui.wy/chrome_dir',
    //     headless: false, // 表示是否在前台显示浏览器窗口，默认为true表示不显示，在后台操作
    // });
    const browser = await puppeteer.connect({ browserURL: 'http://localhost:9222'});
    const pages = await browser.pages();
    var page  =  pages[0]
    // 自适应视窗大小
    await page.setViewport({width:0,height:0});
    await page.goto('https://zh.z-library.se/');
    var bookbutton = "a.book-loading"
    await page.waitForSelector(bookbutton, { timeout: 0 });
    const urls = await page.$$eval('a.book-loading', links => {
        return links.map(link => link.href);
    });
    await page.exposeFunction('myNodeFunction', async (arg1) => {
        // 会在nodejs console打印浏览器里的信息。
        // console.log(arg1)
      });
    for (const url of urls){
        var info = await getDownloadUrlFromBookPage(url)
        console.log(info)
    }
 
    

    
}
module.exports ={ getDownloadUrlFromBookPage }
// start()


