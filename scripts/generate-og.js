const puppeteer = require('puppeteer');
const path = require('path');
const fs = require('fs');

(async () => {
  const browser = await puppeteer.launch({ args: ['--no-sandbox'] });
  const page = await browser.newPage();
  await page.setViewport({ width: 1200, height: 630 });
  const htmlPath = path.resolve(__dirname, '../src/main/webapp/static/images/og-template.html');
  await page.goto('file://' + htmlPath, { waitUntil: 'networkidle0' });
  await new Promise(r => setTimeout(r, 800));
  const outPath = path.resolve(__dirname, '../src/main/webapp/static/images/og-image.png');
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  await page.screenshot({ path: outPath, clip: { x:0, y:0, width:1200, height:630 } });
  await browser.close();
  console.log('✅ og-image.png 생성 완료!');
})();
