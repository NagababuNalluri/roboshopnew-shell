source common.sh
  print_head ' Configuring nodejs '
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log
check_status
  print_head ' Install Node JS'
yum install nodejs -y &>>log
check_status
  print_head ' Add roboshop user'
id roboshop &>>log
if [ $? -ne 0 ]
then
  useradd roboshop
    fi
check_status

  print_head ' Creating app directory'
mkdir -p /app &>>log
check_status

  print_head ' Download user content'
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>log
check_status
  print_head ' Remove default content in app directory'
rm -rf /app/* &>>log
check_status

cd /app &>>log

unzip /tmp/user.zip &>>log

  print_head ' NPM install'
npm install &>>log
check_status
  print_head ' Copy user service'
cp ${script_location}/files/user.service /etc/systemd/system/user.service &>>log
check_status
  print_head ' Load user service'
systemctl daemon-reload &>>log
check_status
  print_head ' Enable user'
systemctl enable user &>>log
check_status
  print_head ' Start user'
systemctl start user &>>log
check_status
  print_head ' Coping Mongodb Repo'
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>log
check_status
  print_head ' Install Mongodb'
yum install mongodb-org-shell -y &>>log
check_status
  print_head ' Load Schema'
mongo --host mongodb-dev.devopshemasri.online </app/schema/user.js &>>log
check_status


