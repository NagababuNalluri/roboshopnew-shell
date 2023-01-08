script_location=$(pwd)

cp "$script_location"/files/mongodb.conf /etc/yum.repos.d/mongodb.repo

yum install mongodb-org -y