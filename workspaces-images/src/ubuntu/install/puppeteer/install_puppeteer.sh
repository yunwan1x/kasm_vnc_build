
wget -c https://nodejs.org/dist/v20.10.0/node-v20.10.0-linux-x64.tar.xz -O node-v20.10.0-linux-x64.tar.xz 
tar -C /usr/local/ -xaf  node-v20.10.0-linux-x64.tar.xz
rm -rf node-v20.10.0-linux-x64.tar.xz
echo "export PATH=/usr/local/node-v20.10.0-linux-x64/bin:$PATH" >> ~/.bashrc
source ~/.bashrc
mkdir -p ~/Desktop/puppeteer
cd ~/Desktop/puppeteer
cp $INST_SCRIPTS/puppeteer/puppeteer/* .
npm install puppeteer 
npm install sqlite3
