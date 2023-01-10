source common.sh
print_head '  Setting mongodb repo  '
cp "$script_location"/files/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$log
check_status

print_head '  Installed mongodb  '
yum install mongodb-org -y &>>$log
check_status
print_head '  Enable Mongodb  '
systemctl enable mongod &>>$log
check_status
print_head '  Start Mongodb  '
systemctl start mongod &>>$log
check_status
print_head '  Change listing address to 0.0.0.0  '
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$log
check_status
print_head '  restarting Mongodb  '
systemctl restart mongod &>>$log
check_status