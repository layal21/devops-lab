#!/bin/bash

#Extract the following fields : IPs, Requested paths, Status code, User Agent
awk '{print $1,$7,$9}' nginx-access.log | sort  > nginx_log_analyser.txt

#!/bin/bash

file="nginx_log_analyzer.txt"  # Replace with your actual file

# Extract and count IPs
echo "Top 5 IPs:"
awk '{print $1}' "$file" | sort | uniq -c | sort -rn | head -n 5 | awk '{print $2 " - " $1 " requests"}' 
echo 

# Extract and count paths
echo "Top 5 Paths:"
awk '{print $2}' "$file" | sort | uniq -c | sort -rn | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo

# Extract and count status codes
echo "Top 5 Status Codes:"
awk '{print $3}' "$file" | sort | uniq -c | sort -rn | head -n 5 | awk '{print $2 " - " $1 " requests"}'