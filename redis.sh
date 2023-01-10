source common.sh
print_head '  Installing Redis Repo  '
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>$log
check_status

print_head 'Dnf enable for redis 6.2'
dnf module enable redis:remi-6.2 -y
check_status

print_head '  Installed redis  '
yum install redis -y &>>$log
check_status

print_head '  Change listing address to 0.0.0.0  '
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>$log
check_status
print_head '  Enable redis  '
systemctl enable redis &>>$log
check_status

print_head '  Restarting Mongodb  '
systemctl start mongod &>>$log
check_status