script_location=$(pwd)
log=/tmp/roboshop.logs
echo -e '\e[32m Configuring nodejs \e[0m'
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Conguration nodejs success \e[0m'
else
  echo -e '\e[35m Conguration nodejs Fail \e[0m'
fi
echo -e '\e[32m Install Node JS\e[0m'
yum install nodejs -y &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Install Node JS success \e[0m'
else
  echo -e '\e[35m Install Node JS Fail \e[0m'
fi
echo -e '\e[32m Add roboshop user\e[0m'
id roboshop &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[31m roboshop user already exists \e[0m'
else
  useradd roboshop
fi
useradd roboshop &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Add roboshop user success \e[0m'
else
  echo -e '\e[35m Add roboshop user Fail \e[0m'
fi
echo -e '\e[32m Creating app directory\e[0m'
mkdir -p /app &>>log
if [ $? -eq 0 ]
    then
      echo -e '\e[35m Creating app directory success \e[0m'
    else
      echo -e '\e[35m Creating app directory Fail \e[0m'
    fi

echo -e '\e[32m Download Catalogue content\e[0m'
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Download Catalogue content success \e[0m'
else
  echo -e '\e[35m Download Catalogue content Fail \e[0m'
fi
echo -e '\e[32m Remove default content in app directory\e[0m'
rm -rf /app/* &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Remove default content in app directory success \e[0m'
else
  echo -e '\e[35m Remove default content in app directory Fail \e[0m'
fi

cd /app &>>log

unzip /tmp/catalogue.zip &>>log

echo -e '\e[32m NPM install\e[0m'
npm install &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m NPM install success \e[0m'
else
  echo -e '\e[35m NPM install Fail \e[0m'
fi
echo -e '\e[32m Copy catalogue service\e[0m'
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Copy catalogue service success \e[0m'
else
  echo -e '\e[35m Copy catalogue service Fail \e[0m'
fi
echo -e '\e[32m Load catalogue service\e[0m'
systemctl daemon-reload &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Load catalogue service success \e[0m'
else
  echo -e '\e[35m Load catalogue service Fail \e[0m'
fi
echo -e '\e[32m Enable Catalogue\e[0m'
systemctl enable catalogue &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Enable Catalogue success \e[0m'
else
  echo -e '\e[35m Enable Catalogue Fail \e[0m'
fi
echo -e '\e[32m Start Catalogue\e[0m'
systemctl start catalogue &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Start Catalogue success \e[0m'
else
  echo -e '\e[31m Start Catalogue Fail \e[0m'
fi
echo -e '\e[32m Coping Mongodb Repo\e[0m'
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Coping Mongodb Repo success \e[0m'
else
  echo -e '\e[31m Coping Mongodb Repo Fail \e[0m'
fi
echo -e '\e[32m Install Mongodb\e[0m'
yum install mongodb-org-shell -y &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Mongodb-org-shell installation success  \e[0m'
else
  echo -e '\e[31m Mongodb-org-shell installation Fail \e[0m'
fi
echo -e '\e[32m Load Schema\e[0m'
mongo --host mongodb-dev.devopshemasri.online </app/schema/catalogue.js &>>log
if [ $? -eq 0 ]
then
  echo -e '\e[35m Schema Loaded Success \e[0m'
else
  echo -e '\e[31m Schema Loaded Fail \e[0m'
fi

