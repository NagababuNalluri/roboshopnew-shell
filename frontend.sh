source common.sh

print_head 'install nginx'
yum install nginx -y &>>${log}
check_status
print_head 'enable nginx'
systemctl enable nginx &>>${log}
check_status
print_head 'start nginx'
systemctl start nginx &>>${log}
check_status
print_head 'Remove default content'
rm -rf /usr/share/nginx/html/* &>>${log}
check_status
print_head 'download frontend content'
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}
check_status
print_head 'Changing directory '
cd /usr/share/nginx/html &>>${log}
check_status
print_head 'Unzipping the frontend content'
unzip /tmp/frontend.zip &>>${log}
check_status
print_head 'Coping reverse proxy conf '
cp $script_location/files/reverseproxy-roboshop.conf /etc/nginx/default.d/roboshohp.conf &>>${log}
check_status
print_head 'restarting nginx'
systemctl restart nginx &>>${log}
check_status
