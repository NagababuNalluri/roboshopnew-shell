script_location=$(pwd)
echo -e '\e[32m Configuring nodejs \e[0m'
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e '\e[32m Install Node JS\e[0m'
yum install nodejs -y
echo -e '\e[32m Add roboshop user\e[0m'
useradd roboshop
echo -e '\e[32m Creating app directory\e[0m'
mkdir -p /app

echo -e '\e[32m Download Catalogue content\e[0m'
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
echo -e '\e[32m Remove default content in app directory\e[0m'
rm -rf /app/*

cd /app

unzip /tmp/catalogue.zip

echo -e '\e[32m NPM install\e[0m'
npm install
echo -e '\e[32m Copy catalogue service\e[0m'
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service
echo -e '\e[32m Load catalogue service\e[0m'
systemctl daemon-reload
echo -e '\e[32m Enable Catalogue\e[0m'
systemctl enable catalogue
echo -e '\e[32m Start Catalogue\e[0m'
systemctl start catalogue
echo -e '\e[32m Coping Mongodb Repo\e[0m'
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo
echo -e '\e[32m Install Mongodb\e[0m'
yum install mongodb-org-shell -y
echo -e '\e[32m Load Schema\e[0m'
mongo --host mongodb-dev.devopshemasri.online </app/schema/catalogue.js


