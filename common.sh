script_location=$(pwd)
log=/tmp/roboshop.logs

check_status() {
  if [ $? -eq 0 ]
then
  echo -e '\e[32m success\e[0m'
  else
    echo -e '\e[31m Fail\e[0m'
    fi
    }

