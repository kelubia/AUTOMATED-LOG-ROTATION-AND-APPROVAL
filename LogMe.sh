#!bin/bash

#Configuration
 
LOG_DIR="/Home/Documents"
ADMIN_EMAIL="Kelubiadmin@gmail.com"
FILE_LOGS="Documents/logMe/Deleted_logs.log"
ADMIN_APPROVAL="/tmp/log_cleanup_approval.txt"

echo "$(date): Log cleaup script started" >> $FILE_LOGS

# Find logs older than 15 days
OLD_LOGS=$(find "$LOG_DIR" -type f -name "*.log" -mtime +15)

if [ -z "$OLD_LOGS" ]; then
	echo "$(date): No log files older than 15 days found in $LOG_DIR" >> $FILE_LOGS
	exit 0
fi

# Notify and request aproval from Admin

echo "The following files are older than 15 days and scheduled for deletation:" > $APPROVAL_FILE
echo "$OLD_LOGS" >> $APPROVAL_FILE
echo -e "\nPlease reply with 'yes' to approve deletation or 'no' to cancel" >> $APPROVAL_FILE

mail -s "Log Cleanup Approval Request" $ADMIN_EMAIL < $APPROVAL_FILE

# wait for approval from admin (polling for the response in a loop)
echo "$(date): Waiting for admin approval.... " >> $FILE_LOG

while true; do
	if [-f "$APPROVAL_FILE.response" ]; then
		RESPONSE=$(cat "$APPROVAL_FILE.response")
		if [ "$RESPONSE" == "yes" ]; then
			echo "$(date): Admin approved deletation" >> $FILE_LOGS
			# Delete old log files
			find "$LOG_DIR" -type f -name "*.log" -mtime +15 -exec rm -f {} \;
			echo "$(date): deleted logs older than 15 days in $LOG_DIR" >> $FILE_LOGS
		else 
			echo "$(date): Admin denied deletation" >> $FILE_LOGS

		fi
		rm -f "APPROVED_FILES.response"
		break
	fi
	sleep 60
done

echo "$(date): Log cleanup script completed" >> $FILE_LOGS	
