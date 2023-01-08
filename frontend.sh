script_location=$(pwd)

echo -e '\e[31m install nginx\e[0m'
yum install nginx -y

systemctl enable nginx

systemctl start nginx

rm -rf /usr/share/nginx/html/*

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

cd /usr/share/nginx/html

unzip /tmp/frontend.zip

cp $script_location/files/reverseproxy-roboshop.conf /etc/nginx/default.d/roboshohp.conf

systemctl restart nginx

