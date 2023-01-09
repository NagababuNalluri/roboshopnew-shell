script_location=$(pwd)
log=/tmp/roboshop.logs
echo -e '\e[32m install nginx\e[0m'
yum install nginx -y &>>${log}
echo '$?'

echo -e '\e[32m enable nginx\e[0m'
systemctl enable nginx &>>${log}

echo -e '\e[32m start nginx\e[0m'
systemctl start nginx &>>${log}

echo -e '\e[32m install nginx\e[0m'
rm -rf /usr/share/nginx/html/* &>>${log}

echo -e '\e[32m download frontend content\e[0m'
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}

cd /usr/share/nginx/html &>>${log}

echo -e '\e[32m Unzipping the frontend content\e[0m'
unzip /tmp/frontend.zip &>>${log}

echo -e '\e[32m Coping reverse proxy conf \e[0m'
cp $script_location/files/reverseproxy-roboshop.conf /etc/nginx/default.d/roboshohp.conf &>>${log}

echo -e '\e[32m restarting nginx\e[0m'
systemctl restart nginx &>>${log}

