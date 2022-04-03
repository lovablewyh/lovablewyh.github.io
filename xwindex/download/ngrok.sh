#/bin/bash
echo "[+] INFO : NGROK SERVER !"
echo "[+] INFO : WGET GO CODE !"
wget https://dl.google.com/go/go1.13.linux-amd64.tar.gz
echo "[+] INFO : TAR GO CODE !"
tar -C /usr/local -xzf go1.13.linux-amd64.tar.gz
echo "[+] INFO : SET PATH !"
export PATH=$PATH:/usr/local/go/bin
source  ~/.profile
echo "[+] INFO : GO VERSION !"
go version
echo "[+] INFO : APT-GET INSTALL MAKE !"
apt-get install make
echo "[+] INFO : APT-GET INSTALL GIT !"
apt-get install git
echo "[+] INFO : DOWNLOAD NGROK SERVER CODE !"
git clone https://github.com/inconshreveable/ngrok.git
echo "[+] INFO : INPUT NGROK DOAMIN :"
read NGROK_DOMAIN
openssl genrsa -out ~/ngrok/base.key 2048
openssl req -new -x509 -nodes -key ~/ngrok/base.key -days 10000 -subj "/CN=$NGROK_DOMAIN" -out ~/ngrok/base.pem
openssl genrsa -out ~/ngrok/server.key 2048
openssl req -new -key ~/ngrok/server.key -subj "/CN=$NGROK_DOMAIN" -out ~/ngrok/server.csr
openssl x509 -req -in ~/ngrok/server.csr -CA ~/ngrok/base.pem -CAkey ~/ngrok/base.key -CAcreateserial -days 10000 -out ~/ngrok/server.crt
cp ~/ngrok/base.pem ~/ngrok/assets/client/tls/ngrokroot.crt
cd ~/ngrok/
make release-server
