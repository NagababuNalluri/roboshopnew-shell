script_location=$(pwd)
log=/tmp/roboshop.logs
echo -e '\e[32m Configuring nodejs \e[0m'
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log
check_status
echo -e '\e[32m Install Node JS\e[0m'
yum install nodejs -y &>>log
check_status
echo -e '\e[32m Add roboshop user\e[0m'
id roboshop &>>log
check_status

echo -e '\e[32m Creating app directory\e[0m'
mkdir -p /app &>>log
check_status

echo -e '\e[32m Download Catalogue content\e[0m'
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>log
check_status
echo -e '\e[32m Remove default content in app directory\e[0m'
rm -rf /app/* &>>log
check_status

cd /app &>>log

unzip /tmp/catalogue.zip &>>log

echo -e '\e[32m NPM install\e[0m'
npm install &>>log
check_status
echo -e '\e[32m Copy catalogue service\e[0m'
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>log
check_status
echo -e '\e[32m Load catalogue service\e[0m'
systemctl daemon-reload &>>log
check_status
echo -e '\e[32m Enable Catalogue\e[0m'
systemctl enable catalogue &>>log
check_status
echo -e '\e[32m Start Catalogue\e[0m'
systemctl start catalogue &>>log
check_status
echo -e '\e[32m Coping Mongodb Repo\e[0m'
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>log
check_status
echo -e '\e[32m Install Mongodb\e[0m'
yum install mongodb-org-shell -y &>>log
check_status
echo -e '\e[32m Load Schema\e[0m'
mongo --host mongodb-dev.devopshemasri.online </app/schema/catalogue.js &>>log
check_status


