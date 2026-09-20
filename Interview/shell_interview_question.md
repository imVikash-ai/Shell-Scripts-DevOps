# 🐧 Linux Shell Scripting - Interview Questions & Answers

> A structured Q&A guide covering Linux shell scripting — log rotation, disk monitoring, backups, service management, database backup, cron jobs, and more.


## 1. Automating Log File Rotation

**Question:** In our system, we generate large log files daily. Manually rotating these logs is time-consuming and error-prone. Can you write a shell script to automate log rotation, ensuring logs older than 7 days are archived and deleted?

**Answer:** To automate log rotation, we can create a shell script that archives logs older than 7 days and then deletes them. Here's a sample script:

```bash
#!/bin/bash
# Define the log directory and archive directory
LOG_DIR="/var/log/myapp"
ARCHIVE_DIR="/var/log/myapp/archive"
# Create archive directory if it doesn't exist
mkdir -p $ARCHIVE_DIR
# Find and archive logs older than 7 days
find $LOG_DIR -type f -name "*.log" -mtime +7 -exec gzip {} \; -exec mv {}.gz $ARCHIVE_DIR/ \;
# Delete archived logs older than 30 days
find $ARCHIVE_DIR -type f -name "*.gz" -mtime +30 -exec rm {} \;
```

This script first defines the directories for logs and archives. It then uses 'find' to identify log files older than 7 days, compresses them with 'gzip', and moves them to the archive directory. Finally, it deletes archived logs older than 30 days.

---

## 2. Monitoring Disk Usage

**Question:** Our servers often run into issues with disk space. We need a script that checks disk usage and sends an alert email if usage exceeds 80%. How would you achieve this?

**Answer:** We can create a shell script that checks the disk usage using 'df', and if it exceeds 80%, it sends an email alert using 'mail' or 'sendmail'. Here's an example:

```bash
#!/bin/bash
# Email settings
EMAIL="admin@example.com"
THRESHOLD=80
# Get the disk usage percentage of the root filesystem
USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')
# Check if usage exceeds threshold
if [ $USAGE -gt $THRESHOLD ]; then
echo "Disk usage is at ${USAGE}%. Please take action." | mail -s "Disk Space Alert" $EMAIL
fi
```

This script retrieves the disk usage percentage of the root filesystem. If the usage exceeds the threshold, it sends an email to the specified address.

---

## 3. Automating Backup of Configuration Files

**Question:** We need to ensure daily backups of our configuration files in '/etc'. How would you script this to create a tarball of the '/etc' directory and store it with a timestamp?

**Note:**
Tarball: A tarball is a term used to refer to a compressed archive file created using the tar (tape archive) command in Unix-like operating systems. It's commonly used to bundle multiple files and directories into a single file for easier distribution or backup.

**Answer:** A shell script to create a daily backup of the '/etc' directory and store it with a timestamp can be written as follows:

```bash
#!/bin/bash
# Define the backup directory and timestamp
BACKUP_DIR="/backup"
TIMESTAMP=$(date +%F_%T)
# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR
# Create tarball of the /etc directory
tar -czf $BACKUP_DIR/etc_backup_$TIMESTAMP.tar.gz /etc
# Optionally, delete backups older than 7 days
find $BACKUP_DIR -type f -name "etc_backup_*.tar.gz" -mtime +7 -exec rm {} \;
```

This script creates a tarball of the '/etc' directory with a timestamp and stores it in the backup directory. It also includes an optional line to delete backups older than 7 days.

---

## 4. Checking and Restarting a Service

**Question:** Our web server service occasionally stops unexpectedly. We need a script that checks if the service is running and restarts it if it's not. How would you approach this?

**Answer:** To ensure the web server service is running and restart it if it's not, we can write a script using 'systemctl' or 'service'. Here's an example using 'systemctl' for a service named 'httpd':

```bash
#!/bin/bash
# Define the service name
SERVICE="httpd"
# Check if the service is running
if ! systemctl is-active --quiet $SERVICE; then
# Restart the service
systemctl restart $SERVICE
# Send an alert email
echo "$SERVICE service was down and has been restarted." | mail -s "$SERVICE Service Restarted" admin@example.com
fi
```

This script checks the status of the httpd service. If it's not active, it restarts the service and sends an alert email.

---

## 5. Parsing and Summarizing Log Files

**Question:** We need a script to parse our web server log files and summarize the number of requests per IP address. Can you write a script to achieve this?

**Answer:** We can use 'awk' to parse the log files and summarize the requests per IP address. Here's a sample script for an Apache log file:

```bash
#!/bin/bash
# Define the log file
LOG_FILE="/var/log/httpd/access_log"
# Parse and summarize log file
awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -nr
```

**Explaination:**

1. Define Log File:
   - `LOG_FILE="/var/log/httpd/access_log"`

2. Process Log File:
   - `awk '{print $1}' $LOG_FILE`: Extracts IP addresses.
   - `sort`: Sorts the IP addresses.
   - `uniq -c`: Counts occurrences of each IP.
   - `sort -nr`: Sorts counts in descending order.

**Overall Function:**
- The script reads the Apache access log file and extracts the IP addresses.
- It sorts these IP addresses and counts how many times each one appears.
- Finally, it sorts these counts in descending order to show the most frequent IP addresses accessing the server.

This script checks the status of the httpd service. If it's not active, it restarts the service and sends an alert email.

### Example Output

If the `access_log` contains the following lines:

```
192.168.0.1 - [27/Jul/2024:10:00:00 +0000] "GET /HTTP/1.1" 200 1234
192.168.0.2 - [27/Jul/2024:10:01:00 +0000] "GET /HTTP/1.1" 200 1234
192.168.0.1 - [27/Jul/2024:10:02:00 +0000] "GET /HTTP/1.1" 200 1234
```

The output of the script would be:

```
2 192.168.0.1
1 192.168.0.2
```

This output shows that '192.168.0.1' accessed the server 2 times, while '192.168.0.2' accessed it 1 time.

---

## 6. Automating Database Backup

**Question:** We need daily backups of our MySQL database. Can you provide a shell script to automate this process?

**Answer:** To automate MySQL database backups, we can use 'mysqldump' in a shell script. Here's an example:

```bash
#!/bin/bash
# Database credentials
USER="root"
PASSWORD="password"
DATABASE="mydatabase"
# Define the backup directory and timestamp
BACKUP_DIR="/backup/mysql"
TIMESTAMP=$(date +%F_%T)
# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR
# Perform the database backup
mysqldump -u $USER -p$PASSWORD $DATABASE > $BACKUP_DIR/db_backup_$TIMESTAMP.sql
# Optionally, delete backups older than 7 days
find $BACKUP_DIR -type f -name "db_backup_*.sql" -mtime +7 -exec rm {} \;
```

This script performs a MySQL database backup using 'mysqldump', stores the backup with a timestamp, and includes an optional line to delete backups older than 7 days.

**Explaination:**

```bash
# Perform the database backup
mysqldump -u $USER -p$PASSWORD $DATABASE > $BACKUP_DIR/db_backup_$TIMESTAMP.sql
```

- `mysqldump`:
  - Command to create a backup of a MySQL database.

- `-u $USER`:
  - Specifies the MySQL username.

- `-p$PASSWORD`:
  - Specifies the MySQL password (note: no space after -p).

- `$DATABASE`:
  - Name of the database to back up.

- `>`:
  - Redirects output to a file.

- `$BACKUP_DIR/db_backup_$TIMESTAMP.sql`:
  - Path and filename for the backup, including the timestamp.

---

## 7. Finding and Deleting Large Files

**Question:** Our server's disk space is being consumed by large, old files. We need a script to find and delete files larger than 1GB that are older than 30 days. How would you write this?

**Answer:** We can use 'find' to locate large, old files and delete them. Here's a sample script:

```bash
#!/bin/bash
# Define the directory to search
SEARCH_DIR="/var/log"
# Find and delete large files
find $SEARCH_DIR -type f -size +1G -mtime +30 -exec rm {} \;
```

This script searches the specified directory for files larger than 1GB and older than 30 days, then deletes them.

---

## 8. Scheduling a Script with Cron

**Question:** We have a shell script that needs to run every day at midnight. How would you schedule this script using cron?

**Answer:** To schedule a shell script to run daily at midnight using cron, you need to edit the crontab file. Here's how you can do it:

1. Open the crontab editor:

```bash
crontab -e
```

2. Add the following line to schedule the script:

```bash
0 0 * * * /path/to/your/script.sh
```

This cron job runs the specified script every day at midnight.

**Explaination:**

```
0 0 * * * /path/to/your/script.sh
```

`0 0 * * *`:
- Minute: 0
- Hour: 0
- Day of Month: * (every day)
- Month: * (every month)
- Day of Week: * (every day of the week)

`/path/to/your/script.sh`:
- Path to the script you want to run.

**Result:**
- Schedules the script to run daily at midnight.

---

## 9. Compressing and Transferring Files

**Question:** We need to compress a directory and transfer it to a remote server daily. Can you write a script to automate this process?

**Answer:** We can use 'tar' to compress the directory and 'scp' to transfer it to the remote server. Here's an example script:

```bash
#!/bin/bash
# Define the directory to compress and remote server details
DIR_TO_COMPRESS="/var/data"
REMOTE_SERVER="user@remote.server.com"
REMOTE_DIR="/backup"
TIMESTAMP=$(date +%F_%T)
# Create tarball
tar -czf /tmp/data_backup_$TIMESTAMP.tar.gz $DIR_TO_COMPRESS
# Transfer tarball to remote server
scp /tmp/data_backup_$TIMESTAMP.tar.gz $REMOTE_SERVER:$REMOTE_DIR
# Optionally, delete the local tarball after transfer
rm /tmp/data_backup_$TIMESTAMP.tar.gz
```

This script compresses the specified directory, transfers the tarball to the remote server, and optionally deletes the local tarball after transfer.

---

## 10. Dynamic Configuration Management

**Question:** We need a script to update configuration files dynamically based on the environment (e.g., production or development). How would you write this script?

**Answer:** We can use a template configuration file and replace placeholders with environment-specific values. Here's an example:

```bash
#!/bin/bash
# Define the environment (e.g., production or development)
ENV=$1
# Define configuration file paths
TEMPLATE_CONF="/path/to/template.conf"
TARGET_CONF="/path/to/config.conf"
# Define environment-specific values
if [ "$ENV" == "production" ]; then
    DB_HOST="prod.db.server.com"
    DB_USER="prod_user"
    DB_PASS="prod_pass"
elif [ "$ENV" == "development" ]; then
    DB_HOST="dev.db.server.com"
    DB_USER="dev_user"
    DB_PASS="dev_pass"
else
    echo "Unknown environment: $ENV"
    exit 1
fi
# Replace placeholders in the template and create the target configuration file
sed -e "s/{{DB_HOST}}/$DB_HOST/" -e "s/{{DB_USER}}/$DB_USER/" -e "s/{{DB_PASS}}/$DB_PASS/" $TEMPLATE_CONF > $TARGET_CONF
```

This script compresses the specified directory, transfers the tarball to the remote server, and optionally deletes the local tarball after transfer.

**Explaination:**

```bash
# Replace placeholders in the template and create the target configuration file
sed -e "s/{{DB_HOST}}/$DB_HOST/" -e "s/{{DB_USER}}/$DB_USER/" -e "s/{{DB_PASS}}/$DB_PASS/" $TEMPLATE_CONF > $TARGET_CONF
```

1. `sed`:
   - Stream editor used for text manipulation.

2. `-e`:
   - Option to add a script to be executed by sed.

3. `s/{{DB_HOST}}/$DB_HOST/`:
   - s: Substitute command.
   - `{{DB_HOST}}`: Placeholder to be replaced.
   - `$DB_HOST`: Variable containing the replacement value.

4. `-e "s/{{DB_USER}}/$DB_USER/"`:
   - Similar to the previous substitution, replacing `{{DB_USER}}` with `$DB_USER`.

5. `-e "s/{{DB_PASS}}/$DB_PASS/"`:
   - Similar to the previous substitutions, replacing `{{DB_PASS}}` with `$DB_PASS`.

6. `$TEMPLATE_CONF`:
   - Input file containing the template configuration.

7. `>`:
   - Redirects output to a file.

8. `$TARGET_CONF`:
   - Output file where the modified configuration is saved.

**Result:**
- Replaces placeholders in the template configuration file with actual values from the variables and saves the result in the target configuration file.

---

## 11. System Health Monitoring Script

**Question:** Develop the script that monitors the health of Linux system. It should check CPU usage, memory usage, disk space, and running processes. If any of these metrics exceeds predefined thresholds (e.g. CPU usage > 80%), the script should send an alert to the console or a log file.

**Answer:** Here's a shell script to monitor the health of a Linux system by checking CPU usage, memory usage, disk space, and running processes. The script will send alerts to the console if any metrics exceed predefined thresholds.

```bash
#!/bin/bash
# Define thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

# Function to check CPU usage
check_cpu() {
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "CPU Usage: $CPU_USAGE%"
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
echo "Alert: CPU usage is above ${CPU_THRESHOLD}%"
fi
}

# Function to check memory usage
check_memory() {
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
echo "Memory Usage: $MEM_USAGE%"
if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
echo "Alert: Memory usage is above ${MEM_THRESHOLD}%"
fi
}

# Function to check disk usage
check_disk() {
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')
echo "Disk Usage: $DISK_USAGE%"
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
echo "Alert: Disk usage is above ${DISK_THRESHOLD}%"
fi
}

# Function to check running processes
check_processes() {
PROC_COUNT=$(ps aux | wc -l)
echo "Running Processes: $PROC_COUNT"
# Define a threshold for the number of running processes if needed
}

# Check system health
check_cpu
check_memory
check_disk
check_processes
```

**How the Script Works:**

1. **Thresholds:** The script defines thresholds for CPU, memory, and disk usage.
2. **CPU Usage:** It uses 'top' to get the current CPU usage and compares it to the threshold. If CPU usage exceeds the threshold, it prints an alert.
3. **Memory Usage:** It uses 'free' to calculate memory usage and compares it to the threshold. If memory usage exceeds the threshold, it prints an alert.
4. **Disk Usage:** It uses 'df' to check disk space usage and compares it to the threshold. If disk usage exceeds the threshold, it prints an alert.
5. **Running Processes:** It counts the number of running processes using 'ps' and prints the count. You can set a threshold for the number of processes if needed.

**How to Run the Script:**

1. Save the script to a file, for example, system_health.sh.
2. Make the script executable:

```bash
chmod +x system_health.sh
```

3. Run the script:

```bash
./system_health.sh
```

The script will output the current system metrics and print alerts if any thresholds are exceeded. You can customize the thresholds as needed and extend the script to log alerts to a file instead of printing them to the console.

---

## 12. Automated Backup Solution

**Question:** Write a script to automate the backup of specified directory to a remote server or cloud storage solution. The script should provide a report on the success or failure of the backup operation.

**Answer:** Here's a straightforward shell script to automate the backup of a specified directory to a remote server using 'rsync'. The script also generates a report on the success or failure of the backup operation.

```bash
#!/bin/bash
# Variables
SOURCE_DIR="/path/to/source/directory"  # Directory to backup
REMOTE_SERVER="user@remote.server.com"  # Remote server login
REMOTE_DIR="/path/to/remote/directory"  # Remote directory to store the backup
LOG_FILE="/path/to/log/backup_log.txt"  # Log file for backup report
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
# Create a log file if it doesn't exist
touch $LOG_FILE
# Function to log messages
log_message() {
local MESSAGE=$1
echo "$TIMESTAMP: $MESSAGE" >> $LOG_FILE
}

# Function to perform the backup
perform_backup() {
rsync -avz $SOURCE_DIR $REMOTE_SERVER:$REMOTE_DIR
if [ $? -eq 0 ]; then
log_message "Backup successful: $SOURCE_DIR to $REMOTE_SERVER:$REMOTE_DIR"
echo "Backup successful: $SOURCE_DIR to $REMOTE_SERVER:$REMOTE_DIR"
else
log_message "Backup failed: $SOURCE_DIR to $REMOTE_SERVER:$REMOTE_DIR"
echo "Backup failed: $SOURCE_DIR to $REMOTE_SERVER:$REMOTE_DIR"
fi
}

# Start the backup process
log_message "Starting backup process"
perform_backup
log_message "Backup process completed"

# End of script
```

**Explanation of the Script:**

1. **Variables:** The script defines the following variables:
   - `SOURCE_DIR`: The directory to be backed up.
   - `REMOTE_SERVER`: The remote server login details.
   - `REMOTE_DIR`: The remote directory where the backup will be stored.
   - `LOG_FILE`: The file where the backup report will be logged.
   - `TIMESTAMP`: The current date and time for logging purposes.

2. **Log File Creation:** The script ensures that the log file exists by using 'touch'.

3. **Logging Function:** The 'log_message' function appends messages to the log file with a timestamp.

4. **Backup Function:** The 'perform_backup' function performs the backup using 'rsync' with the '-avz' options for archiving, verbosity, and compression.
   - If the backup is successful (rsync returns 0), it logs and prints a success message.
   - If the backup fails (rsync returns a non-zero status), it logs and prints a failure message.

5. **Backup Process:** The script logs the start of the backup process, calls the 'perform_backup' function, and logs the completion of the backup process.

**How to Use the Script:**

1. Save the Script: Save the script to a file, for example, automated_backup.sh.
2. Make the Script Executable:

```bash
chmod +x automated_backup.sh
```

Run the Script:

```bash
./automated_backup.sh
```

This script provides a basic yet effective automated backup solution and logs the backup process's success or failure, which is essential for system administrators to monitor backup activities.

---

## 13. Log File Analysis

**Answer:** Here's the script for Log File Analysis:

```bash
# Function to find the IP addresses with the most requests
top_ip_addresses() {
echo "IP addresses with the most requests:" >> $REPORT_FILE
awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -nr | head -10 >> $REPORT_FILE
echo "" >> $REPORT_FILE
}

# Create a new report file
echo "Log File Analysis Report" > $REPORT_FILE
echo "------------------------" >> $REPORT_FILE
echo "" >> $REPORT_FILE
# Perform analysis
count_404_errors
most_requested_pages
top_ip_addresses
# Print the report
cat $REPORT_FILE
# End of script
```

**Explanation of the Script:**

1. **Variables:**
   - `LOG_FILE`: The path to the web server log file.
   - `REPORT_FILE`: The path to the report file where the summary will be saved.

2. **Functions:**
   - `count_404_errors`: Counts the number of 404 errors in the log file using 'grep' and 'wc -l', and appends the count to the report file.
   - `most_requested_pages`: Finds the most requested pages by extracting the request URL (7th field in Apache log format) using 'awk', then sorting and counting unique occurrences with 'sort' and 'uniq -c'. The top 10 most requested pages are saved to the report file.
   - `top_ip_addresses`: Identifies the IP addresses with the most requests by extracting the IP address (1st field in Apache log format) using 'awk', then sorting and counting unique occurrences with 'sort' and 'uniq -c'. The top 10 IP addresses are saved to the report file.

3. **Creating the Report File:** The script initializes the report file with a header.
4. **Perform Analysis:** The script calls the defined functions to perform the analysis and appends the results to the report file.
5. **Output the Report:** The script prints the report to the console by using 'cat'.

**How to Use the Script:**

1. Save the Script: Save the script to a file, for example, log_analyzer.sh.
2. Make the Script Executable:

```bash
chmod +x log_analyzer.sh
```

3. Run the Script:

```bash
./log_analyzer.sh
```

This script provides a summarized report of the web server logs, highlighting common patterns such as the number of 404 errors, the most requested pages, and the IP addresses with the most requests. You can further customize the script to include additional log analysis as needed.

---

## 14. Application Health Checker

**Question:** Please write the script that will check the uptime of an application and determine if it is functioning correctly or not. The script must accurately assess the application's status by checking HTTP status codes. It should be able to detect if the application is 'up', meaning it is functioning correctly, or 'down', indicating it is unavailable or not responding.

**Answer:** Here's a script that checks the health of an application by assessing its uptime and HTTP status codes. This script will determine if the application is "up" (functioning correctly) or "down" (unavailable or not responding) based on the HTTP status codes.

```bash
#!/bin/bash
# Variables
URL="http://your-application-url.com"  # URL of the application to check
EXPECTED_STATUS_CODE=200  # Expected HTTP status code for a healthy application
LOG_FILE="/path/to/health_check_log.txt"  # Log file for health check results
# Function to check application health
check_application_health() {
# Send a request to the application and get the HTTP status code
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
# Get the current timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
# Determine if the application is up or down
if [ "$HTTP_STATUS" -eq "$EXPECTED_STATUS_CODE" ]; then
    STATUS="UP"
    echo "$TIMESTAMP: Application is UP. Status code: $HTTP_STATUS" | tee -a $LOG_FILE
else
    STATUS="DOWN"
    echo "$TIMESTAMP: Application is DOWN. Status code: $HTTP_STATUS" | tee -a $LOG_FILE
fi
}
# Perform the health check
check_application_health
# End of script
```

**Explanation of the Script:**

1. **Variables:**
   - `URL`: The URL of the application to check.
   - `EXPECTED_STATUS_CODE`: The expected HTTP status code indicating the application is healthy (usually 200).
   - `LOG_FILE`: The file where the health check results will be logged.

2. **Function:**
   - `check_application_health`: This function performs the health check by sending an HTTP request to the application using curl and retrieving the HTTP status code. It then logs the status of the application along with the current timestamp to the console and a log file.

3. **Health Check Execution:** The script calls the 'check_application_health' function to perform the health check and log the results.

**How to Use the Script:**

1. Save the Script: Save the script to a file, for example, `health_check.sh`.
2. Make the Script Executable:

```bash
chmod +x health_check.sh
```

3. Run the Script:

```bash
./health_check.sh
```

**Customization:**
- **URL:** Change the URL variable to the actual URL of the application you want to check.
- **Expected Status Code:** Modify the EXPECTED_STATUS_CODE variable if the expected healthy status code is different from 200.
- **Log File:** Update the LOG_FILE variable to the desired path for the health check log file.

This script provides a basic but effective way to monitor the uptime of an application by checking its HTTP status code. You can further extend the script to include more sophisticated checks or notifications as needed.

---

> 📝 *Notes compiled from Linux Shell Scripting interview preparation resources.*