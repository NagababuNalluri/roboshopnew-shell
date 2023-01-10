script_location=$(pwd)
log=/tmp/roboshop.logs

print_head() {
  echo -e "\e[1m $1 \e[0m"
}

check_status() {
  if [ $? -eq 0 ]
then
  echo -e '\e[1;33m success\e[0m'
  else
    echo -e '\e[1;34m Fail\e[0m'
    echo 'Refer log files for more info log-${log}'
    exit
    fi
    }

