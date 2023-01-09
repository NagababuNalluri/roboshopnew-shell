source common.sh

echo -e '\e[32m install nginx\e[0m'
yum install nginx -y &>>${log}

check_status

echo -e '\e[32m enable nginx\e[0m'
systemctl enable nginx &>>${log}
check_status

echo -e '\e[32m start nginx\e[0m'
systemctl start nginx &>>${log}
check_status
echo -e '\e[32m Remove default content\e[0m'
rm -rf /usr/share/nginx/html/* &>>${log}
check_status
echo -e '\e[32m download frontend content\e[0m'
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}
check_status
echo -e '\e[32m Changing directory \e[0m'
cd /usr/share/nginx/html &>>${log}
check_status
echo -e '\e[32m Unzipping the frontend content\e[0m'
unzip /tmp/frontend.zip &>>${log}
check_status
echo -e '\e[32m Coping reverse proxy conf \e[0m'
cp $script_location/files/reverseproxy-roboshop.conf /etc/nginx/default.d/roboshohp.conf &>>${log}
check_status
echo -e '\e[32m restarting nginx\e[0m'
systemctl restart nginx &>>${log}
check_status
