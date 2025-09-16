friends=()
read -p "Enter Best Friend: " friend # to show a prompt before before read use -p
friends+=($friend)
read -p "Enter Girl Friend: " friend
friends+=($friend)
echo ${friends[*]}
