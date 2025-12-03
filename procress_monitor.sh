app="./app.sh"
log_file="guard.logs"
check_interval=5

log_entry() {
	timestamp=$(date '+%H:%M:%S %d-%m-%Y')
	echo "$timestamp -$1" >> "$log_file"
}

check_process() {
	pgrep -f app.sh > /dev/null 2>&1
	if [ $? -eq 0 ]; then
	  log_entry "[INFO]: APPLICATION RUNNING"
	  return 0
	else
	  log_entry "[WARNING]: APPLICATION STOPPED"
	  return 1
	fi
}

restart_process() {
	nohup $app &
	if [ $? -eq 0 ]; then
	  log_entry "[INFO]: APPLICATION RESTARTING"
	  log_entry "[INFO]: RESTART SUCCESSFUL"
	  return 0
	else
	  log_entry "[ERROR]: RESTART FAILED"
	  return 1
	fi
}

echo "Starting process guard"
echo "Checking every $check_interval seconds..."
echo ""

while true; do
	check_process
	if [ $? -eq 0 ]; then
	  echo "Application Running"
	else
	  restart_process
	rs=$?
	echo "Application Stopped Restarting Application...."
		if [ $rs -eq 0 ]; then
		  echo "Application Restart Successful"
		else
		  echo "Application Restart Failed"
		fi
	fi
	sleep $check_interval
done
