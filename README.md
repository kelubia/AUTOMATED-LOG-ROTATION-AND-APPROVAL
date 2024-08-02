# AUTOMATED-LOG-ROTATION-AND-APPROVAL
Scenario:
I was tasked with creating a bash script to automate the deletion of unnecessary Java application logs. These logs, used by the client to debug application-level errors, must be managed to free up space on the server and prevent system slowdowns. The script is designed to delete logs older than 15 days to one month and is scheduled to run automatically at midnight. Additionally, it notifies the admin and requests approval before execution.

Steps Involved:
Script Creation:

1-I wrote a bash script that identifies and deletes Java application logs older than 15 days.
The script includes logic to filter logs by date and select only those that meet the criteria for deletion.
![Screenshot (48)](https://github.com/user-attachments/assets/d725b97c-df35-4fb2-acd2-26b931ba7608)

![Screenshot (49)](https://github.com/user-attachments/assets/92a50b5e-5cb2-4a05-8273-73b3593d5587)

2-Scheduling with Cron:
I scheduled the script to run automatically at midnight using a cron job.
I added the following entry to the crontab file:

0 0 * * * /path/to/script.sh

3-Notification and Approval:
Before executing the deletion, the script sends an email notification to the admin requesting approval.
The admin reviews the request and provides approval, ensuring oversight and preventing accidental data loss.

Execution and Space Management:
Once approved, the script executes, deleting the specified logs.
This automated process helps maintain optimal server performance by freeing up space and preventing system slowdowns.

Benefits:
Efficiency: Automates routine maintenance tasks, saving time and effort.
Performance: Ensures the server remains responsive by managing disk space effectively.
Oversight: Incorporates a notification and approval mechanism to prevent unintended deletions.
