script_location=$(pwd)

echo -e '\e[32m install nginx\e[0m'
yum install nginx -y

echo -e '\e[32m enable nginx\e[0m'
systemctl enable nginx

echo -e '\e[32m start nginx\e[0m'
systemctl start nginx

echo -e '\e[32m install nginx\e[0m'
rm -rf /usr/share/nginx/html/*

echo -e '\e[32m download frontend content\e[0m'
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

cd /usr/share/nginx/html

echo -e '\e[32m Unzipping the frontend content\e[0m'
unzip /tmp/frontend.zip

echo -e '\e[32m Coping reverse proxy conf \e[0m'
cp $script_location/files/reverseproxy-roboshop.conf /etc/nginx/default.d/roboshohp.conf

echo -e '\e[32m restarting nginx\e[0m'
systemctl restart nginx

