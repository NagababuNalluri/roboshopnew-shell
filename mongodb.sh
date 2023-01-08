script_location=$(pwd)

echo -e '\e[32m Setting mongodb repo\e[0m'
cp "$script_location"/files/mongodb.repo /etc/yum.repos.d/mongodb.repo

echo -e '\e[32m Installed mongodb\e[0m'
yum install mongodb-org -y

echo -e '\e[32m Enable Mongodb\e[0m'
systemctl enable mongod

echo -e '\e[32m Start Mongodb\e[0m'
systemctl start mongod

echo -e '\e[32m Change listing address to 0.0.0.0\e[0m'
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e '\e[32m restarting Mongodb\e[0m'
systemctl restart mongod