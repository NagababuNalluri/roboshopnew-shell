script_location=$(pwd)
log=/tmp/roboshop.logs
echo -e '\e[32m Configuring nodejs \e[0m'
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Conguration nodejs success \e[0m'
esle
  echo -e '\e[35m Conguration nodejs Fail \e[0m'
fi
echo -e '\e[32m Install Node JS\e[0m'
yum install nodejs -y &>>log
echo -e '\e[32m Add roboshop user\e[0m'
useradd roboshop &>>log
echo -e '\e[32m Creating app directory\e[0m'
mkdir -p /app &>>log

echo -e '\e[32m Download Catalogue content\e[0m'
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>log
echo -e '\e[32m Remove default content in app directory\e[0m'
rm -rf /app/* &>>log

cd /app &>>log

unzip /tmp/catalogue.zip &>>log

echo -e '\e[32m NPM install\e[0m'
npm install &>>log
echo -e '\e[32m Copy catalogue service\e[0m'
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>log
echo -e '\e[32m Load catalogue service\e[0m'
systemctl daemon-reload &>>log
echo -e '\e[32m Enable Catalogue\e[0m'
systemctl enable catalogue &>>log
echo -e '\e[32m Start Catalogue\e[0m'
systemctl start catalogue &>>log
echo -e '\e[32m Coping Mongodb Repo\e[0m'
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>log
echo -e '\e[32m Install Mongodb\e[0m'
yum install mongodb-org-shell -y &>>log
echo -e '\e[32m Load Schema\e[0m'
mongo --host mongodb-dev.devopshemasri.online </app/schema/catalogue.js &>>log


