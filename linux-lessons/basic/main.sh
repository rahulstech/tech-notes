friends=()
read -p "Enter Best Friend: " friend
friends+=($friend)
read -p "Enter Girl Friend: " friend
friends+=($friend)
echo ${friends[*]}
