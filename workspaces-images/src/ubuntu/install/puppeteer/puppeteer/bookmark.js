
const puppeteer = require('puppeteer');
zlib  = require('./zlib')


async function start() {

    const browser = await puppeteer.connect({ browserURL: 'http://localhost:9222'});
    const pages = await browser.pages();
    var page  =  pages[0];
    const urls = await page.$$eval('h4 a', links => {
        return links.map(link => link.href);
    });
    url = await zlib.getDownloadUrlFromBookPage(page,urls[0])
    console.log(url)
}

start()