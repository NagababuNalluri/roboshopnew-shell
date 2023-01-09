script_location=$(pwd)

echo -e '\e[32m Setting mongodb repo\e[0m'
cp "$script_location"/files/mongodb.repo /etc/yum.repos.d/mongodb.repo
if [ $? -eq 0 ]
then
  echo -e '\e[35m Command Execution Success \e[0m'
  else
    echo -e '\e[35m Command Execution Failed \e[0m'
  fi

echo -e '\e[32m Installed mongodb\e[0m'
yum install mongodb-org -y
if [ $? -eq 0 ]
then
  echo -e '\e[35m Command Execution Success \e[0m'
  else
    echo -e '\e[35m Command Execution Failed \e[0m'
  fi
echo -e '\e[32m Enable Mongodb\e[0m'
systemctl enable mongod
if [ $? -eq 0 ]
then
  echo -e '\e[35m Command Execution Success \e[0m'
  else
    echo -e '\e[35m Command Execution Failed \e[0m'
  fi
echo -e '\e[32m Start Mongodb\e[0m'
systemctl start mongod
if [ $? -eq 0 ]
then
  echo -e '\e[35m Command Execution Success \e[0m'
  else
    echo -e '\e[35m Command Execution Failed \e[0m'
  fi
echo -e '\e[32m Change listing address to 0.0.0.0\e[0m'
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
if [ $? -eq 0 ]
then
  echo -e '\e[35m Command Execution Success \e[0m'
  else
    echo -e '\e[35m Command Execution Failed \e[0m'
  fi
echo -e '\e[32m restarting Mongodb\e[0m'
systemctl restart mongod
if [ $? -eq 0 ]
then
  echo -e '\e[35m Command Execution Success \e[0m'
  else
    echo -e '\e[35m Command Execution Failed \e[0m'
  fi